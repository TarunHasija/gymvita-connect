import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymvita_connect/utils/colors.dart';

class CustomBottomSheet extends StatelessWidget {
  final VoidCallback saveFunction;
  final VoidCallback cancelFunction;
  final TextEditingController titleController;
  final TextEditingController messageController;
  const CustomBottomSheet({
    super.key,
    required this.titleController,
    required this.messageController, required this.saveFunction, required this.cancelFunction,
  });

  @override
  Widget build(BuildContext context) {
    return
     SingleChildScrollView(
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
            SizedBox(
              height: 20.h,
            ),
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
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Bottom Sheet buttons
                Expanded(
                  child: InkWell(
                    onTap: cancelFunction,
                    child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10.h),
                        decoration: BoxDecoration(
                            color: primary,
                            border: Border.all(color: Colors.red, width: 2.w),
                            borderRadius: BorderRadius.circular(8)),
                        child: const Center(child: Text("Cancel"))),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: InkWell(
                    onTap: saveFunction,
                    child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10.h),
                        decoration: BoxDecoration(
                            color: Colors.green,
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
