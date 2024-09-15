import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymvita_connect/utils/colors.dart';
import 'package:intl/intl.dart'; 

class PaymentTile extends StatefulWidget {
  final String paymentRefNo;
  final DateTime date;
  final String amount;
  final String paymentMethod;

  const PaymentTile({
    super.key,
    required this.paymentRefNo,
    required this.date,
    required this.amount,
    required this.paymentMethod,
  });

  @override
  State<PaymentTile> createState() => _PaymentTileState();
}

class _PaymentTileState extends State<PaymentTile> {

  
  @override
  Widget build(BuildContext context) {
    // Format the date to "22 Jul 05:22 pm"
        TextTheme theme = Theme.of(context).textTheme;

    String formattedDate = DateFormat('d MMM hh:mm a').format(widget.date);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: secondary,
        borderRadius: BorderRadius.circular(10.r)
      ),
      padding: EdgeInsets.all(15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.paymentRefNo,style: theme.bodyMedium,),
              SizedBox(height: 5.h,),
              Text('Paid on $formattedDate',style: theme.displaySmall?.copyWith(color: grey),),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Rs. ${widget.amount}',style: theme.bodySmall?.copyWith(color: accent,fontWeight: FontWeight.bold),),
              SizedBox(height: 5.h,),
              Text(widget.paymentMethod,style: theme.displaySmall?.copyWith(color: grey),),
            ],
          )
        ],
      ),
    );
  }
}
