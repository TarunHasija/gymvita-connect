import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymvita_connect/widgets/analysis/one_year_graph.dart';
import 'package:gymvita_connect/widgets/analysis/six_month_graph.dart';

Widget analysisGraph(dynamic theme,dynamic isSixMonth ,String title) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(title, style: theme.headlineSmall),
            ),
          ),
          isSixMonth?
          const SixMonthGraph():const OneYearGraph(),
        ],
      ),
    );
  }