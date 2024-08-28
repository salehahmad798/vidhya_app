// import 'package:flutter/material.dart';

// class SimpleCalendar extends StatefulWidget {
//   @override
//   _SimpleCalendarState createState() => _SimpleCalendarState();
// }

// class _SimpleCalendarState extends State<SimpleCalendar> {
//   DateTime selectedDate = DateTime.now(); // To track the selected date
//   int currentDateSelectedIndex = 0; // For Horizontal Date selection

//   List<String> listOfMonths = [
//     "Jan",
//     "Feb",
//     "Mar",
//     "Apr",
//     "May",
//     "Jun",
//     "Jul",
//     "Aug",
//     "Sep",
//     "Oct",
//     "Nov",
//     "Dec"
//   ];

//   List<String> listOfDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100, // Ensure a height is provided
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         separatorBuilder: (BuildContext context, int index) {
//           return SizedBox(width: 10);
//         },
//         itemCount: 365,
//         itemBuilder: (BuildContext context, int index) {
//           DateTime date = DateTime.now().add(Duration(days: index));
//           return InkWell(
//             onTap: () {
//               setState(() {
//                 currentDateSelectedIndex = index;
//                 selectedDate = date;
//               });
//             },
//             child: Container(
//               width: 60,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 color: currentDateSelectedIndex == index
//                     ? Colors.black
//                     : Colors.white,
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     listOfMonths[date.month - 1],
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: currentDateSelectedIndex == index
//                           ? Colors.white
//                           : Colors.grey,
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   Text(
//                     date.day.toString(),
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.w700,
//                       color: currentDateSelectedIndex == index
//                           ? Colors.white
//                           : Colors.grey,
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   Text(
//                     listOfDays[date.weekday - 1],
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: currentDateSelectedIndex == index
//                           ? Colors.white
//                           : Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class SimpleCalendar extends StatefulWidget {
  @override
  _SimpleCalendarState createState() => _SimpleCalendarState();
}

class _SimpleCalendarState extends State<SimpleCalendar> {
  DateTime selectedDate = DateTime.now(); // To track the selected date
  late DateTime firstDayOfMonth; // First day of the current month
  late DateTime lastDayOfMonth; // Last day of the current month

  @override
  void initState() {
    super.initState();
    firstDayOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    lastDayOfMonth = DateTime(selectedDate.year, selectedDate.month + 1, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          child: Text(
            "${firstDayOfMonth.month}/${firstDayOfMonth.year}",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          itemCount: lastDayOfMonth.day + firstDayOfMonth.weekday,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7, // 7 days in a week
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            if (index < firstDayOfMonth.weekday) {
              return Container(); // Empty cells before the first day of the month
            }

            DateTime date = DateTime(firstDayOfMonth.year,
                firstDayOfMonth.month, index - firstDayOfMonth.weekday + 1);

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedDate = date;
                });
              },
              child: Container(
                margin: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: selectedDate == date ? Colors.green : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(
                      color: selectedDate == date ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
