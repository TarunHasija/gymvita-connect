import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymvita_connect/controllers/usercontroller.dart';
import 'package:gymvita_connect/screens/nav_screens/settings/change_email.dart';
import 'package:gymvita_connect/utils/colors.dart';
import 'package:gymvita_connect/widgets/setting/profile_textfield.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final UserDataController userController = Get.find<UserDataController>();

  // TextEditingControllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController serviceController = TextEditingController();
  final TextEditingController fitnessGoalController = TextEditingController();
  final TextEditingController allergieController = TextEditingController();
  final TextEditingController injuryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        centerTitle: true,
        title: Text(
          'Profile',
          style: GoogleFonts.righteous(
            textStyle: theme.displayMedium?.copyWith(fontSize: 24.sp),
          ),
        ),
      ),
      body: Obx(
        () {
          nameController.text =
              userController.userDocument.value?['details.name'] ?? '';
          phoneNoController.text =
              userController.userDocument.value?['phoneNo'] ?? '';
          dobController.text = userController.userDocument.value?['dob'] ?? '';
          genderController.text =
              userController.userDocument.value?['gender'] ?? '';
          serviceController.text =
              (userController.userDocument.value?['services'] as List<dynamic>?)
                      ?.join(', ') ??
                  '';
          fitnessGoalController.text = (userController
                      .userDocument.value?['fitnessGoals'] as List<dynamic>?)
                  ?.join(', ') ??
              '';
          allergieController.text =
              userController.userDocument.value?['healthConsiderations'] ?? '';
          injuryController.text =
              userController.userDocument.value?['medicalCondition'] ?? '';

          return SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.all(20.h),
              child: Column(
                children: [
                  //! Profile Image
                  Obx(
                    () => Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          radius: 52.r,
                          backgroundImage: (userController.userDocument
                                          .value?['details.image'] ==
                                      null ||
                                  userController.userDocument
                                          .value!['details.image'] ==
                                      "")
                              ? const AssetImage(
                                  'assets/images/defaultprofile.png')
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
                              onTap: () {
                                print("edit photo");
                              },
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
                  ),

                  //! Input fields
                  SizedBox(height: 50.h),

                  // Name field
                  TextfieldHeading(theme: theme, title: 'Name'),
                  ProfileTextFieldInput(
                    textEditingController: nameController,
                    hintText: 'Name',
                  ),

                  // Phone Number field
                  TextfieldHeading(theme: theme, title: 'Phone number'),
                  ProfileTextFieldInput(
                    textEditingController: phoneNoController,
                    hintText: 'Phone number',
                  ),

                  // Email field (non-editable via Save button)
                  TextfieldHeading(theme: theme, title: 'Email'),
                  Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ProfileTextFieldInput(
                            readonly: true,
                            textEditingController: TextEditingController(
                              text: userController.userDocument.value?['email'],
                            ),
                            hintText: 'Email',
                          ),
                        ),
                        SizedBox(width: 10.w),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => ChangeEmailPage());
                          },
                          child: Container(
                            padding: EdgeInsets.all(14.h),
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
                      ],
                    ),
                  ),

                  // Date of Birth field
                  TextfieldHeading(theme: theme, title: 'Date of birth'),
                  ProfileTextFieldInput(
                    textEditingController: dobController,
                    hintText: 'DOB',
                  ),

                  // Gender field
                  TextfieldHeading(theme: theme, title: 'Gender'),
                  ProfileTextFieldInput(
                    readonly: true,
                    textEditingController: genderController,
                    hintText: 'Gender',
                  ),

                  // Services field
                  TextfieldHeading(theme: theme, title: "Services"),
                  // Services field
                  ProfileTextFieldInput(
                    textEditingController: serviceController,
                    hintText: 'Services',
                  ),

                  // Fitness Goals Fitness
                  TextfieldHeading(theme: theme, title: 'Fitness Goals'),
                  ProfileTextFieldInput(
                    textEditingController: fitnessGoalController,
                    hintText: 'Fitness Goals',
                  ),

                  // Allergies field
                  TextfieldHeading(theme: theme, title: 'Allergies'),
                  ProfileTextFieldInput(
                    textEditingController: allergieController,
                    hintText: 'Allergies',
                  ),

                  TextfieldHeading(theme: theme, title: 'Injuries'),
                  ProfileTextFieldInput(
                    textEditingController: injuryController,
                    hintText: 'Injuries',
                  ),

                  SizedBox(height: 20.h),

                  // Save Button
                  SizedBox(
                    height: 55.h,
                    width: double.infinity,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: accent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      onPressed: () async {
                        FocusScope.of(context).unfocus();

                        await userController.updateUserData(
                          name: nameController.text,
                          phoneNo: phoneNoController.text,
                          dob: dobController.text,
                          gender: genderController.text,
                          services: serviceController.text,
                          fitnessGoals: fitnessGoalController.text,
                          allergies: allergieController.text,
                          injuries: injuryController.text,
                        );
                      },
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
          );
        },
      ),
    );
  }
}

// Helper widget for text field headings
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
      ),
    );
  }
}
