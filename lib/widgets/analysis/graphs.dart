import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BodyPartGraph extends StatelessWidget {
  final Map<String, dynamic> bodyPartValues;
  final bool isLastSixMonths;

  const BodyPartGraph({
    Key? key,
    required this.bodyPartValues,
    this.isLastSixMonths = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) {
                // Convert the double value back to month name for the X-axis
                List<String> months = [
                  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
                ];
                return Text(months[value.toInt() - 1]);
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, _) {
                // Y-axis labels
                return Text(value.toString());
              },
            ),
          ),
        ),
        gridData: FlGridData(show: true),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: isLastSixMonths ? _getLastSixMonthsData() : _getLastOneYearData(),
            isCurved: true,
            barWidth: 2,
            color: Colors.blue,
            dotData: FlDotData(show: true),
          ),
        ],
      ),
    );
  }

  List<FlSpot> _getLastSixMonthsData() {
    List<FlSpot> spots = [];
    DateTime now = DateTime.now();
    DateTime sixMonthsAgo = DateTime(now.year, now.month - 5);

    bodyPartValues.forEach((year, monthsData) {
      if (monthsData is Map<String, dynamic>) {
        monthsData.forEach((month, value) {
          int monthNumber = _getMonthNumber(month);
          DateTime dataDate = DateTime(int.parse(year), monthNumber);

          if (dataDate.isAfter(sixMonthsAgo) && dataDate.isBefore(now.add(Duration(days: 1)))) {
            double yValue = value.toDouble();
            spots.add(FlSpot(monthNumber.toDouble(), yValue));
          }
        });
      }
    });

    // Sort spots by X value (month number) for accurate plotting
    spots.sort((a, b) => a.x.compareTo(b.x));

    return spots;
  }

  List<FlSpot> _getLastOneYearData() {
    List<FlSpot> spots = [];
    DateTime now = DateTime.now();
    DateTime oneYearAgo = DateTime(now.year - 1, now.month + 1); // 1 year back

    bodyPartValues.forEach((year, monthsData) {
      if (monthsData is Map<String, dynamic>) {
        monthsData.forEach((month, value) {
          int monthNumber = _getMonthNumber(month);
          DateTime dataDate = DateTime(int.parse(year), monthNumber);

          if (dataDate.isAfter(oneYearAgo) && dataDate.isBefore(now.add(Duration(days: 1)))) {
            double yValue = value.toDouble();
            spots.add(FlSpot(monthNumber.toDouble(), yValue));
          }
        });
      }
    });

    // Sort spots by X value (month number) for accurate plotting
    spots.sort((a, b) => a.x.compareTo(b.x));

    return spots;
  }

  int _getMonthNumber(String monthName) {
    const List<String> months = [
      'jan', 'feb', 'mar', 'apr', 'may', 'jun',
      'jul', 'aug', 'sep', 'oct', 'nov', 'dec'
    ];
    return months.indexOf(monthName.toLowerCase()) + 1;
  }
}
