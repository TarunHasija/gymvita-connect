import 'package:flutter/material.dart';
import 'package:flutter_material_symbols/flutter_material_symbols.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gymvita_connect/controllers/auth_controller.dart';
import 'package:gymvita_connect/controllers/gyminfo_controller.dart';
import 'package:gymvita_connect/controllers/usercontroller.dart';
import 'package:gymvita_connect/screens/nav_screens/home/dashboard_card_screens/pay_fee/payfee.dart';
import 'package:gymvita_connect/screens/nav_screens/payment/payment_screen.dart';
import 'package:gymvita_connect/screens/nav_screens/settings/help_screen.dart';
import 'package:gymvita_connect/screens/navbar_screen.dart';
import 'package:gymvita_connect/widgets/general/custom_bottom_sheet.dart';
import 'package:gymvita_connect/screens/nav_screens/settings/profile.dart';
import 'package:gymvita_connect/utils/colors.dart';
import 'package:gymvita_connect/widgets/setting/setting_card.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final GymInfoController gymInfoController = Get.find();
  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    TextEditingController feedbackTitle = TextEditingController();
    final UserDataController userController = Get.find();
    final GymInfoController gymInfoController = Get.find();
    final AuthController authController = Get.find<AuthController>();
    TextEditingController feedbackMessage = TextEditingController();

    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.h),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      IconButton(
                          onPressed: () {
                            Get.to(() => NavbarScreen());
                          },
                          icon: const Icon(Icons.arrow_back_ios_new_rounded))
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            userController.userDocSnap.value?['details.name'],
                            style: theme.titleMedium?.copyWith(color: white),
                          ),
                          Text(
                            userController.userDocSnap.value?['phoneNo'],
                            style: theme.displaySmall?.copyWith(color: white),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      CircleAvatar(
                        radius: 20.r,
                        backgroundImage: (userController
                                        .userDocSnap.value?['details.image'] ==
                                    null ||
                                userController
                                        .userDocSnap.value!['details.image'] ==
                                    "")
                            ? const AssetImage(
                                'assets/images/defaultprofile.png') // Make sure the asset path is correct
                            : NetworkImage(userController.userDocSnap
                                .value!['details.image']) as ImageProvider,
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                    color: secondary,
                    borderRadius: BorderRadius.circular(10.r)),
                padding: EdgeInsets.all(15.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          //TODO: Plan name ;

                          'Gold Plan',
                          style: theme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          'Next Due Date : ' +
                              userController.userDocSnap.value?['dueDate'],
                          style: theme.displaySmall?.copyWith(
                              color: grey, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    InkWell(
                        onTap: () {
                          Get.to(() => const PayFee());
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              vertical: 8.h, horizontal: 15.h),
                          decoration: BoxDecoration(
                              color: accent,
                              borderRadius: BorderRadius.circular(4.r)),
                          child: Text(
                            "Pay Now",
                            style: theme.displaySmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(15.h),
                decoration: BoxDecoration(
                  color: secondary,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment
                      .start, // Ensure alignment is responsive
                  children: [
                    // Left Column with Gym Info
                    Expanded(
                      // Wrap this column in Expanded to ensure it uses available space
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            gymInfoController.gymData.value?['gymName'] ?? '',
                            style: theme.headlineSmall?.copyWith(color: accent),
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              Icon(Icons.phone_outlined, size: 20.h),
                              SizedBox(width: 10.w),
                              Flexible(
                                // Allow the text to wrap when needed
                                child: Text(
                                  gymInfoController.gymData.value?['phoneNo'] ??
                                      '',
                                  style: theme.displaySmall
                                      ?.copyWith(color: white, fontSize: 10.sp),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              Icon(Icons.mail_outlined, size: 20.h),
                              SizedBox(width: 10.w),
                              Flexible(
                                child: Text(
                                  gymInfoController.gymData.value?['email'] ??
                                      '',
                                  style: theme.displaySmall
                                      ?.copyWith(color: white, fontSize: 10.sp),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.location_pin, size: 20.h),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Text(
                                  gymInfoController.gymData.value?['address']
                                          ['houseNo'] +
                                      " / " +
                                      gymInfoController
                                          .gymData.value?['address']['area'] +
                                      ", " +
                                      gymInfoController
                                          .gymData.value?['address']['city'] +
                                      ", " +
                                      gymInfoController
                                          .gymData.value?['address']['state'] +
                                      "-" +
                                      gymInfoController
                                          .gymData.value?['address']['pincode'],
                                  style: theme.displaySmall
                                      ?.copyWith(color: white, fontSize: 10.sp),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w), // Add space between text and image
                    // Right Column with Image
                    CircleAvatar(
                      radius: 35.r,
                      backgroundImage: (gymInfoController
                                      .gymData.value?['image'] ==
                                  null ||
                              gymInfoController.gymData.value?['image'] == "")
                          ? const AssetImage(
                              'assets/images/uploadavatarpng.png.png') // Placeholder image
                          : NetworkImage(
                                  gymInfoController.gymData.value?['image'])
                              as ImageProvider,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.h),
                padding: EdgeInsets.all(10.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: secondary),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SettingCard(
                        icon: MaterialSymbols.person,
                        title: 'Profile',
                        ontap: () {
                          Get.to(() => Profile());
                        }),
                    const Divider(
                      endIndent: 20,
                      indent: 20,
                      color: primary,
                    ),
                    SettingCard(
                        icon: MaterialSymbols.credit_card,
                        title: 'Payment History',
                        ontap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PaymentScreen()));
                        }),
                    const Divider(
                      endIndent: 20,
                      indent: 20,
                      color: primary,
                    ),
                    SettingCard(
                        icon: MaterialSymbols.chat,
                        title: 'Feedback',
                        ontap: () {
                          showModalBottomSheet(
                              context: context,
                              backgroundColor: primary,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return SingleChildScrollView(
                                    child: Container(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: CustomBottomSheet(
                                      cancelFunction: () {
                                        Navigator.pop(context);
                                      },
                                      saveFunction: () {},
                                      titleController: feedbackTitle,
                                      messageController: feedbackMessage),
                                ));
                              });
                        }),
                    const Divider(
                      endIndent: 20,
                      indent: 20,
                      color: primary,
                    ),
                    SettingCard(
                        icon: MaterialSymbols.help,
                        title: 'Reset password',
                        ontap: () {
                          showModalBottomSheet(
                              context: context,
                              backgroundColor: primary,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return SingleChildScrollView(
                                    child: Container(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: CustomBottomSheet(
                                      cancelFunction: () {
                                        Navigator.pop(context);
                                      },
                                      saveFunction: () {},
                                      titleController: feedbackTitle,
                                      messageController: feedbackMessage),
                                ));
                              });
                        }),
                    const Divider(
                      endIndent: 20,
                      indent: 20,
                      color: primary,
                    ),
                    SettingCard(
                        icon: MaterialSymbols.help,
                        title: 'Help',
                        ontap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HelpScreen()));
                        }),
                    const Divider(
                      endIndent: 20,
                      indent: 20,
                      color: primary,
                    ),
                    SettingCard(
                        icon: MaterialSymbols.logout,
                        title: 'logout',
                        ontap: () {
                          authController.logout();
                        }),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Privacy Policy | About',
                    style: theme.labelSmall,
                  ),
                  Text(
                    'Powered by Avyukt Solutions',
                    style: theme.labelSmall,
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
