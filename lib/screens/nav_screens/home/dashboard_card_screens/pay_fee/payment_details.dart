import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymvita_connect/screens/nav_screens/home/dashboard_card_screens/pay_fee/payfee.dart';

class PaymentDetails extends StatelessWidget {
  final int selectedValue;
  const PaymentDetails({super.key, required this.selectedValue});

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PayFee()));
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text('Payment History',
                style: theme.displayMedium?.copyWith(fontSize: 24.sp)),
          ),
        ],
      ),
      body: Text(selectedValue.toString()),
    );
  }
}
