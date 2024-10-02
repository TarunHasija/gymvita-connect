import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymvita_connect/controllers/userdata_controller.dart';
import 'package:gymvita_connect/utils/colors.dart';
import 'package:gymvita_connect/widgets/setting/profile_textfield.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final  TextEditingController nameController = TextEditingController();

final  TextEditingController phoneNoController = TextEditingController();

final  TextEditingController emailController = TextEditingController();

 final TextEditingController dobController = TextEditingController();

 final TextEditingController genderController = TextEditingController();

 final TextEditingController serviceController = TextEditingController();

 final TextEditingController fitnessGoalController = TextEditingController();

 final TextEditingController allergieController = TextEditingController();

 final TextEditingController injuryController = TextEditingController();

 final TextEditingController occupationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final UserDataController userController = Get.find();
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_rounded)),
        centerTitle: true,
        title: Text(
          'Profile',
          style: GoogleFonts.righteous(
            textStyle: theme.displayMedium?.copyWith(fontSize: 24.sp),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(20.h),
          child: Center(
            child: Column(
              children: [
                //! Profile Image

                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: 52.r,
                      backgroundImage: (userController
                                      .userDocument.value?['details.image'] ==
                                  null ||
                              userController
                                      .userDocument.value!['details.image'] ==
                                  "")
                          ? const AssetImage('assets/images/defaultprofile.png')
                          : NetworkImage(userController.userDocument
                              .value!['details.image']) as ImageProvider,
                    ),
                    Positioned(
                      bottom: -5.h,
                      right: 8.h,
                      child: Container(
                        padding: EdgeInsets.all(8.h),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: GestureDetector(
                          child: Icon(
                            Icons.edit,
                            size: 20.h,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                //! Input fields
                SizedBox(
                  height: 50.h,
                ),
                TextfieldHeading(
                  theme: theme,
                  title: 'Name',
                ),

                ProfileTextFieldInput(
                  readonly: true,
                  textEditingController: nameController,
                  hintText: userController.userDocument.value?['details.name'],
                  onComplete: () {},
                ),

                TextfieldHeading(
                  theme: theme,
                  title: 'Phone number',
                ),
                ProfileTextFieldInput(
                  readonly: true,
                  textEditingController: phoneNoController,
                  hintText: userController.userDocument.value?['phoneNo'],
                  onComplete: () {},
                ),

                TextfieldHeading(
                  theme: theme,
                  title: 'Email',
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ProfileTextFieldInput(
                        textEditingController: emailController,
                        hintText: userController.userDocument.value?['email'],
                        onComplete: () {},
                      ),
                    ),
                    SizedBox(width: 10.w),
                    SizedBox(
                      width: 56.h,
                      height: 56.h,
                      child: GestureDetector(
                        onTap: () {
                        
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: secondary,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            Icons.edit,
                            size: 28.h,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                TextfieldHeading(
                  theme: theme,
                  title: 'Date of birth',
                ),
                ProfileTextFieldInput(
                  
                  textEditingController: dobController,
                  hintText: userController.userDocument.value?['dob'],
                  onComplete: () {},
                ),

                TextfieldHeading(
                  theme: theme,
                  title: 'Gender',
                ),
                ProfileTextFieldInput(
                  textEditingController: genderController,
                  hintText: userController.userDocument.value?['gender'],
                  onComplete: () {},
                ),

                TextfieldHeading(
                  theme: theme,
                  title: 'Services',
                ),
                ProfileTextFieldInput(
                  readonly: true,
                  textEditingController: serviceController,
                  hintText: (userController.userDocument.value?['services']
                              as List<dynamic>?)
                          ?.join(', ') ??
                      'Services',
                  onComplete: () {},
                ),

                TextfieldHeading(
                  theme: theme,
                  title: 'Fitness Goals',
                ),
                ProfileTextFieldInput(
                  readonly: true,
                  textEditingController: fitnessGoalController,
                  hintText: (userController.userDocument.value?['fitnessGoals']
                              as List<dynamic>?)
                          ?.join(', ') ??
                      'Fitness Goals',
                  onComplete: () {},
                ),

                TextfieldHeading(
                  theme: theme,
                  title: 'Allergies',
                ),
                ProfileTextFieldInput(
                  textEditingController: allergieController,
                  //healthConsiderations
                  hintText: userController.userDocument.value?['healthConsiderations']??
                      'Allergy',
                  onComplete: () {},
                ),

                TextfieldHeading(
                  theme: theme,
                  title: 'Injuries',
                ),
                ProfileTextFieldInput(
                  textEditingController: injuryController,
                  hintText: userController.userDocument.value?['medicalCondition']??
                      'Medical Condition',
                  onComplete: () {},
                ),
                SizedBox(
                  height: 20.h,
                ),

                SizedBox(
                  height: 55.h,
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: accent,
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Save",
                      style: TextStyle(
                        color: black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TextfieldHeading extends StatelessWidget {
  final String title;
  const TextfieldHeading({
    super.key,
    required this.theme,
    required this.title,
  });

  final TextTheme theme;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(bottom: 8.h, left: 8.w, top: 20.h),
        child: Text(
          title,
          style: theme.labelMedium
              ?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w300),
        ));
  }
}
