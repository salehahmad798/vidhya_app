import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vidhya_app/screens/self_tracking/self_tracking_model.dart';
import 'package:vidhya_app/utils/app_colors.dart';
import 'package:vidhya_app/utils/app_images.dart';
import 'package:vidhya_app/widgets/custom_appbar.dart';
import 'package:vidhya_app/widgets/custom_text.dart';
import 'package:intl/intl.dart';

import '../../main.dart';

class SelfTrackingSummaryScreen extends StatefulWidget {
  DateTime selectedDay;

   SelfTrackingSummaryScreen({super.key,
   required this.selectedDay,
   });

  @override
  State<SelfTrackingSummaryScreen> createState() => _SelfTrackingSummaryScreenState();
}

class _SelfTrackingSummaryScreenState extends State<SelfTrackingSummaryScreen> {

  late SelfTrackingModel? tracking;

  @override
  void initState() {
    super.initState();
    tracking = _getTrackingForDate(widget.selectedDay);
  }

  SelfTrackingModel? _getTrackingForDate(DateTime date) {
    List<SelfTrackingModel> allTracking = _getSelfTrackingData();
    return allTracking.firstWhere(
          (tracking) => tracking.date.isAtSameMomentAs(date),
      // orElse: () => null,
    );
  }
  List<SelfTrackingModel> _getSelfTrackingData() {
    // Fetch the data from storage or your data source
    final jsonList = storage.read<List<dynamic>>('selfTrack');
    if (jsonList == null) return [];

    return jsonList.map((json) {
      return SelfTrackingModel.fromJson(Map<String, dynamic>.from(json));
    }).toList();
  }
  @override
  Widget build(BuildContext context) {
    if (tracking == null) {
      return Scaffold(
        appBar: const CustomAppBar(image: AppImaes.applogo),
        body: Center(
          child: CText(
            text: 'No data found for the selected date.',
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.red,
          ),
        ),
      );
    }

    List<String> textList = [
      'Feeling selected: ${tracking!.feeling}',
      'Why Experienced Urge: ${tracking!.whyUrges}',
      'Urges Frequency: ${tracking!.urgeFrequency}',
    ];

    ;
    return Scaffold(
      backgroundColor: AppColors.primarywhiteColor,
      appBar: const CustomAppBar(image: AppImaes.applogo),
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
                    text: DateFormat("dd-MM-yyyy").format(tracking!.date),
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
                        ellipsisText: false,
                        overflow: TextOverflow.visible,
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
