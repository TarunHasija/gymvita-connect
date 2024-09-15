import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymvita_connect/utils/colors.dart';

class PayAmountTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final int value;
  final int groupValue;
  final Function(int?) onChanged;
  
  const PayAmountTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  State<PayAmountTile> createState() => _PayAmountTileState();
}

class _PayAmountTileState extends State<PayAmountTile> {
  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;

    return InkWell(
      onTap: () => widget.onChanged(widget.value),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
        child: Row(
          children: [
            Radio<int>(
              value: widget.value,
              groupValue: widget.groupValue,
              onChanged: widget.onChanged,
              activeColor: accent,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.title, style: theme.bodySmall),
                  SizedBox(height: 2.h),
                  Text(widget.subtitle, style: theme.bodySmall?.copyWith(color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
