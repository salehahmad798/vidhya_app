import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vidhya_app/screens/home_screen.dart';
import 'package:vidhya_app/utils/app_colors.dart';
import 'package:vidhya_app/utils/app_images.dart';
import 'package:vidhya_app/widgets/custom_text.dart';

class ThanksScreen extends StatefulWidget {
  const ThanksScreen({super.key});

  @override
  State<ThanksScreen> createState() => _ThanksScreenState();
}

class _ThanksScreenState extends State<ThanksScreen> {
  void initState() {
    super.initState();
    checkIntro();
  }

  void checkIntro() {
    Timer(const Duration(seconds: 2), () {
      Get.offAll(() => HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarywhiteColor,
      body: Column(
        children: [
          Image.asset(
            AppImaes.simle,
          ),
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
          SizedBox(
            height: 20.h,
          ),
          Container(
            width: 150.w,
            height: 150.h,
            decoration: BoxDecoration(
              // Background color
              image: DecorationImage(
                image: AssetImage(AppImaes.applogo),
              ),
              shape: BoxShape.circle,
              border: Border.all(
                width: 2,
                style: BorderStyle.solid,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
