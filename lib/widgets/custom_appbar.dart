import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vidhya_app/utils/app_colors.dart';
import 'package:vidhya_app/utils/app_images.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String image;
  final bool leadingIcon;

  const CustomAppBar({
    super.key,
    required this.image,
    this.leadingIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(120.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          leadingWidth: 24.w,
          leading: leadingIcon
              ? GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.green,
                      size: 30.w,
                    ),
                  ),
                )
              : const SizedBox(),
          title: Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              // color: Colors.greenAccent, // Background color
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
          centerTitle: true,
          elevation: 0,
          actions: const [],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(81.h);
}
