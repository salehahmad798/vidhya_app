import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vidhya_app/main.dart';
import 'package:vidhya_app/screens/home_screen.dart';
import 'package:vidhya_app/utils/app_images.dart';
import 'package:vidhya_app/widgets/custom_appbar.dart';
import 'package:vidhya_app/widgets/custom_text.dart';
import 'package:vidhya_app/widgets/primary_button.dart';

class UnderstandingBrfbs extends StatefulWidget {
  const UnderstandingBrfbs({super.key});

  @override
  State<UnderstandingBrfbs> createState() => _UnderstandingBrfbsState();
}

class _UnderstandingBrfbsState extends State<UnderstandingBrfbs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        image: AppImaes.applogo,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 22),
          child: Column(
            children: [
              Center(
                child: CText(
                  text: '''Understanding the BRFBs''',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.green,
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                      color: Colors.green),
                ),
              ),
              SizedBox(
                height: 70.h,
              ),
              PrimaryButton(
                  text: 'What?',
                  textSize: 16,
                  tcolor: Colors.white,
                  width: 130,
                  color: Colors.green.withOpacity(0.7),
                  iconEnable: true,
                  onTap: () {}),
              SizedBox(
                height: 20,
              ),
              PrimaryButton(
                  text: 'Why?',
                  textSize: 16,
                  tcolor: Colors.white,
                  width: 130,
                  color: Colors.green.withOpacity(0.7),
                  iconEnable: true,
                  onTap: () {}),
              SizedBox(
                height: 20,
              ),
              PrimaryButton(
                  text: 'Tools?',
                  textSize: 16,
                  tcolor: Colors.white,
                  width: 130,
                  color: Colors.green.withOpacity(0.7),
                  iconEnable: true,
                  onTap: () {}),
              SizedBox(
                height: 20,
              ),
              PrimaryButton(
                  text: 'Acceptance?',
                  textSize: 16,
                  tcolor: Colors.white,
                  width: 170,
                  color: Colors.green.withOpacity(0.7),
                  iconEnable: true,
                  onTap: () {}),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 100.w,
                height: 100.h,
                decoration: BoxDecoration(
                  // color: Colors.greenAccent, // Background color
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
    );
  }
}
