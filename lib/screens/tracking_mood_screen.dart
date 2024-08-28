import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vidhya_app/main.dart';
import 'package:vidhya_app/screens/calender.dart';
import 'package:vidhya_app/screens/fl_chart.dart';
import 'package:vidhya_app/screens/home_screen.dart';
import 'package:vidhya_app/screens/mood_screen.dart';
import 'package:vidhya_app/screens/self_tracking.dart';
import 'package:vidhya_app/utils/app_images.dart';
import 'package:vidhya_app/widgets/custom_appbar.dart';
import 'package:vidhya_app/widgets/custom_text.dart';
import 'package:vidhya_app/widgets/primary_button.dart';
// Import the line chart widget

class TrackingMoodScreen extends StatefulWidget {
  const TrackingMoodScreen({super.key});

  @override
  State<TrackingMoodScreen> createState() => _TrackingMoodScreenState();
}

class _TrackingMoodScreenState extends State<TrackingMoodScreen> {
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
                SizedBox(height: 20.h),
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
                SizedBox(
                  height: 100.h,
                ),
                PrimaryButton(
                    text: 'Self Tracking',
                    onTap: () {
                      Get.to(() => SelfTracking());
                    }),
                SizedBox(
                  height: 20.h,
                ),
                PrimaryButton(
                    text: 'Mood',
                    onTap: () {
                      Get.to(() => MoodScreen());
                    }),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
