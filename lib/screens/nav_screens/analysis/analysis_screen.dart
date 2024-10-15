import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymvita_connect/screens/navbar_screen.dart';
import 'package:gymvita_connect/utils/colors.dart';
import 'package:gymvita_connect/widgets/analysis/analysis_graph.dart';
import 'package:gymvita_connect/widgets/home/horizontal_card.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  bool isSixMonth = true;

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;

    // Determine the colors based on the selected button
    Color btnSixMonthColor = isSixMonth ? accent : secondary;
    Color sixMonthTextColor = isSixMonth ? primary : Colors.white;
    Color oneYearTextColor = isSixMonth ? Colors.white : primary;
    Color btnOneYearColor = isSixMonth ? secondary : accent;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NavbarScreen()));
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text('Analysis',
                style: theme.displayMedium?.copyWith(fontSize: 24.sp)),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 2), () {
            setState(() {});
          });
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Stack(
            children: [
              // Scrollable content
              Positioned.fill(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.only(
                      top: 20.h), // Add top padding to make room for the Row
                  child: Column(
                    children: [
                      analysisGraph(
                          theme, isSixMonth, 'Bicep', 'bicep', 50, 0, 'cm'),
                      analysisGraph(
                          theme, isSixMonth, 'Tricep', 'tricep', 50, 0, 'cm'),
                      analysisGraph(
                          theme, isSixMonth, 'Weight', 'weight', 120, 40, 'kg'),
                      analysisGraph(theme, isSixMonth, 'Height', 'height', 190,
                          140, 'cm'),
                      analysisGraph(
                          theme, isSixMonth, 'Hips', 'hips', 130, 70, 'cm'),
                      analysisGraph(
                          theme, isSixMonth, 'Thighs', 'thighs', 80, 30, 'cm'),
                      analysisGraph(
                          theme, isSixMonth, 'Chest', 'chest', 130, 50, 'cm'),
                      analysisGraph(
                          theme, isSixMonth, 'Waist', 'waist', 130, 60, 'cm'),
                    ],
                  ),
                ),
              ),
              // The Row with buttons stays on top
              Positioned(
                top: 0, // Pin to the top of the Stack
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
                      HorizontalCard(
                        title: 'Current 6 months',
                        theme: theme.copyWith(
                          bodySmall: theme.bodySmall
                              ?.copyWith(color: sixMonthTextColor),
                        ),
                        color: btnSixMonthColor,
                        onTapp: () {
                          setState(() {
                            isSixMonth = true;
                          });
                        },
                      ),
                      HorizontalCard(
                        title: 'Previous 6 month',
                        theme: theme.copyWith(
                          bodySmall: theme.bodySmall
                              ?.copyWith(color: oneYearTextColor,fontWeight: FontWeight.bold),
                        ),
                        color: btnOneYearColor,
                        onTapp: () {
                          setState(() {
                            isSixMonth = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
