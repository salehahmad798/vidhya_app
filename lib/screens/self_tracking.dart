import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vidhya_app/screens/urge_screen.dart';
import 'package:vidhya_app/utils/app_images.dart';
import 'package:vidhya_app/widgets/custom_appbar.dart';
import 'package:vidhya_app/widgets/custom_text.dart';
import 'package:vidhya_app/widgets/primary_button.dart';

class SelfTracking extends StatefulWidget {
  const SelfTracking({super.key});

  @override
  State<SelfTracking> createState() => _SelfTrackingState();
}

class _SelfTrackingState extends State<SelfTracking> {
  Map<String, bool> _selections = {
    'Nervous': false,
    'Anxious': false,
    'Happy': false,
    'Sad': false,
    'Stressed': false,
    'Angry': false,
  };

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
                    text: '''How do you feel today?''',
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
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    checkboxWidget('Nervous'),
                    checkboxWidget('Anxious'),
                    checkboxWidget('Happy'),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    checkboxWidget('Sad'),
                    checkboxWidget('Stressed'),
                    checkboxWidget('Angry'),
                  ],
                ),
                SizedBox(height: 20.h),
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
                      Get.to(() => UrgeScreen());
                    }),
                SizedBox(height: 10.h),
                PrimaryButton(
                    text: '6-10',
                    width: 100.w,
                    onTap: () {
                      Get.to(() => UrgeScreen());
                    }),
                SizedBox(height: 10.h),
                PrimaryButton(
                    text: '11-15',
                    width: 100.w,
                    onTap: () {
                      Get.to(() => UrgeScreen());
                    }),
                SizedBox(height: 10.h),
                PrimaryButton(
                    text: '16-20 +',
                    width: 100.w,
                    onTap: () {
                      Get.to(() => UrgeScreen());
                    }),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget checkboxWidget(String text) {
    return Column(
      children: [
        Center(
          child: InkWell(
            onTap: () {
              setState(() {
                _selections[text] = !_selections[text]!;
              });
            },
            child: Container(
              height: 55.h,
              width: 55.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ),
              child: _selections[text]!
                  ? Icon(
                      Icons.check,
                      size: 30.0,
                      color: Colors.white,
                    )
                  : Icon(
                      Icons.check_box_outline_blank,
                      size: 30.0,
                      color: Colors.green,
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
    );
  }
}
