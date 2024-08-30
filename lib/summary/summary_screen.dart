import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vidhya_app/utils/app_colors.dart';
import 'package:vidhya_app/utils/app_images.dart';
import 'package:vidhya_app/widgets/custom_appbar.dart';
import 'package:vidhya_app/widgets/custom_text.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final List<String> textList = [
    'Emotions selected :',
    'Number of urges :',
    'Reasons for urges :',
    'Acted on the urge :',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primarywhiteColor,
      appBar: CustomAppBar(image: AppImaes.applogo),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.0.w, vertical: 22.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primaryappcolor,
                border: Border.all(color: Colors.amber, width: 10.w),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CText(
                    text: 'Summary For :',
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: Colors.green,
                  ),
                  CText(
                    text: '(Selected date)',
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: Colors.green,
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.h),
            Expanded(
              child: ListView.builder(
                itemCount: textList.length,
                itemBuilder: (context, index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CText(
                        text: textList[index],
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                      SizedBox(height: 40.h),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
