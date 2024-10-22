import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gymvita_connect/controllers/auth_controller.dart';
import 'package:gymvita_connect/controllers/usercontroller.dart';
import 'package:gymvita_connect/utils/colors.dart';

class FeedbackBottomSheet extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController messageController;

  const FeedbackBottomSheet({
    super.key,
    required this.titleController,
    required this.messageController,
  });

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();
    final AuthController authController = Get.find<AuthController>();

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20.h),
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: secondary)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: secondary, width: 1.2.w),
                  ),
                  hintStyle: TextStyle(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontSize: 14.sp),
                  filled: true,
                  fillColor: primary,
                  hintText: 'Enter a title'),
            ),
            SizedBox(height: 20.h),
            TextFormField(
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              controller: messageController,
              decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: secondary)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: secondary, width: 1.2.w),
                  ),
                  hintStyle: TextStyle(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      fontSize: 14.sp),
                  filled: true,
                  fillColor: primary,
                  hintText: 'Enter a message'),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10.h),
                        decoration: BoxDecoration(
                            color: primary,
                            border: Border.all(color: white, width: 1.5.w),
                            borderRadius: BorderRadius.circular(8.r)),
                        child: const Center(child: Text("Cancel"))),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      await userController.submitFeedback(
                          authController.storedGymCode.value,
                          authController.storedUid.value,
                          titleController.text,
                          messageController.text);
                      titleController.clear();
                      messageController.clear();

                      Navigator.pop(context);

                      Future.delayed(
                          Duration(seconds: 1),
                          () => Get.snackbar(
                                'Thanks for your feedback',
                                'Will try to Improve', // Leave title empty
                                // Duration before auto-dismiss
                              ));
                    },
                    child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10.h),
                        decoration: BoxDecoration(
                            color: accent,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Center(child: Text("Send"))),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
