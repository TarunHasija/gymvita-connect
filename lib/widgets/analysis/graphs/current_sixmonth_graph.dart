import 'dart:collection';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart'; // For formatting the month names
import 'package:get/get.dart';
import 'package:gymvita_connect/controllers/analysis_graph_controller.dart';
import 'package:gymvita_connect/utils/colors.dart';

class CurrentSixMonthGraph extends StatelessWidget {
  final String bodyPartName; // Name of the body part
  final double upperLimit; // Upper limit for the graph
  final double lowerLimit; // Lower limit for the graph
  final String leftSideTitle; // Y-axis title

  const CurrentSixMonthGraph({
    super.key,
    required this.bodyPartName,
    required this.upperLimit,
    required this.lowerLimit,
    required this.leftSideTitle,
  });

  @override
  Widget build(BuildContext context) {
    final AnalysisGraphController analysisGraphController =
        Get.find<AnalysisGraphController>();

    // Fetch body part data for the last 6 months
    LinkedHashMap<String, dynamic> bodyPartData =
        analysisGraphController.getLastSixMonthsData(bodyPartName);

    if (bodyPartData.isEmpty) {
      return Center(child: Text("No data available"));
    }

    // Prepare spots for the graph
    List<FlSpot> spots = [];
    int index = 0;

    // Get current month and year for the x-axis labels
    DateTime now = DateTime.now();
    List<String> monthNames = [];

    // Create month names for the last six months, including current month
    for (int i = 0; i < 6; i++) {
      DateTime monthDate = DateTime(now.year, now.month - i, 1);
      monthNames.add(DateFormat('MMM').format(monthDate).toLowerCase());
    }

    // Initialize min and max values
    double minValue = double.infinity;
    double maxValue = double.negativeInfinity;
    double lastKnownValue = lowerLimit; // Start with lower limit

    // Loop through the last 6 months in reverse order
    for (int i = 5; i >= 0; i--) {
      String month = monthNames[i];
      String key = '$month ${now.year}';

      // Check if the key exists in bodyPartData
      if (bodyPartData.containsKey(key)) {
        // Convert the value to double explicitly
        double value = (bodyPartData[key] is int)
            ? (bodyPartData[key] as int).toDouble()
            : bodyPartData[key] as double;

        spots.add(FlSpot(index.toDouble(), value));

        // Update min and max values
        if (value < minValue) minValue = value;
        if (value > maxValue) maxValue = value;

        lastKnownValue = value; // Update last known value
      } else {
        // If there's no data for this month, use the last known value or lower limit
        spots.add(FlSpot(index.toDouble(), lastKnownValue < lowerLimit ? lowerLimit : lastKnownValue));
      }
      index++;
    }

    // Set minY and maxY based on the calculated min and max values
    double finalMinY = lowerLimit < minValue ? lowerLimit : minValue;
    double finalMaxY = upperLimit > maxValue ? upperLimit : maxValue;

    return Container(
      padding: EdgeInsets.only(top: 20.w, bottom: 4.h, right: 20.w),
      width: double.infinity,
      height: 240.h, // Apply ScreenUtil scaling to height
      decoration: BoxDecoration(
        color: secondary,
        borderRadius: BorderRadius.all(
            Radius.circular(10.r)), // Apply ScreenUtil scaling here
      ),
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
            show: true,
            topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)), // No top titles
            rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false)), // No right titles

            // X-Axis Title
            bottomTitles: AxisTitles(
              axisNameSize: 30.h,
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30.h, // Apply ScreenUtil scaling here
                getTitlesWidget: (double value, TitleMeta meta) {
                  if (value.toInt() < monthNames.length) {
                    return SideTitleWidget(
                      axisSide: meta.axisSide,
                      child: Text(
                          monthNames[monthNames.length - 1 - value.toInt()],
                          style: TextStyle(
                              fontSize: 10.sp)), // Apply ScreenUtil scaling here
                    );
                  }
                  return Container();
                },
              ),
            ),
            // Y-Axis Title
            leftTitles: AxisTitles(
              axisNameWidget: Text(
                leftSideTitle, // Y-Axis Label from parameter
                style: TextStyle(
                  fontSize: 12.sp, // Customize font size
                  fontWeight: FontWeight.w300,
                  color: white,
                ),
              ),
              axisNameSize: 30.w, // Adjust the space for the axis name
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 32.w, // Apply ScreenUtil scaling here
                interval: 10, // Set interval for Y-axis labels to 10
                getTitlesWidget: (double value, TitleMeta meta) {
                  return Text(
                    value.toInt().toString(),
                    style: TextStyle(
                        fontSize: 10.sp), // Apply ScreenUtil scaling here
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(
              show: true, border: Border.all(color: Colors.transparent)),
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
              barWidth: 3.w, // Reduced width of the line (adjust as needed)
              isStrokeCapRound: true,
              belowBarData: BarAreaData(show: true),
            ),
          ],
        ),
      ),
    );
  }
}
