import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vidhya_app/main.dart';
import 'package:vidhya_app/screens/self_tracking/self_tracking_model.dart';
import 'package:vidhya_app/screens/urge_screen.dart';
import 'package:vidhya_app/utils/app_images.dart';
import 'package:vidhya_app/widgets/custom_appbar.dart';
import 'package:vidhya_app/widgets/custom_text.dart';
import 'package:vidhya_app/widgets/primary_button.dart';

class SelfTracking extends StatefulWidget {
  final DateTime selectedDate;
  final VoidCallback onUpdate;
  const SelfTracking({super.key, required this.selectedDate,
    required this.onUpdate,
  });

  @override
  State<SelfTracking> createState() => _SelfTrackingState();
}

class _SelfTrackingState extends State<SelfTracking> {
  final List _selections = [
    'Nervous',
    'Anxious',
    'Happy',
    'Sad',
    'Stressed',
    'Angry',
  ];
  final List<String> urges = ["0-5", "6-10", "11-15", "16-20+"];
  String? selectedFeeling;
  // String? customFeeling;
  String? urgeFrequency;

  void saveData() {
    // Create a new SelfTrackingModel instance
    SelfTrackingModel data = SelfTrackingModel(
      urgeFrequency: urgeFrequency!,
      feeling: selectedFeeling!,
      date: widget.selectedDate,
    );

    // Convert the data to JSON format
    Map<String, dynamic> dataJson = data.toJson();

    // Retrieve the existing list from storage
    List<dynamic> existingListDynamic = storage.read('selfTrack') ?? [];

    // Cast the dynamic list to a List<Map<String, dynamic>>
    List<Map<String, dynamic>> existingList =
    existingListDynamic.cast<Map<String, dynamic>>();

    // Add the new data to the existing list
    existingList.add(dataJson);

    // Save the updated list back into storage
    storage.write('selfTrack', existingList);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        image: AppImaes.applogo,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 22),
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Center(
                  child: CText(
                    text: 'How do you feel today?',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.green,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                      color: Colors.green,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _selections.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 7 days in a week
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    return checkboxWidget(_selections[index]);
                  },
                ),
                SizedBox(height: 20.h),
                Center(
                  child: CText(
                    text: 'How many times did you have an urge?',
                    fontSize: 20,
                    maxLines: 2,
                    alignText: TextAlign.center,
                    fontWeight: FontWeight.w700,
                    color: Colors.green,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      decoration: TextDecoration.underline,
                      color: Colors.green,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: urges.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 110.w, vertical: 5.h),
                        child: PrimaryButton(
                            text: urges[index],
                            width: 100.w,
                            tcolor: urgeFrequency == urges[index]
                                ? Colors.white
                                : Colors.green,
                            color: urgeFrequency == urges[index]
                                ? Colors.green
                                : Colors.white,
                            boarderColor: urgeFrequency == urges[index]
                                ? Colors.green.shade200
                                : Colors.green,
                            onTap: () {
                              if (urgeFrequency == null) {
                                urgeFrequency = urges[index];
                              } else if (urgeFrequency == urges[index]) {
                                urgeFrequency = null;
                              } else {
                                urgeFrequency = urges[index];
                              }

                              setState(() {});
                            }),
                      );
                    }),
                SizedBox(height: 20.h),
                PrimaryButton(
                    text: "Save",
                    // width: 100.w,

                    onTap: () {
                      saveData();
                      widget.onUpdate();
                      Navigator.pop(context);

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
    return SizedBox(
      height: 50.h,
      child: Column(
        children: [
          Center(
            child: InkWell(
              onTap: () {
                if (selectedFeeling == null) {
                  selectedFeeling = text;
                } else if (selectedFeeling == text) {
                  selectedFeeling = null;
                } else {
                  selectedFeeling = text;
                }

                setState(() {});
              },
              child: Container(
                height: 55.h,
                width: 55.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
                child: Icon(
                  selectedFeeling == text
                      ? Icons.check
                      : Icons.check_box_outline_blank,
                  size: 30.0,
                  color: selectedFeeling == text ? Colors.white : Colors.green,
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
      ),
    );
  }
}
