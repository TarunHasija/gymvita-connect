import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymvita_connect/controllers/userdata_controller.dart';
import 'package:gymvita_connect/screens/navbar_screen.dart';
import 'package:gymvita_connect/utils/colors.dart';
import 'package:gymvita_connect/widgets/setting/profile_textfield.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  TextEditingController nameController = TextEditingController();

  TextEditingController phoneNoController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController dobController = TextEditingController();

  TextEditingController genderController = TextEditingController();

  TextEditingController serviceController = TextEditingController();

  TextEditingController fitnessGoalController = TextEditingController();

  TextEditingController allergieController = TextEditingController();

  TextEditingController injuryController = TextEditingController();

  TextEditingController occupationController = TextEditingController();

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
      body: RefreshIndicator(
        backgroundColor: white,
        color: primary,
        onRefresh: () async {
          Future.delayed(const Duration(seconds: 2));
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: [
                  //! Profile Image

                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50.r,
                        backgroundImage: (userController
                                        .userDocument.value?['details.image'] ??
                                    "")
                                .isEmpty
                            ? const AssetImage(
                                'assets/images/default_profile.png') // Default image if no image is found
                            : NetworkImage(userController.userDocument.value![
                                'details.image']), // Image from Firebase
                      ),
                      Positioned(
                        bottom: -10.h,
                        left: 50.h,
                        child: IconButton(
                          onPressed: () {
                            // Implement functionality for adding a photo here
                          },
                          icon: const Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
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
                    hintText:
                        userController.userDocument.value?['details.name'],
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
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const NavbarScreen(),
                              ),
                            );
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
                    textEditingController: fitnessGoalController,
                    hintText: (userController.userDocument
                                .value?['fitnessGoals'] as List<dynamic>?)
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
                    hintText: 'Allergies ',
                    onComplete: () {},
                  ),

                  TextfieldHeading(
                    theme: theme,
                    title: 'Injuries',
                  ),
                  ProfileTextFieldInput(
                    textEditingController: injuryController,
                    hintText: 'Injuries',
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
