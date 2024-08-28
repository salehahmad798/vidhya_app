import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vidhya_app/screens/thanks_screen.dart';
import 'package:vidhya_app/utils/app_images.dart';
import 'package:vidhya_app/widgets/custom_appbar.dart';
import 'package:vidhya_app/widgets/custom_text.dart';
import 'package:vidhya_app/widgets/primary_button.dart';

class UrgeScreen extends StatefulWidget {
  const UrgeScreen({super.key});

  @override
  State<UrgeScreen> createState() => _UrgeScreenState();
}

class _UrgeScreenState extends State<UrgeScreen> {
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
                Center(
                  child: CText(
                    text: '''Why do you think you experienced urge?''',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.green,
                    maxLines: 2,
                    alignText: TextAlign.center,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                      color: Colors.green,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    PrimaryButton(text: 'Bored', width: 130, onTap: () {}),
                    PrimaryButton(text: 'Stressed', width: 130, onTap: () {}),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    PrimaryButton(text: 'Sad', width: 130, onTap: () {}),
                    PrimaryButton(text: 'Angry', width: 130, onTap: () {}),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                PrimaryButton(
                    text: 'Other: Text Box', width: 220, onTap: () {}),
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: CText(
                    text: '''How many times did you have an urge?''',
                    fontSize: 20,
                    maxLines: 2,
                    alignText: TextAlign.center,
                    fontWeight: FontWeight.w700,
                    color: Colors.green,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                      color: Colors.green,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                PrimaryButton(
                    text: '0-5',
                    width: 100.w,
                    onTap: () {
                      Get.to(() => ThanksScreen());
                    }),
                SizedBox(height: 10.h),
                PrimaryButton(
                    text: '6-10',
                    width: 100.w,
                    onTap: () {
                      Get.to(() => ThanksScreen());
                    }),
                SizedBox(height: 10.h),
                PrimaryButton(
                    text: '11-15',
                    width: 100.w,
                    onTap: () {
                      Get.to(() => ThanksScreen());
                    }),
                SizedBox(height: 10.h),
                PrimaryButton(
                    text: '16-20 +',
                    width: 100.w,
                    onTap: () {
                      Get.to(() => ThanksScreen());
                    }),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
