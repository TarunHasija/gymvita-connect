import 'dart:collection';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:gymvita_connect/controllers/analysis_graph_controller.dart';
import 'package:gymvita_connect/utils/colors.dart';

class PrevSixmonthGraph extends StatelessWidget {
  final String bodyPartName;
  final double upperLimit;
  final double lowerLimit;
  final String leftSideTitle;

  const PrevSixmonthGraph({
    super.key,
    required this.bodyPartName,
    required this.upperLimit,
    required this.lowerLimit,
    required this.leftSideTitle,
  });

  @override
  Widget build(BuildContext context) {
    final AnalysisGraphController analysisGraphController = Get.find<AnalysisGraphController>();

    // Fetch body part data for the last 6 months
    LinkedHashMap<String, dynamic> bodyPartData = analysisGraphController.getPreviousToPreviousSixMonthsData(bodyPartName);

    if (bodyPartData.isEmpty) {
      return Center(
        child: Text("No data available"),
      );
    }

    // Prepare spots for the graph
    List<FlSpot> spots = [];

    // Get current month and year for the x-axis labels
    DateTime now = DateTime.now();
    List<String> monthNames = [];
    
    // Initialize min and max values
    double minValue = double.infinity;
    double maxValue = double.negativeInfinity;

    // Create month names and initialize spots
    for (int i = 5; i >= 0; i--) {
      DateTime monthDate = DateTime(now.year, now.month - i - 6, 1); // Adjust for 6 months prior
      String formattedMonth = DateFormat('MMM').format(monthDate).toLowerCase();
      monthNames.add(formattedMonth); // Collect month names in reverse order

      // Generate key for data lookup
      String key = '$formattedMonth ${monthDate.year}';
      
      // Check if the data exists for the given key
      if (bodyPartData.containsKey(key)) {
        double value = (bodyPartData[key] is int) ? (bodyPartData[key] as int).toDouble() : bodyPartData[key] as double;
        spots.add(FlSpot(5 - i.toDouble(), value)); // Fill spots according to reversed order

        // Update min and max values
        if (value < minValue) minValue = value;
        if (value > maxValue) maxValue = value;
      } else {
        // Set value to lower limit for months with no data
        spots.add(FlSpot(5 - i.toDouble(), lowerLimit)); // Use lowerLimit for missing data
        print("No data for: $key, setting to lower limit");
      }
    }

    // Set minY and maxY based on the calculated min and max values
    double finalMinY = lowerLimit < minValue ? lowerLimit : minValue;
    double finalMaxY = upperLimit > maxValue ? upperLimit : maxValue;

    return Container(
      padding: EdgeInsets.only(top: 20.w, bottom: 4.h, right: 20.w),
      width: double.infinity,
      height: 240.h,
      decoration: BoxDecoration(
        color: secondary,
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
      ),
      child: spots.isNotEmpty
          ? LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
                  show: true,
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),

                  // X-Axis Title
                  bottomTitles: AxisTitles(
                    axisNameSize: 30.h,
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30.h,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        if (value.toInt() < monthNames.length) {
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(monthNames[value.toInt()], style: TextStyle(fontSize: 10.sp)),
                          );
                        }
                        return Container();
                      },
                    ),
                  ),

                  // Y-Axis Title
                  leftTitles: AxisTitles(
                    axisNameWidget: Text(
                      leftSideTitle,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w300,
                        color: white,
                      ),
                    ),
                    axisNameSize: 30.w,
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32.w,
                      interval: 10,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        return Text(
                          value.toInt().toString(),
                          style: TextStyle(fontSize: 10.sp),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: true, border: Border.all(color: Colors.transparent)),
                minX: 0,
                maxX: (spots.length - 1).toDouble(),
                minY: finalMinY, // Use calculated min value
                maxY: finalMaxY, // Use calculated max value
                lineBarsData: [
                  LineChartBarData(
                    dotData: const FlDotData(
                show: false, // Show dots for data points
              ),
                    spots: spots,
                    isCurved: true,
                    color: accent,
                    barWidth: 3.w,
                    isStrokeCapRound: true,
                    belowBarData: BarAreaData(show: true),
                  ),
                ],
              ),
            )
          : Center(
              child: Text(
                'No data found',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }
}
