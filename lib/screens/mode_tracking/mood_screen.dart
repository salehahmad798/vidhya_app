import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:vidhya_app/main.dart';
import 'package:vidhya_app/screens/mode_tracking/mood_tracking_model.dart';

import 'package:vidhya_app/utils/app_colors.dart';
import 'package:vidhya_app/utils/app_images.dart';
import 'package:vidhya_app/widgets/custom_appbar.dart';
import 'package:vidhya_app/widgets/custom_text.dart';
import 'package:vidhya_app/widgets/primary_button.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class MoodScreen extends StatefulWidget {
  final DateTime selectedDate;
  final VoidCallback onUpdate;
  const MoodScreen({
    super.key,
    required this.selectedDate,
    required this.onUpdate,
  });

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  final List _selections = [
    'Nervous',
    'Anxious',
    'Happy',
    'Sad',
    'Stressed',
    'Angry',
  ];
  final List<String> myActSelfCare = ["Cooking", "Walk", "Bath", "Other"];
  List<String> selectedFeeling=[];
  List<String> selectedSelfCare=[];
  TextEditingController customFeelLikeController = TextEditingController();
  FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  String? _audioPath;
  bool _isRecording = false;
  String _recordingDuration = '00:00:00'; // Timer to display recording duration
  Timer? _timer; // Track the timer

  @override
  void initState() {
    super.initState();
    _initRecorder();
  }

  Future<void> _requestPermissions() async {
    var status = await Permission.microphone.status;

    // Check if microphone permission is granted
    if (status.isGranted) {
      return; // If already granted, just return
    }

    // If permission is denied or restricted, request it
    if (status.isDenied || status.isRestricted) {
      var newStatus = await Permission.microphone.request();

      if (!newStatus.isGranted) {
        // Show a toast or alert when permission is denied
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Microphone permission is required to record audio.')),
        );
      }
    }

    // Handle permanent denial where the user has to go to app settings
    if (status.isPermanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Microphone permission is permanently denied. Please enable it in app settings.'),
          action: SnackBarAction(
            label: 'Settings',
            onPressed: () {
              openAppSettings(); // This will open the app's settings page
            },
          ),
        ),
      );
    }
  }



  Future<void> _initRecorder() async {
    await _recorder.openRecorder();
    Directory tempDir = await getTemporaryDirectory();
    _audioPath = '${tempDir.path}/mood_recording.aac';
  }

  Future<void> _toggleRecording() async {
    await _requestPermissions();  // Make sure permission is handled

    // Check if permission is granted
    if (await Permission.microphone.isGranted) {
      if (_isRecording) {
        await _stopRecording();
      } else {
        await _startRecording();
      }
    } else {
      // Inform the user that permission is needed
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Microphone permission is required to start recording.')),
      );
    }
  }


  Future<void> _startRecording() async {
    await _recorder.startRecorder(toFile: _audioPath);
    setState(() {
      _isRecording = true;
      _recordingDuration = '00:00:00';
    });
    _startRecordingTimer();
  }

  Future<void> _stopRecording() async {
    await _recorder.stopRecorder();
    _timer?.cancel();
    setState(() {
      _isRecording = false;
      _recordingDuration = '00:00:00'; // Reset timer when stopped
    });
    debugPrint('Recording saved at: $_audioPath');
  }

  void _startRecordingTimer() {
    Duration duration = const Duration(seconds: 0);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isRecording) {
        duration += const Duration(seconds: 1);
        setState(() {
          _recordingDuration = DateFormat('HH:mm:ss').format(
              DateTime.fromMillisecondsSinceEpoch(duration.inMilliseconds));
        });
      } else {
        timer.cancel();
      }
    });
  }

  void saveData() {
    // Create a new MoodTrackingModel instance
    MoodTrackingModel data = MoodTrackingModel(
      feeling: selectedFeeling,
      reason: customFeelLikeController.text,
      selfCare: selectedSelfCare,
      voiceNotePath: _audioPath ?? '', // Save the path to the model
      date: widget.selectedDate,
    );

    // Convert the data to JSON format
    Map<String, dynamic> dataJson = data.toJson();

    // Retrieve the existing list from storage
    List<dynamic> existingListDynamic = storage.read('MoodList') ?? [];

    // Cast the dynamic list to a List<Map<String, dynamic>>
    List<Map<String, dynamic>> existingList =
    existingListDynamic.cast<Map<String, dynamic>>();

    // Add the new data to the existing list
    existingList.add(dataJson);

    // Save the updated list back into storage
    storage.write('MoodList', existingList);
    debugPrint("hello");
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        image: AppImaes.applogo,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Center(
                  child: CText(
                    text: "Mood",
                    fontSize: 20,
                    alignText: TextAlign.start,
                    fontWeight: FontWeight.w700,
                    color: Colors.green,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                      color: Colors.green,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Center(
                  child: CText(
                    text: 'How do you feel today?',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.green,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                      color: Colors.green,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _selections.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return checkboxWidget(
                        text: _selections[index],
                        checkString: selectedFeeling,
                        onTap: () {
                          if (selectedFeeling.contains(_selections[index])) {
                            selectedFeeling.remove(_selections[index]);
                          } else {
                            selectedFeeling.add(_selections[index]);
                          }

                          setState(() {});
                        });
                  },
                ),
                SizedBox(height: 20.h),
                Center(
                  child: CText(
                    text: 'I feel like this because :',
                    fontSize: 20,
                    maxLines: 2,
                    alignText: TextAlign.center,
                    fontWeight: FontWeight.w700,
                    color: Colors.green,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                      color: Colors.green,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                    width: 100.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      color: AppColors.primarywhiteColor.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(alignment: Alignment.center, children: [
                      GestureDetector(
                        onTap: _toggleRecording,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CText(
                              text:
                              _isRecording ? 'Recording...' : 'Audio entry',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: _isRecording
                                  ? Colors.red
                                  : Colors.blue.withOpacity(0.5),
                            ),
                            Icon(
                              _isRecording ? Icons.stop : Icons.mic,
                              color: Colors.black,
                              size: 40,
                            ),
                            if (_isRecording)
                              CText(
                                text: _recordingDuration,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.green,
                              ),
                          ],
                        ),
                      ),
                    ])),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  width: 100.w,
                  height: 30.h,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20)),
                  child: CText(
                    text: 'Type entry',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.withOpacity(0.5),
                  ),
                ),

                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(12)),
                    child: TextField(
                      controller: customFeelLikeController,
                      style: TextStyle(color: Colors.black54),
                      cursorColor: Colors.blue,
                      maxLines: 2,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Write reason here...'),
                    )),
                SizedBox(height: 20.h),
                Center(
                  child: CText(
                    text: 'My act of self care :',
                    fontSize: 20,
                    maxLines: 2,
                    alignText: TextAlign.center,
                    fontWeight: FontWeight.w700,
                    color: Colors.green,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                      color: Colors.green,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: myActSelfCare.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 7 days in a week
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return checkboxWidget(
                        text: myActSelfCare[index],
                        checkString: selectedSelfCare,
                        onTap: () {
                          if (selectedSelfCare.contains(myActSelfCare[index])) {
                            selectedSelfCare.remove(myActSelfCare[index]) ;
                          } else {
                            selectedSelfCare.add(myActSelfCare[index]) ;

                          }

                          setState(() {});
                        });
                  },
                ),
                SizedBox(height: 20.h),

                PrimaryButton(
                  text: 'Save Mood',
                  onTap:(){
                    saveData();
                      widget.onUpdate();
                      Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget checkboxWidget(
      {String text = '', List<String> checkString=const [], VoidCallback? onTap}) {
    return SizedBox(
      height: 50.h,
      child: Column(
        children: [
          Center(
            child: InkWell(
              onTap: onTap,
              child: Container(
                height: 55.h,
                width: 55.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
                child: Icon(
                  checkString.contains(text)
                      ? Icons.check
                      : Icons.check_box_outline_blank,
                  size: 30.0,
                  color: checkString.contains(text) ? Colors.white : Colors.green,
                ),
              ),
            ),
          ),
          CText(
            text: text,
            alignText: TextAlign.center,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}


// import 'dart:async';
// import 'dart:io';
// import 'package:intl/intl.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import 'package:vidhya_app/main.dart';
// import 'package:vidhya_app/screens/mode_tracking/mood_tracking_model.dart';
//
// import 'package:vidhya_app/utils/app_colors.dart';
// import 'package:vidhya_app/utils/app_images.dart';
// import 'package:vidhya_app/widgets/custom_appbar.dart';
// import 'package:vidhya_app/widgets/custom_text.dart';
// import 'package:vidhya_app/widgets/primary_button.dart';
// import 'package:flutter_sound/flutter_sound.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class MoodScreen extends StatefulWidget {
//   final DateTime selectedDate;
//   final VoidCallback onUpdate;
//   const MoodScreen({
//     super.key,
//     required this.selectedDate,
//     required this.onUpdate,
//   });
//
//   @override
//   State<MoodScreen> createState() => _MoodScreenState();
// }
//
// class _MoodScreenState extends State<MoodScreen> {
//   final List _selections = [
//     'Nervous',
//     'Anxious',
//     'Happy',
//     'Sad',
//     'Stressed',
//     'Angry',
//   ];
//   final List<String> myActSelfCare = ["Cooking", "Walk", "Bath", "Other"];
//   List<String> selectedFeeling=[];
//   List<String> selectedSelfCare=[];
//   TextEditingController customFeelLikeController = TextEditingController();
//   FlutterSoundRecorder _recorder = FlutterSoundRecorder();
//   String? _audioPath;
//   bool _isRecording = false;
//   String _recordingDuration = '00:00:00'; // Timer to display recording duration
//
//   @override
//   void initState() {
//     super.initState();
//     _initRecorder();
//   }
//   Future<void> _requestPermissions() async {
//     final status = await Permission.microphone.request();
//     if (status.isGranted) {
//       // Permissions are granted, proceed with recording
//     } else {
//
//       // Permissions are not granted, handle the error
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Microphone permission is required to record audio.')),
//       );
//     }
//   }
//   Future<void> _initRecorder() async {
//     await _recorder.openRecorder();
//     Directory tempDir = await getTemporaryDirectory();
//     _audioPath = '${tempDir.path}/mood_recording.aac';
//   }
//
//   Future<void> _toggleRecording() async {
//     await _requestPermissions();
//     if (_isRecording) {
//       await _recorder.stopRecorder();
//       setState(() {
//         _isRecording = false;
//         _recordingDuration = '00:00:00'; // Reset timer when stopped
//       });
//       // Generate and display link or path to the recording file
//       print('Recording saved at: $_audioPath');
//     } else {
//       await _recorder.startRecorder(toFile: _audioPath);
//       setState(() {
//         _isRecording = true;
//         _recordingDuration = '00:00:00'; // Reset timer when starting
//       });
//       // Start a timer to track recording duration
//       _startRecordingTimer();
//     }
//   }
//
//   void _startRecordingTimer() {
//     // Timer to update recording duration every second
//     Duration duration = const Duration(seconds: 0);
//     Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (_isRecording) {
//         duration = duration + const Duration(seconds: 1);
//         setState(() {
//           _recordingDuration = DateFormat('HH:mm:ss').format(
//               DateTime.fromMillisecondsSinceEpoch(duration.inMilliseconds));
//         });
//       } else {
//         timer.cancel();
//       }
//     });
//   }
//
//   Future<void> _startRecording() async {
//     await _recorder.startRecorder(toFile: _audioPath);
//   }
//
//   Future<void> _stopRecording() async {
//     await _recorder.stopRecorder();
//   }
//
//   void saveData() {
//     // Create a new MoodTrackingModel instance
//     MoodTrackingModel data = MoodTrackingModel(
//       feeling: selectedFeeling,
//       reason: customFeelLikeController.text,
//       selfCare: selectedSelfCare,
//       voiceNotePath: _audioPath ?? '', // Save the path to the model
//       date: widget.selectedDate,
//     );
//
//     // Convert the data to JSON format
//     Map<String, dynamic> dataJson = data.toJson();
//
//     // Retrieve the existing list from storage
//     List<dynamic> existingListDynamic = storage.read('MoodList') ?? [];
//
//     // Cast the dynamic list to a List<Map<String, dynamic>>
//     List<Map<String, dynamic>> existingList =
//     existingListDynamic.cast<Map<String, dynamic>>();
//
//     // Add the new data to the existing list
//     existingList.add(dataJson);
//
//     // Save the updated list back into storage
//     storage.write('MoodList', existingList);
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: const CustomAppBar(
//         image: AppImaes.applogo,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 22),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 20.h),
//                 Center(
//                   child: CText(
//                     text: "Mood",
//                     fontSize: 20,
//                     alignText: TextAlign.start,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.green,
//                     style: const TextStyle(
//                       fontStyle: FontStyle.italic,
//                       decoration: TextDecoration.underline,
//                       color: Colors.green,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20.h),
//                 Center(
//                   child: CText(
//                     text: 'How do you feel today?',
//                     fontSize: 16,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.green,
//                     style: const TextStyle(
//                       fontStyle: FontStyle.italic,
//                       decoration: TextDecoration.underline,
//                       color: Colors.green,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20.h),
//                 GridView.builder(
//                   physics: const NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: _selections.length,
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3, // 7 days in a week
//                     childAspectRatio: 1,
//                   ),
//                   itemBuilder: (context, index) {
//                     return checkboxWidget(
//                         text: _selections[index],
//                         checkString: selectedFeeling,
//                         onTap: () {
//                           if (selectedFeeling.contains(_selections[index])) {
//                             selectedFeeling.remove( _selections[index]);
//                           } else {
//                             selectedFeeling.add(_selections[index]);
//                           }
//
//                           setState(() {});
//                         });
//                   },
//                 ),
//                 SizedBox(height: 20.h),
//                 Center(
//                   child: CText(
//                     text: 'I feel like this because :',
//                     fontSize: 20,
//                     maxLines: 2,
//                     alignText: TextAlign.center,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.green,
//                     style: const TextStyle(
//                       fontStyle: FontStyle.italic,
//                       decoration: TextDecoration.underline,
//                       color: Colors.green,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20.h),
//                 Container(
//                     width: 100.w,
//                     height: 100.h,
//                     decoration: BoxDecoration(
//                       color: AppColors.primarywhiteColor.withOpacity(0.8),
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: Stack(alignment: Alignment.center, children: [
//                       GestureDetector(
//                         onTap: _toggleRecording,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             CText(
//                               text:
//                                   _isRecording ? 'Recording...' : 'Audio entry',
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600,
//                               color: _isRecording
//                                   ? Colors.red
//                                   : Colors.blue.withOpacity(0.5),
//                             ),
//                             Icon(
//                               _isRecording ? Icons.stop : Icons.mic,
//                               color: Colors.black,
//                               size: 40,
//                             ),
//                             if (_isRecording)
//                               CText(
//                                 text: _recordingDuration,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.green,
//                               ),
//                           ],
//                         ),
//                       ),
//                     ])),
//                 SizedBox(
//                   height: 10.h,
//                 ),
//                 Container(
//                   width: 100.w,
//                   height: 30.h,
//                   decoration: BoxDecoration(
//                       color: Colors.transparent,
//                       borderRadius: BorderRadius.circular(20)),
//                   child: CText(
//                     text: 'Type entry',
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                     color: Colors.blue.withOpacity(0.5),
//                   ),
//                 ),
//                 Container(
//                   // width: 100.w,
//                   padding:const EdgeInsets.symmetric(horizontal: 16,vertical: 5),
//                   // height: 100.h,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(20)),
//                   child: TextFormField(controller:customFeelLikeController ,
//                     style: const TextStyle(color: Colors.black),
//                     decoration:const InputDecoration(
//
//                       border: InputBorder.none, // Remove underline
//                     enabledBorder: InputBorder.none, // Remove underline for enabled state
//                     focusedBorder: InputBorder.none, // Remove underline for focused state
//                   ),)
//                 ),
//                 SizedBox( height: 10.h,),
//                 Center(
//                   child: CText(
//                     text: 'My act of self care :',
//                     fontSize: 20,
//                     maxLines: 2,
//                     alignText: TextAlign.center,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.green,
//                     style: const TextStyle(
//                       fontStyle: FontStyle.italic,
//                       decoration: TextDecoration.underline,
//                       color: Colors.green,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20.h),
//                 GridView.builder(
//                   physics: const NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: myActSelfCare.length,
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3, // 7 days in a week
//                     childAspectRatio: 1,
//                   ),
//                   itemBuilder: (context, index) {
//                     return checkboxWidget(
//                         text: myActSelfCare[index],
//                         checkString: selectedSelfCare,
//                         onTap: () {
//                           if (selectedSelfCare.contains(myActSelfCare[index])) {
//                             selectedSelfCare.remove(myActSelfCare[index]) ;
//                           } else {
//                             selectedSelfCare.add(myActSelfCare[index]) ;
//
//                           }
//
//                           setState(() {});
//                         });
//                   },
//                 ),
//                 SizedBox(height: 20.h),
//                 PrimaryButton(
//                     text: "Save",
//                     // width: 100.w,
//
//                     onTap: () {
//                       saveData();
//                       widget.onUpdate();
//                       Navigator.pop(context);
//                     }),
//                 SizedBox(height: 20.h),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget checkboxWidget(
//       {String text = '', List<String> checkString=const [], VoidCallback? onTap}) {
//     return SizedBox(
//       height: 50.h,
//       child: Column(
//         children: [
//           Center(
//             child: InkWell(
//               onTap: onTap,
//               child: Container(
//                 height: 55.h,
//                 width: 55.w,
//                 decoration: const BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.green,
//                 ),
//                 child: Icon(
//                   checkString.contains(text)
//                       ? Icons.check
//                       : Icons.check_box_outline_blank,
//                   size: 30.0,
//                   color: checkString.contains(text) ? Colors.white : Colors.green,
//                 ),
//               ),
//             ),
//           ),
//           CText(
//             text: text,
//             alignText: TextAlign.center,
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//             color: Colors.green,
//           ),
//         ],
//       ),
//     );
//   }
// }
