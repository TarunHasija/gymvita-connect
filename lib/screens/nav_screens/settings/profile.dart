import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymvita_connect/controllers/auth_controller.dart';
import 'package:gymvita_connect/controllers/profile_controller.dart';
import 'package:gymvita_connect/controllers/usercontroller.dart';
import 'package:gymvita_connect/screens/nav_screens/settings/change_email.dart';
import 'package:gymvita_connect/utils/colors.dart';
import 'package:gymvita_connect/widgets/custom_txt_button.dart';
import 'package:gymvita_connect/widgets/setting/profile_textfield.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final UserController userController = Get.find<UserController>();

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
    final ProfileController profileController = Get.find<ProfileController>();
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
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
      body: RefreshIndicator(
        onRefresh: () => Future.delayed(const Duration(seconds: 2), () {
          userController.getUserData(authController.storedUid.value,
              authController.storedGymCode.value);
        }),
        child: Obx(
          () {
            nameController.text =
                userController.userDocSnap.value?['details.name'] ?? '';
            phoneNoController.text =
                userController.userDocSnap.value?['phoneNo'] ?? '';
            dobController.text = userController.userDocSnap.value?['dob'] ?? '';
            genderController.text =
                userController.userDocSnap.value?['gender'] ?? '';
            serviceController.text = (userController
                        .userDocSnap.value?['services'] as List<dynamic>?)
                    ?.join(', ') ??
                '';
            fitnessGoalController.text = (userController
                        .userDocSnap.value?['fitnessGoals'] as List<dynamic>?)
                    ?.join(', ') ??
                '';
            allergieController.text =
                userController.userDocSnap.value?['healthConsiderations'] ?? '';
            injuryController.text =
                userController.userDocSnap.value?['medicalCondition'] ?? '';

            return SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(20.h),
                child: Column(
                  children: [
                    //! Profile Image
                     Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Obx(()=>
                             CircleAvatar(
                                backgroundColor: secondary,
                                radius: 52.r,
                                backgroundImage: (userController.userDocSnap
                                                .value?['details.image'] ==
                                            null ||
                                        userController.userDocSnap
                                                .value!['details.image'] ==
                                            "")
                                    ? const AssetImage(
                                        'assets/images/defaultprofile.png')
                                    : NetworkImage(userController
                                            .userDocSnap.value!['details.image'])
                                        as ImageProvider,
                                onBackgroundImageError: (_, __) =>
                                    const AssetImage(
                                        'assets/images/defaultprofile.png'),
                              ),
                          ),

                          Positioned(
                            bottom: -5.h,
                            right: 8.h,
                            child: GestureDetector(
                              onTap: () {
                                profileController.selectFile(context);
                              },
                              child: Container(
                                padding: EdgeInsets.all(8.h),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
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
                    SizedBox(height: 50.h),

                    // Name field
                    TextfieldHeading(theme: theme, title: 'Name'),
                    CustomTextField(
                      textEditingController: nameController,
                      hintText: 'Name',
                    ),

                    // Phone Number field
                    TextfieldHeading(theme: theme, title: 'Phone number'),
                    CustomTextField(
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
                            child: CustomTextField(
                              readonly: true,
                              textEditingController: TextEditingController(
                                text:
                                    userController.userDocSnap.value?['email'],
                              ),
                              hintText: 'Email',
                            ),
                          ),

                          //! --------Future code to change email
                          // SizedBox(width: 10.w),
                          // GestureDetector(
                          //   onTap: () {
                          //     Get.to(() => ChangeEmailPage());
                          //   },
                          //   child: Container(
                          //     padding: EdgeInsets.all(14.h),
                          //     alignment: Alignment.center,
                          //     decoration: BoxDecoration(
                          //       color: secondary,
                          //       borderRadius: BorderRadius.circular(12.r),
                          //     ),
                          //     child: Icon(
                          //       Icons.edit,
                          //       size: 28.h,
                          //       color: Colors.white,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),

                    // Date of Birth field
                    TextfieldHeading(theme: theme, title: 'Date of birth'),
                    CustomTextField(
                      readonly: true,
                      textEditingController: dobController,
                      hintText: 'DOB',
                    ),

                    // Gender field
                    TextfieldHeading(theme: theme, title: 'Gender'),
                    CustomTextField(
                      readonly: true,
                      textEditingController: genderController,
                      hintText: 'Gender',
                    ),

                    // Services field
                    TextfieldHeading(theme: theme, title: "Services"),
                    // Services field
                    CustomTextField(
                      textEditingController: serviceController,
                      hintText: 'Services',
                    ),

                    // Fitness Goals Fitness
                    TextfieldHeading(theme: theme, title: 'Fitness Goals'),
                    CustomTextField(
                      textEditingController: fitnessGoalController,
                      hintText: 'Fitness Goals',
                    ),

                    // Allergies field
                    TextfieldHeading(theme: theme, title: 'Allergies'),
                    CustomTextField(
                      textEditingController: allergieController,
                      hintText: 'Allergies',
                    ),

                    TextfieldHeading(theme: theme, title: 'Injuries'),
                    CustomTextField(
                      textEditingController: injuryController,
                      hintText: 'Injuries',
                    ),

                    SizedBox(height: 20.h),

                    // Save Button
                    CustomTextButton(
                      buttonText: 'Save',
                      bgColor: accent,
                      height: 50.h,
                      btnOnTap: () async {
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
                    ),
                  ],
                ),
              ),
            );
          },
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
      ),
    );
  }
}
