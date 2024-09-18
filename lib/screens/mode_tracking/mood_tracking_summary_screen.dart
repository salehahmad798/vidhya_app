import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vidhya_app/screens/mode_tracking/mood_tracking_model.dart';
import 'package:vidhya_app/utils/app_colors.dart';
import 'package:vidhya_app/utils/app_images.dart';
import 'package:vidhya_app/widgets/custom_appbar.dart';
import 'package:vidhya_app/widgets/custom_text.dart';
import 'package:intl/intl.dart';
import '../../main.dart';

class MoodTrackingSummaryScreen extends StatefulWidget {
  final DateTime selectedDay;
  // SelfTrackingModel tracking;
  MoodTrackingSummaryScreen({super.key, required this.selectedDay});

  @override
  State<MoodTrackingSummaryScreen> createState() =>
      _MoodTrackingSummaryScreenState();
}

class _MoodTrackingSummaryScreenState extends State<MoodTrackingSummaryScreen> {
  late MoodTrackingModel? tracking;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  bool _isPaused = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    tracking = _getTrackingForDate(widget.selectedDay);

    // Listen to changes in the audio player
    _audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        _duration = newDuration;
      });
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        _position = newPosition;
      });
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _isPlaying = false;
        _position = Duration.zero;
      });
    });
  }

  MoodTrackingModel? _getTrackingForDate(DateTime date) {
    List<MoodTrackingModel> allTrackings = _getSelfTrackingData();
    return allTrackings.firstWhere(
          (tracking) => tracking.date.isAtSameMomentAs(date),
      // orElse: () => null,
    );
  }

  List<MoodTrackingModel> _getSelfTrackingData() {
    // Fetch the data from storage or your data source
    final jsonList = storage.read<List<dynamic>>('MoodList');
    if (jsonList == null) return [];

    return jsonList.map((json) {
      return MoodTrackingModel.fromJson(Map<String, dynamic>.from(json));
    }).toList();
  }

  Future<void> _playPauseAudio(String path) async {
    if (_isPlaying) {
      await _audioPlayer.pause();
      setState(() {
        _isPlaying = false;
        _isPaused = true;
      });
    } else {
      if (_isPaused) {
        await _audioPlayer.resume();
      } else {
        await _audioPlayer.play(DeviceFileSource(path));
      }
      setState(() {
        _isPlaying = true;
        _isPaused = false;
      });
    }
  }

  Future<void> _stopAudio() async {
    await _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
      _position = Duration.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (tracking == null) {
      return Scaffold(
        appBar: const CustomAppBar(image: AppImaes.applogo),
        body: Center(
          child: CText(
            text: 'No data found for the selected date.',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.red,
          ),
        ),
      );
    }

    List<String> textList = [
      'Emotions selected: ${tracking!.feeling.toString().replaceAll('[', '').replaceAll(']', '')}',
      'Reasons for urges: ${tracking!.reason}',
      'Acted on the urge: ${tracking!.selfCare.toString().replaceAll('[', '').replaceAll(']', '')}',
    ];

    String? audioPath = tracking!.voiceNotePath;

    return Scaffold(
      backgroundColor: AppColors.primarywhiteColor,
      appBar: const CustomAppBar(image: AppImaes.applogo),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.0.w, vertical: 22.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primaryappcolor,
                border: Border.all(color: Colors.amber, width: 10.w),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CText(
                    text: 'Summary For :',
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: Colors.green,
                  ),
                  CText(
                    text: DateFormat("dd-MM-yyyy").format(tracking!.date),
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: Colors.green,
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.h),
            Expanded(
              child: ListView.builder(
                itemCount: textList.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CText(
                        text: textList[index],
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                        ellipsisText: false,
                        overflow: TextOverflow.visible,
                      ),
                      SizedBox(height: 40.h),
                    ],
                  );
                },
              ),
            ),
            if (audioPath != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Slider(
                    min: 0.0,
                    max: _duration.inSeconds.toDouble(),
                    value: _position.inSeconds.toDouble(),
                    onChanged: (value) async {
                      final newPosition = Duration(seconds: value.toInt());
                      await _audioPlayer.seek(newPosition);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.green,
                        ),
                        onPressed: () => _playPauseAudio(audioPath),
                      ),
                      // IconButton(
                      //   icon: const Icon(
                      //     Icons.stop,
                      //     color: Colors.red,
                      //   ),
                      //   onPressed: _stopAudio,
                      // ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:vidhya_app/screens/mode_tracking/mood_tracking_model.dart';
// import 'package:vidhya_app/utils/app_colors.dart';
// import 'package:vidhya_app/utils/app_images.dart';
// import 'package:vidhya_app/widgets/custom_appbar.dart';
// import 'package:vidhya_app/widgets/custom_text.dart';
// import 'package:intl/intl.dart';
//
// import '../../main.dart';
//
// class MoodTrackingSummaryScreen extends StatefulWidget {
//   DateTime selectedDay;
//   // SelfTrackingModel tracking;
//   MoodTrackingSummaryScreen({super.key,
//     required this.selectedDay,
//     // required this.tracking
//   });
//
//   @override
//   State<MoodTrackingSummaryScreen> createState() => _MoodTrackingSummaryScreenState();
// }
//
// class _MoodTrackingSummaryScreenState extends State<MoodTrackingSummaryScreen> {
//   late MoodTrackingModel? tracking;
//
//   @override
//   void initState() {
//     super.initState();
//     tracking = _getTrackingForDate(widget.selectedDay);
//   }
//
//   MoodTrackingModel? _getTrackingForDate(DateTime date) {
//     List<MoodTrackingModel> allTrackings = _getSelfTrackingData();
//     return allTrackings.firstWhere(
//           (tracking) => tracking.date.isAtSameMomentAs(date),
//       // orElse: () => null,
//     );
//   }
//   List<MoodTrackingModel> _getSelfTrackingData() {
//     // Fetch the data from storage or your data source
//     final jsonList = storage.read<List<dynamic>>('MoodList');
//     if (jsonList == null) return [];
//
//     return jsonList.map((json) {
//       return MoodTrackingModel.fromJson(Map<String, dynamic>.from(json));
//     }).toList();
//   }
//   @override
//   Widget build(BuildContext context) {
//     if (tracking == null) {
//       return Scaffold(
//         appBar: const CustomAppBar(image: AppImaes.applogo),
//         body: Center(
//           child: CText(
//             text: 'No data found for the selected date.',
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//             color: Colors.red,
//           ),
//         ),
//       );
//     }
//
//     List<String> textList = [
//       'Emotions selected: ${tracking!.feeling.toString().replaceAll('[', '').toString().replaceAll(']', '')}',
//       // 'Number of urges: ${tracking!.}',
//       'Reasons for urges: ${tracking!.reason}',
//       'Acted on the urge: ${tracking!.selfCare.toString().replaceAll('[', '').toString().replaceAll(']', '')}',
//     ];
//
//     debugPrint("Audio ::${tracking!.voiceNotePath}");
//     return Scaffold(
//       backgroundColor: AppColors.primarywhiteColor,
//       appBar: const CustomAppBar(image: AppImaes.applogo),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 22.0.w, vertical: 22.h),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: AppColors.primaryappcolor,
//                 border: Border.all(color: Colors.amber, width: 10.w),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CText(
//                     text: 'Summary For :',
//                     fontSize: 25,
//                     fontWeight: FontWeight.w800,
//                     color: Colors.green,
//                   ),
//                   CText(
//                     text: DateFormat("dd-MM-yyyy").format(tracking!.date),
//                     fontSize: 25,
//                     fontWeight: FontWeight.w800,
//                     color: Colors.green,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 40.h),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: textList.length,
//                 itemBuilder: (context, index) {
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       CText(
//                         text: textList[index],
//                         fontSize: 20,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.green,
//                         ellipsisText: false,
//                         overflow: TextOverflow.visible,
//                       ),
//
//                       SizedBox(height: 40.h),
//                     ],
//                   );
//                 },
//               ),
//             ),
//             CText(
//               text: tracking!.voiceNotePath.toString(),
//               fontSize: 20,
//               fontWeight: FontWeight.w600,
//               color: Colors.green,
//               ellipsisText: false,
//               overflow: TextOverflow.visible,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
