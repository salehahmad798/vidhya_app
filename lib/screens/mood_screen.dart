import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vidhya_app/screens/urge_screen.dart';
import 'package:vidhya_app/utils/app_colors.dart';
import 'package:vidhya_app/utils/app_images.dart';
import 'package:vidhya_app/widgets/custom_appbar.dart';
import 'package:vidhya_app/widgets/custom_text.dart';
import 'package:vidhya_app/widgets/primary_button.dart';

class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Center(
                  child: CText(
                    text: '''Mood''',
                    fontSize: 20,
                    alignText: TextAlign.start,
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
                Center(
                  child: CText(
                    text: '''How do you feel today?''',
                    fontSize: 16,
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
                    text: '''I feel like this becasue :''',
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
                Container(
                  width: 100.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                      color: AppColors.primarywhiteColor.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      CText(
                        text: 'Aduio entry',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.withOpacity(0.5),
                      ),
                      Icon(
                        Icons.macro_off_rounded,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  width: 100.w,
                  height: 100.h,
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
                Center(
                  child: CText(
                    text: '''My act of selfcare :''',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    checkboxWidget('Nervous'),
                    checkboxWidget('Anxious'),
                    checkboxWidget('Happy'),
                  ],
                ),
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
