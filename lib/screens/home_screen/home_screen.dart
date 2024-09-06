import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vidhya_app/main.dart';
import 'package:vidhya_app/screens/self_tracking/self_tracking_screen_calender.dart';
import 'package:vidhya_app/screens/behaviour_tracking_screen/tracking_mood_screen.dart';
import 'package:vidhya_app/screens/understanding_BRFBs.dart';
import 'package:vidhya_app/utils/app_colors.dart';
import 'package:vidhya_app/utils/app_images.dart';
import 'package:vidhya_app/widgets/custom_text.dart';
import 'package:vidhya_app/widgets/primary_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 22.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150.w,
                height: 150.h,
                decoration: BoxDecoration(
                  color: Colors.greenAccent, // Background color
                  image: const DecorationImage(
                    image: AssetImage(AppImaes.applogo),
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 20,
                    style: BorderStyle.solid,
                    color: Colors.green,
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              CText(
                text: '''Let's Get Started''',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.green,
                style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                    color: Colors.green),
              ),
              SizedBox(
                height: 100.h,
              ),
              PrimaryButton(
                  text: 'Self Tracking',
                  onTap: () {
                    Get.to(() => const TrackingMoodScreen());
                    // GetStorage().erase ();
                  }),
              const SizedBox(
                height: 20,
              ),
              PrimaryButton(
                  text: 'Understanding BFRBs',
                  onTap: () {
                    Get.to(() => const UnderstandingBrfbs());
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
