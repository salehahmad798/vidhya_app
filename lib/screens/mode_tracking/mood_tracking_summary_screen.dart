import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vidhya_app/screens/mode_tracking/mood_tracking_model.dart';
import 'package:vidhya_app/screens/self_tracking/self_tracking_model.dart';
import 'package:vidhya_app/utils/app_colors.dart';
import 'package:vidhya_app/utils/app_images.dart';
import 'package:vidhya_app/widgets/custom_appbar.dart';
import 'package:vidhya_app/widgets/custom_text.dart';
import 'package:intl/intl.dart';

import '../../main.dart';

class MoodTrackingSummaryScreen extends StatefulWidget {
  DateTime selectedDay;
  // SelfTrackingModel tracking;
  MoodTrackingSummaryScreen({super.key,
    required this.selectedDay,
    // required this.tracking
  });

  @override
  State<MoodTrackingSummaryScreen> createState() => _MoodTrackingSummaryScreenState();
}

class _MoodTrackingSummaryScreenState extends State<MoodTrackingSummaryScreen> {
  // final List<String> textList = [
  //   'Feeling selected :',
  //   'Urges Frequency:',
  // ];
  late MoodTrackingModel? tracking;

  @override
  void initState() {
    super.initState();
    tracking = _getTrackingForDate(widget.selectedDay);
  }

  MoodTrackingModel? _getTrackingForDate(DateTime date) {
    List<MoodTrackingModel> allTrackings = _getSelfTrackingData();
    return allTrackings.firstWhere(
          (tracking) => tracking.date.isAtSameMomentAs(date),
      // orElse: () => null,
    );
  }
  List<MoodTrackingModel> _getSelfTrackingData() {
    // Fetch the data from storage or your data source
    final jsonList = storage.read<List<dynamic>>('MoodList');
    if (jsonList == null) return [];

    return jsonList.map((json) {
      return MoodTrackingModel.fromJson(Map<String, dynamic>.from(json));
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
      'Emotions selected: ${tracking!.feeling}',
      // 'Number of urges: ${tracking!.}',
      'Reasons for urges: ${tracking!.reason}',
      'Acted on the urge: ${tracking!.selfCare}',
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
