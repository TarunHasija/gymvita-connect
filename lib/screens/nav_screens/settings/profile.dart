import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymvita_connect/screens/navbar_screen.dart';
import 'package:gymvita_connect/utils/colors.dart';
import 'package:gymvita_connect/widgets/setting/profile_textfield.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
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
        child: Container(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                //! Profile Image

                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 48,
                      backgroundImage: NetworkImage(
                          'https://plus.unsplash.com/premium_photo-1664536392896-cd1743f9c02c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8cGVyc29ufGVufDB8fDB8fHww'),
                    ),
                    Positioned(
                        bottom: -10,
                        left: 60,
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                            )))
                  ],
                ),

                //! Input fields
                SizedBox(
                  height: 50.h,
                ),
                

                ProfileTextFieldInput(
                  textEditingController: nameController,
                  hintText: 'Name',
                ),
                SizedBox(
                  height: 20.h,
                ),
                ProfileTextFieldInput(
                  textEditingController: phoneNoController,
                  hintText: 'Phone',
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ProfileTextFieldInput(
                        textEditingController: emailController,
                        hintText: 'Email',
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Container(
                      width: 56.h, // Set a fixed width for the button
                      height: 56.h, // Set a fixed height for the button
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
                SizedBox(
                  height: 20.h,
                ),

                ProfileTextFieldInput(
                  textEditingController: dobController,
                  hintText: 'Date of Birth',
                ),
                SizedBox(
                  height: 20.h,
                ),

                ProfileTextFieldInput(
                  textEditingController: genderController,
                  hintText: 'Gender',
                ),
                SizedBox(
                  height: 20.h,
                ),
                ProfileTextFieldInput(
                  textEditingController: serviceController,
                  hintText: 'Service',
                ),
                SizedBox(
                  height: 20.h,
                ),
                ProfileTextFieldInput(
                  textEditingController: fitnessGoalController,
                  hintText: 'Fitness Goal',
                ),
                SizedBox(
                  height: 20.h,
                ),
                ProfileTextFieldInput(
                  textEditingController: allergieController,
                  hintText: 'Allergies',
                ),
                SizedBox(
                  height: 20.h,
                ),
                ProfileTextFieldInput(
                  textEditingController: injuryController,
                  hintText: 'Injuries',
                ),
                SizedBox(
                  height: 20.h,
                ),
                ProfileTextFieldInput(
                  textEditingController: occupationController,
                  hintText: 'Occupation',
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
