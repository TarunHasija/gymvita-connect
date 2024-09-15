import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gymvita_connect/controllers/nutrition_plan_controller.dart';
import 'package:gymvita_connect/controllers/userdata_controller.dart';
import 'package:gymvita_connect/utils/colors.dart';
import 'package:gymvita_connect/widgets/appbar.dart';

class NutritionPlanPage extends StatefulWidget {
  const NutritionPlanPage({super.key});
  @override
  State<NutritionPlanPage> createState() => _NutritionPlanPageState();
}

class _NutritionPlanPageState extends State<NutritionPlanPage> {
  final UserDataController userDataController = Get.find<UserDataController>();
  final NutritionPlanController nutritionplanController =
      Get.find<NutritionPlanController>();

  bool isRemindMe = false;

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;

    String reminderText = isRemindMe ? 'Stop Reminder' : 'Remind Me';

    return Scaffold(
      appBar: const CustomAppBar(title: 'Nutrition Plan'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Stack(
          children: [
            // Scrollable content

            Positioned.fill(
              child: Container(
                padding: EdgeInsets.only(top: 60.h),
                child: FutureBuilder(
                  future: nutritionplanController.fetchNutritionPlan(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return const Center(
                          child:
                              Text('Please contact your gym for Nutrition Plan')
                          // Text('Error: ${snapshot.error}')
                          );
                    }

                    // Check if the details array is available
                    var details =
                        nutritionplanController.nutritionDetails.value;
                    if (details == null || details.isEmpty) {
                      return const Center(
                          child: Text('No Nutrition Plan available.'));
                    }

                    // Build the UI based on the number of items in details
                    return ListView.builder(
                      itemCount: details.length,
                      itemBuilder: (context, index) {
                        var item = details[index] as Map<String, dynamic>;
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 10.h),
                          decoration: BoxDecoration(
                            border: const Border(
                              left: BorderSide(
                                width: 5,
                                color:
                                    accent, // Replace accent with the actual color
                              ),
                            ),
                            color:
                                secondary, // Replace secondary with the actual color
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          padding: EdgeInsets.all(15.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(item['time'] ?? 'No time',
                                      style: theme.bodyMedium),
                                  Text(item['meal'] ?? 'No meal',
                                      style: theme.bodyMedium),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Wrap(
                                  spacing:
                                      10.w, // Horizontal spacing between items
                                  runSpacing:
                                      6.h, // Vertical spacing between lines
                                  children: (item['foodItems'] as List<dynamic>)
                                      .map((text) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.w, vertical: 4.h),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        border: Border.all(color: accent),
                                      ),
                                      child: Text(
                                        text, // text is each food item
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            //! reminder button
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: EdgeInsets.only(top: 10.h),
                height: 35.h,
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isRemindMe = !isRemindMe;
                          });
                        }, // Corrected to trigger the callback
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: accent, width: 1.2.h),
                            color: accent,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.notifications_active_outlined,
                                    size: 20.h,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(reminderText, style: theme.bodySmall),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
