import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymvita_connect/widgets/analysis/graphs/current_sixmonth_graph.dart';
import 'package:gymvita_connect/widgets/analysis/graphs/prev_sixmonth_graph.dart';

Widget analysisGraph(dynamic theme,dynamic isSixMonth ,String title ,String bodyPartName ,double upperLimit,double lowerLimit , String leftSideTitle) {
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
           CurrentSixMonthGraph(bodyPartName: bodyPartName, upperLimit: upperLimit, lowerLimit: lowerLimit, leftSideTitle: leftSideTitle,): PrevSixmonthGraph(bodyPartName: bodyPartName, upperLimit: upperLimit, lowerLimit: lowerLimit, leftSideTitle: leftSideTitle,),
        ],
      ),
    );
  }