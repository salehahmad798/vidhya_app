// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:vidhya_app/screens/calender.dart';
// import 'package:vidhya_app/utils/app_images.dart';
// import 'package:vidhya_app/widgets/custom_appbar.dart';
// import 'package:vidhya_app/widgets/custom_text.dart';

// class SelfTrackingScreenCalender extends StatefulWidget {
//   const SelfTrackingScreenCalender({super.key});

//   @override
//   State<SelfTrackingScreenCalender> createState() => _TrackingScreenState();
// }

// class _TrackingScreenState extends State<SelfTrackingScreenCalender> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         image: AppImaes.applogo,
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           // Wrapping content in a scrollable area
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 22),
//             child: Column(
//               children: [
//                 SimpleCalendar(), // This should now show up on the screen
//                 Center(
//                   child: CText(
//                     text: 'Tracking',
//                     fontSize: 20,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.green,
//                     style: TextStyle(
//                       fontStyle: FontStyle.italic,
//                       decoration: TextDecoration.underline,
//                       color: Colors.green,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 70.h,
//                 ),
//                 Container(
//                   width: 100.w,
//                   height: 100.h,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage(AppImaes.applogo),
//                     ),
//                     shape: BoxShape.circle,
//                     border: Border.all(
//                       width: 5,
//                       style: BorderStyle.solid,
//                       color: Colors.green,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vidhya_app/main.dart';
import 'package:vidhya_app/screens/fl_chart.dart';
import 'package:vidhya_app/screens/self_tracking/self_tracking.dart';
import 'package:vidhya_app/screens/self_tracking/self_tracking_model.dart';
import 'package:vidhya_app/screens/behaviour_tracking_screen/tracking_mood_screen.dart';
import 'package:vidhya_app/utils/app_images.dart';
import 'package:vidhya_app/widgets/custom_appbar.dart';
import 'package:vidhya_app/widgets/custom_text.dart';

class SelfTrackingScreenCalender extends StatefulWidget {
  const SelfTrackingScreenCalender({super.key});

  @override
  State<SelfTrackingScreenCalender> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<SelfTrackingScreenCalender> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDate = DateTime.now();
  Map<DateTime, String> _moodMap = {};
  // List<SelfTrackingModel> _getSelfTrackingData() {
  //   final List<Map<String, dynamic>>? jsonList =
  //       storage.read<List<Map<String, dynamic>>>('selfTrack');
  //   if (jsonList == null) return [];
  //
  //   return jsonList.map((json) => SelfTrackingModel.fromJson(json)).toList();
  // }
  List<SelfTrackingModel> _getSelfTrackingData() {
    final jsonList = storage.read<List<dynamic>>('selfTrack'); // Read the list as List<dynamic>
    if (jsonList == null) return [];

    // Convert each dynamic element to a Map<String, dynamic>
    return jsonList.map((json) {
      return Map<String, dynamic>.from(json); // Safely cast each element
    }).map((json) {
      return SelfTrackingModel.fromJson(json);
    }).toList();
  }
  void _populateMoodMap() {
    final dataList = _getSelfTrackingData();
    _moodMap = {
      for (var data in dataList)
        DateTime.parse(data.date.toString()): data.feeling
    };
  }

  @override
  void initState() {
    super.initState();
    _populateMoodMap(); // Initialize the mood map when the widget is created
  }

  void _refreshCalendar() {
    setState(() {
      _populateMoodMap(); // Refresh the mood map
    });
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
              children: [
                TableCalendar(
                  focusedDay: selectedDate,
                  firstDay: DateTime(2024),
                  lastDay: DateTime(2100),
                  calendarFormat: format,
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Month',
                  },
                  calendarStyle: const CalendarStyle(
                    defaultTextStyle: TextStyle(
                        color: Colors.black87), // Text color for default dates
                    weekendTextStyle: TextStyle(
                        color: Colors
                            .black), // Text color for weekend dates, // Text color for dates outside of the current month
                  ),
                  selectedDayPredicate: (day) => isSameDay(day, selectedDate),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      selectedDate = selectedDay;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelfTracking(
                          selectedDate: selectedDate,
                          onUpdate: _refreshCalendar,
                        ),
                      ),
                    );
                    return;
                    if (isSameDay(selectedDay, DateTime.now())) {
                      // If the user taps on the current date, navigate to the FeelingsPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelfTracking(
                              selectedDate: selectedDay,
                              onUpdate: _refreshCalendar),
                        ),
                      );
                    } else if (selectedDay.isBefore(DateTime.now())) {
                      // If the user taps on a previous date with a saved mood, navigate to the MoodDetailPage
                      if (storage.hasData(selectedDay.toString())) {
                        // Navigator.push(
                        //   context,
                        // MaterialPageRoute(
                        //   builder: (context) => MoodDetailPage(date: selectedDay),
                        // ),
                        // );
                      }
                    } else {
                      // If the user taps on a future date or any other condition, handle it here (optional)
                      // You can show a toast or a dialog that future dates cannot be selected.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'You can only add moods for the current date.')),
                      );
                    }
                  },
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, day, events) {
                      final mood = _moodMap[day];
                      if (mood != null) {
                        String emoji = '';

                        switch (mood) {
                          case 'Happy':
                            emoji = '😊';
                            break;
                          case 'Sad':
                            emoji = '😢';
                            break;
                          case 'Angry':
                            emoji = '😡';
                            break;
                          case 'Stressed':
                            emoji = '😓';
                            break;
                          case 'Nervous':
                            emoji = '😬';
                            break;
                          case 'Anxious':
                            emoji = '😰';
                            break;
                          default:
                            emoji = '😶';
                        }

                        return Center(
                          child: Text(
                            emoji,
                            style: const TextStyle(
                                fontSize: 24), // Increase the size of the emoji
                          ),
                        );
                      }

                      // if (storage.hasData(day.toString())) {
                      //   // SelfTrackingModel data = storage.read(day.toString());
                      //   // Read the data from storage
                      //   final json = storage.read<Map<String, dynamic>>(day.toString());
                      //   // Convert the map to SelfTrackingModel
                      //   final selfTrackingModel = SelfTrackingModel.fromJson(json!);
                      //   final mood = selfTrackingModel.feeling;
                      //   final mood = selfTrackingModel.feeling;
                      //
                      //   // final mood =data.feeling;
                      //   String emoji = '';
                      //
                      //   switch (mood) {
                      //     case 'Happy':
                      //       emoji = '😊';
                      //       break;
                      //     case 'Sad':
                      //       emoji = '😢';
                      //       break;
                      //     case 'Angry':
                      //       emoji = '😡';
                      //       break;
                      //     case 'Stressed':
                      //       emoji = '😓';
                      //       break;
                      //     case 'Nervous':
                      //       emoji = '😬';
                      //       break;
                      //     case 'Anxious':
                      //       emoji = '😰';
                      //       break;
                      //     default:
                      //       emoji = '😶';
                      //   }
                      //
                      //   return Center(
                      //     child: Text(
                      //       emoji,
                      //       style:const TextStyle(fontSize: 24), // Increase the size of the emoji
                      //     ),
                      //   );
                      // }
                      return null;
                    },
                  ),
                ),
                Center(
                  child: CText(
                    text: 'Tracking',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.green,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                      color: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                LineChartSample(), // Add the LineChart here
                SizedBox(height: 20.h),
                Container(
                  width: 100.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage(AppImaes.applogo),
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 5,
                      style: BorderStyle.solid,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
