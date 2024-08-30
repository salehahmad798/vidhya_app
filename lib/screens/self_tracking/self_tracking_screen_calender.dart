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
import 'package:vidhya_app/screens/self_tracking/fl_chart_for_self_tracking.dart';
import 'package:vidhya_app/screens/self_tracking/self_tracking.dart';
import 'package:vidhya_app/screens/self_tracking/self_tracking_model.dart';
import 'package:vidhya_app/screens/behaviour_tracking_screen/tracking_mood_screen.dart';
import 'package:vidhya_app/screens/self_tracking/self_tracking_summary_screen.dart';
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

  List<SelfTrackingModel> _getSelfTrackingData() {
    final jsonList = storage
        .read<List<dynamic>>('selfTrack'); // Read the list as List<dynamic>
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
    final selfTrackingData = _getSelfTrackingData();
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
                  headerStyle: const HeaderStyle(
                    titleTextStyle: TextStyle(color: Colors.green, fontSize: 20), // Month/Year text color
                    leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black), // Left arrow color
                    rightChevronIcon: Icon(Icons.chevron_right, color: Colors.black), // Right arrow color
                    formatButtonVisible: false, // Hide format button if not needed
                    titleCentered: true, // Center the month/year title
                  ),
                  selectedDayPredicate: (day) => isSameDay(day, selectedDate),

                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      selectedDate = selectedDay;
                    });
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => SelfTracking(
                      //       selectedDate: selectedDate,
                      //       onUpdate: _refreshCalendar,
                      //     ),
                      //   ),
                      // );
                      // return;
                    // Retrieve the saved data from storage
                    final jsonList = storage.read<List<dynamic>>('selfTrack') ?? [];

                    // Convert the list of dynamic objects to a list of SelfTrackingModel instances
                    final savedData = jsonList.map((json) {
                      return SelfTrackingModel.fromJson(Map<String, dynamic>.from(json));
                    }).toList();

                    if (isSameDay(selectedDay, DateTime.now())) {
                      bool dataExists = savedData.any((entry) => isSameDay(entry.date, selectedDay));
                      if (dataExists) {
                        // If data exists for the current date, show the summary screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelfTrackingSummaryScreen(
                              selectedDay: selectedDay,
                            ),
                          ),
                        );
                      } else {
                        // If no data exists, navigate to the SelfTracking screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelfTracking(
                              selectedDate: selectedDay,
                              onUpdate: _refreshCalendar,
                            ),
                          ),
                        );
                      }
                    } else if (selectedDay.isBefore(DateTime.now())) {
                      // Check if there's data for the selected date in the savedData list
                      bool dataExists = savedData.any((entry) => isSameDay(entry.date, selectedDay));

                      if (dataExists) {
                        debugPrint("Data found for the selected day: $selectedDay");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelfTrackingSummaryScreen(
                              selectedDay: selectedDay,
                            ),
                          ),
                        );
                      } else {
                        debugPrint("No data found for the selected day: $selectedDay");
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('No mood data found for the selected date.'),
                          ),
                        );
                      }
                    } else {
                      // Handle future dates
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('You can only add moods for the current date.'),
                        ),
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
                FlChartForSelfTracking(trackingData: selfTrackingData),// Add the LineChart here
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
