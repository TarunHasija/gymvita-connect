import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymvita_connect/widgets/payment/payment_tile.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  DateTime dummyDate = DateTime(2024, 7, 22, 17, 22);

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                PaymentTile(
                    paymentRefNo: 'vhvje-hvkhwe-bjhjw',
                    date: dummyDate,
                    amount: '1500',
                    paymentMethod: 'UPI'),
                PaymentTile(
                    paymentRefNo: 'vhvje-hvkhwe-bjhjw',
                    date: dummyDate,
                    amount: '1500',
                    paymentMethod: 'UPI'),
                PaymentTile(
                    paymentRefNo: 'vhvje-hvkhwe-bjhjw',
                    date: dummyDate,
                    amount: '1500',
                    paymentMethod: 'UPI'),
                PaymentTile(
                    paymentRefNo: 'vhvje-hvkhwe-bjhjw',
                    date: dummyDate,
                    amount: '1500',
                    paymentMethod: 'UPI'),
                PaymentTile(
                    paymentRefNo: 'vhvje-hvkhwe-bjhjw',
                    date: dummyDate,
                    amount: '1500',
                    paymentMethod: 'UPI'),
                PaymentTile(
                    paymentRefNo: 'vhvje-hvkhwe-bjhjw',
                    date: dummyDate,
                    amount: '1500',
                    paymentMethod: 'UPI'),
                PaymentTile(
                    paymentRefNo: 'vhvje-hvkhwe-bjhjw',
                    date: dummyDate,
                    amount: '1500',
                    paymentMethod: 'UPI'),
                PaymentTile(
                    paymentRefNo: 'vhvje-hvkhwe-bjhjw',
                    date: dummyDate,
                    amount: '1500',
                    paymentMethod: 'UPI'),
                PaymentTile(
                    paymentRefNo: 'vhvje-hvkhwe-bjhjw',
                    date: dummyDate,
                    amount: '1500',
                    paymentMethod: 'UPI'),
                PaymentTile(
                    paymentRefNo: 'vhvje-hvkhwe-bjhjw',
                    date: dummyDate,
                    amount: '1500',
                    paymentMethod: 'UPI'),
                PaymentTile(
                    paymentRefNo: 'vhvje-hvkhwe-bjhjw',
                    date: dummyDate,
                    amount: '1500',
                    paymentMethod: 'UPI'),
                PaymentTile(
                    paymentRefNo: 'vhvje-hvkhwe-bjhjw',
                    date: dummyDate,
                    amount: '1500',
                    paymentMethod: 'UPI'),
              ],
            ),
          ),
        ));
  }
}
