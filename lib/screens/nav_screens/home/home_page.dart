import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:gymvita_connect/controllers/userdata_controller.dart';
import 'package:gymvita_connect/widgets/general/custom_bottom_sheet.dart';
import 'package:gymvita_connect/screens/dashboard_card_screens/nutrition_plan/nutrition_plan.dart';
import 'package:gymvita_connect/screens/dashboard_card_screens/pay_fee/payfee.dart';
import 'package:gymvita_connect/screens/nav_screens/settings/profile.dart';
import 'package:gymvita_connect/screens/dashboard_card_screens/workout/workout_plan.dart';
import 'package:gymvita_connect/screens/nav_screens/analysis/analysis_screen.dart';
import 'package:gymvita_connect/screens/notification_screen.dart';
import 'package:flutter_material_symbols/flutter_material_symbols.dart';
import 'package:gymvita_connect/utils/colors.dart';
import 'package:gymvita_connect/widgets/home/dashboard/dashboard_card.dart';
import 'package:gymvita_connect/widgets/home/horizontal_card.dart';
import 'package:gymvita_connect/widgets/analysis/linegraph.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserDataController userDataController = Get.find<UserDataController>();
  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    TextEditingController feedbackTitle = TextEditingController();
    TextEditingController feedbackMessage = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //!-------AppBar------
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  decoration: const BoxDecoration(color: primary),
                  width: double.infinity,
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 26.r,
                          child: Image.asset('assets/images/loginlogo.png'),
                        ),
                        SizedBox(
                          width: 8.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //! -----name-----
                            Obx(() {
                              return Text(
                                "Hi ${userDataController.userDocument.value?['details.name']} 👋🏻",
                                style: theme.bodyMedium,
                              );
                            }),
                            Obx(() => Text(
                                  userDataController.userDocument
                                      .value?['services'][0],
                                  style: theme.displaySmall
                                      ?.copyWith(color: white),
                                )),
                          ],
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const NotificationScreen()));
                            },
                            icon: const Icon(Icons.notifications))
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 10.h),
                Text('My Dashboard', style: theme.bodySmall),

                // GridView for cards
                Padding(
                  padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                  child: GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                    ),
                    children: [
                      dashBoardCard(
                          'Nutrition Plan', theme, MaterialSymbols.nutrition,
                          () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const NutritionPlanPage()));
                      }),
                      dashBoardCard(
                          'Workout Plan', theme, Icons.sports_gymnastics, () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const WorkOutPlanPage()));
                      }),
                      dashBoardCard(
                          'Analysis', theme, FontAwesomeIcons.chartArea, () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AnalysisScreen()));
                      }),
                      dashBoardCard(
                          'Pay fee', theme, MaterialSymbols.credit_card, () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PayFee()));
                      }),
                      dashBoardCard('Feedback', theme, MaterialSymbols.chat,
                          () {
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
                      dashBoardCard('Profile', theme, MaterialSymbols.person,
                          () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  Profile()));
                      }),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),

                // Update your Monthly Progress button
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(8.h),
                    decoration: BoxDecoration(
                      border: Border.all(color: accent, width: 1.2.h),
                      color: secondary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: accent,
                          size: 20.h,
                        ),
                        SizedBox(width: 8.h),
                        Text(
                          "Update your Monthly Progress",
                          style: theme.bodySmall?.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                // Weight Text
                Text("My Analysis", style: theme.headlineSmall),

                SizedBox(height: 10.h),

                // Horizontal ListView
                SizedBox(
                  height: 35.h, // Set height for the horizontal ListView
                  child: ListView(scrollDirection: Axis.horizontal, children: [
                    HorizontalCard(title: 'Weight', theme: theme),
                    HorizontalCard(title: 'Height', theme: theme),
                    HorizontalCard(title: 'Chest', theme: theme),
                    HorizontalCard(title: 'Hips', theme: theme),
                    HorizontalCard(title: 'Biceps', theme: theme),
                    HorizontalCard(title: 'Triceps', theme: theme),
                    HorizontalCard(title: 'Thighs', theme: theme),
                  ]),
                ),

                SizedBox(height: 20.h),

                // Container for additional content
                const LineGraph(),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Featured Videos",
                  style: theme.headlineSmall,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    image: DecorationImage(
                        image: AssetImage('assets/images/gym.png'),
                        fit: BoxFit.cover),
                  ),
                  height: 200.h,
                  width: double.infinity,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Pushups",
                      style: theme.titleSmall,
                    )),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Recommended workout plan",
                  style: theme.headlineSmall,
                ),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5.h),
                    decoration: BoxDecoration(
                      color: secondary,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Punjabi Hits", style: theme.bodySmall),
                          const Icon(Icons.navigate_next)
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5.h),
                    decoration: BoxDecoration(
                      color: secondary,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Punjabi Hits", style: theme.bodySmall),
                          const Icon(Icons.navigate_next)
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
