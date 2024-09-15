import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymvita_connect/utils/colors.dart';

class NutritionPlanTile extends StatefulWidget {
  const NutritionPlanTile({
    super.key,
  });

  @override
  State<NutritionPlanTile> createState() => _NutritionPlanTileState();
}

class _NutritionPlanTileState extends State<NutritionPlanTile> {
  @override
  Widget build(BuildContext context) {
    final List<String> textItems = [
      'Flutter',
      'is',
      'an',
      // 'amazing',
      // 'an',
      // 'framework',
      // 'for',
      // 'building',
      // 'cross-platform',
      // 'applications',
    ];

    TextTheme theme = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        border: const Border(left: BorderSide(width: 5, color: accent)),
        color: secondary,
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.all(15.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Time', style: theme.bodyMedium),
              Text('Header', style: theme.bodyMedium),
            ],
          ),
          SizedBox(height: 10.h),
          // Wrap automatically adjusts height based on the number of items
          Align(
            alignment: Alignment.centerRight,
            child: Wrap(
              spacing: 10.w, // Horizontal spacing between items
              runSpacing: 6.h, // Vertical spacing between lines
              children: textItems.map((text) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: accent),
                  ),
                  child: Text(
                    text,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

