import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vidhya_app/main.dart';
import 'package:vidhya_app/screens/home_screen/home_screen.dart';
import 'package:vidhya_app/utils/app_colors.dart';
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
                  onTap: () {
                    openDialog('What?',
                        "Body-Focused Repetitive Behaviors (BFRBs) are compulsive actions, such as hair pulling (trichotillomania), skin picking (dermatillomania), and nail biting (onychophagia), often triggered by stress or anxiety. These behaviors can cause physical harm and are difficult to control. Treatment typically involves therapy, like Cognitive Behavioral Therapy (CBT), and sometimes medication.");
                  }),
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
                  onTap: () {
                    openDialog("Why?",
                        "Body-Focused Repetitive Behaviors (BFRBs) occur as coping mechanisms for managing stress, anxiety, or boredom, providing temporary relief or satisfaction.They can be influenced by genetic predisposition, neurological factors such as brain chemical imbalances, and environmental triggers. Over time, these behaviors may become ingrained habits, making them di cult to stop.");
                  }),
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
                  onTap: () {
                    openDialog("Tools?",
                        "Tools for managing Body-Focused Repetitive Behaviors (BFRBs) include habit-tracking apps to identify patterns and triggers, and fidget toys or awareness devices that o er physical distractions. Journaling can help track occurrences and triggers, while Cognitive Behavioral Therapy (CBT) provides strategies to manage the behaviors. Barrier methods like bandages or gloves can also help prevent the behavior.");
                  }),
              SizedBox(
                height: 20,
              ),
              PrimaryButton(
                  text: 'Acceptance?',
                  textSize: 16,
                  tcolor: Colors.white,
                  width: 170.w,
                  color: Colors.green.withOpacity(0.7),
                  iconEnable: true,
                  onTap: () {
                    openDialog("Acceptance?",
                        "Accepting a Body-Focused Repetitive Behavior (BFRB) involves recognizing it as a part of your experience while focusing on managing it constructively. Start by acknowledging that having a BFRB does not define your worth or capabilities. Educate yourself about the behavior to understand its triggers and impacts better. Seek support from professionals, support groups, or trusted individuals to share experiences and strategies. Practice self-compassion and remind yourself that managing a BFRB is a journey that involves progress, not perfection.");
                  }),
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

  openDialog(String title, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.greenAccent,
          title: Text(title,
              style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.underline,
                decorationColor: Colors.white,
                decorationThickness: 2,
                shadows: [Shadow(color: Colors.white, offset: Offset(0, -5))],
              )),
          content: Text(
            description,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          actions: [
            Container(
              width: 80,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(50)),
              child: TextButton(
                child: CText(
                  text: 'Close',
                  fontSize: 16,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
