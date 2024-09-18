import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vidhya_app/main.dart';
import 'package:vidhya_app/screens/self_tracking/self_tracking_model.dart';
import 'package:vidhya_app/screens/thanks_screen.dart';
import 'package:vidhya_app/utils/app_colors.dart';
import 'package:vidhya_app/utils/app_images.dart';
import 'package:vidhya_app/widgets/custom_appbar.dart';
import 'package:vidhya_app/widgets/custom_text.dart';
import 'package:vidhya_app/widgets/primary_button.dart';

class UrgeScreen extends StatefulWidget {
  String selectedFeeling;
  DateTime selectedDate;
  final VoidCallback onUpdate;
  UrgeScreen({
    super.key,
    required this.selectedFeeling,
    required this.selectedDate,
    required this.onUpdate,
  });

  @override
  State<UrgeScreen> createState() => _UrgeScreenState();
}

class _UrgeScreenState extends State<UrgeScreen> {
  String? urgeFrequency;
  String? urges;
  String? selectedWhyUrge;
  final List<String> whyUrges = ["Bored", "Stressed", "Sad", "Angry"];
  final List<String> urgesList = ["0-5", "6-10", "11-15", "16-20","21-25+"];
  TextEditingController reasonController = TextEditingController();
  void saveData() {
    // Create a new SelfTrackingModel instance
    if( reasonController.text.isEmpty && selectedWhyUrge==''){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select on type the urges'),
        ),
      );

      return;
    }
    if(urgeFrequency==''){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select the Frequency of the urges'),
        ),
      );
      return;
    }

    SelfTrackingModel data = SelfTrackingModel(
      feeling: widget.selectedFeeling,
      whyUrges: reasonController.text.isEmpty
          ? selectedWhyUrge!
          : reasonController.text,
      urgeFrequency: urgeFrequency!,
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
                    text: 'Why do you think you experienced urge?',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.green,
                    maxLines: 2,
                    alignText: TextAlign.center,
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
                  itemCount: whyUrges.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 7 days in a week
                      childAspectRatio: 3 / 1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemBuilder: (context, index) {
                    return PrimaryButton(
                        text: whyUrges[index],
                        width: 40.w,
                        tcolor: selectedWhyUrge == whyUrges[index]
                            ? Colors.white
                            : Colors.green,
                        color: selectedWhyUrge == whyUrges[index]
                            ? Colors.green
                            : Colors.white,
                        boarderColor: selectedWhyUrge == whyUrges[index]
                            ? Colors.green.shade200
                            : Colors.green,
                        onTap: () {
                          ;
                          if (selectedWhyUrge == null) {
                            selectedWhyUrge = whyUrges[index];
                          } else if (selectedWhyUrge == whyUrges[index]) {
                            selectedWhyUrge = null;
                          } else {
                            selectedWhyUrge = whyUrges[index];
                          }
                          reasonController.text = '';
                          setState(() {});
                        });
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                    width: Get.width,
                    height: 52.h,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                        bottom: reasonController.text.isEmpty ? 0.h : 25.h),
                    decoration: BoxDecoration(
                        color: AppColors.primarygreenColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                            width: 8,
                            style: BorderStyle.solid,
                            color: Colors.green)),
                    child: TextFormField(
                      controller: reasonController,
                      onChanged: (text) {
                        text.isEmpty ? null : selectedWhyUrge = null;
                        setState(() {});
                      },
                      style: TextStyle(
                        color: AppColors.primarywhiteColor,
                        fontFamily: 'Poppins',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      decoration: InputDecoration(
                        hintText: "Other Text",
                        suffixIcon: GestureDetector(
                          onTap: () {
                            reasonController.text = '';
                            setState(() {});
                          },
                          child: const CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        hintStyle: TextStyle(
                          color: AppColors.primarywhiteColor,
                          fontFamily: 'Poppins',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        border: InputBorder.none, // Removes the underline
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal:
                                10), // Optional: Add some padding inside the text field
                      ),
                    )),
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: CText(
                    text: 'How many times did you act on the urge?',
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
                    itemCount: urgesList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 110.w, vertical: 5.h),
                        child: PrimaryButton(
                            text: urgesList[index],
                            width: 100.w,
                            tcolor: urges == urgesList[index]
                                ? Colors.white
                                : Colors.green,
                            color: urges == urgesList[index]
                                ? Colors.green
                                : Colors.white,
                            boarderColor: urges == urgesList[index]
                                ? Colors.green.shade200
                                : Colors.green,
                            onTap: () {
                              if(index==0){
                                urgeFrequency = '5';
                                urges=urgesList[index];
                              }
                              if (index==1){
                                urgeFrequency = '10';
                                urges=urgesList[index];
                              }
                              if (index==2){
                                urgeFrequency = '15';
                                urges=urgesList[index];
                              }
                              if (index==3){
                                urgeFrequency = '20';
                                urges=urgesList[index];
                              } if (index==4){
                                urgeFrequency = '25+';
                                urges=urgesList[index];
                              }
                              // if (urgeFrequency == null) {
                              //   urgeFrequency = urgesList[index];
                              // } else if (urgeFrequency == urgesList[index]) {
                              //   urgeFrequency = null;
                              // } else {
                              //   urgeFrequency = urgesList[index];
                              // }
                              setState(() {});
                            }),
                      );
                    }),
                PrimaryButton(
                    text: "Save",
                    // width: 100.w,

                    onTap: () {
                      saveData();
                      widget.onUpdate();
                      Navigator.pop(context);
                      Navigator.pop(context);
                      // Navigator.pop(context);
                    }),
                SizedBox(height: 20.h),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
