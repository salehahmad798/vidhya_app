// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:vidhya_app/screens/calender.dart';
// import 'package:vidhya_app/utils/app_images.dart';
// import 'package:vidhya_app/widgets/custom_appbar.dart';
// import 'package:vidhya_app/widgets/custom_text.dart';

// class TrackingScreen extends StatefulWidget {
//   const TrackingScreen({super.key});

//   @override
//   State<TrackingScreen> createState() => _TrackingScreenState();
// }

// class _TrackingScreenState extends State<TrackingScreen> {
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
import 'package:vidhya_app/main.dart';
import 'package:vidhya_app/screens/calender.dart';
import 'package:vidhya_app/screens/fl_chart.dart';
import 'package:vidhya_app/screens/home_screen.dart';
import 'package:vidhya_app/utils/app_images.dart';
import 'package:vidhya_app/widgets/custom_appbar.dart';
import 'package:vidhya_app/widgets/custom_text.dart';
import 'package:vidhya_app/widgets/primary_button.dart';
// Import the line chart widget

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        image: AppImaes.applogo,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 22),
            child: Column(
              children: [
                SimpleCalendar(),
                Center(
                  child: CText(
                    text: 'Tracking',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.green,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                      color: Colors.green,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                LineChartSample(), // Add the LineChart here
                SizedBox(height: 70.h),
                Container(
                  width: 100.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
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
