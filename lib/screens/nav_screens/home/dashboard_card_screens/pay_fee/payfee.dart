import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymvita_connect/screens/nav_screens/home/dashboard_card_screens/pay_fee/payment_details.dart';
import 'package:gymvita_connect/utils/colors.dart';
import 'package:gymvita_connect/widgets/payment/pay_amount_tile.dart';

class PayFee extends StatefulWidget {
  const PayFee({super.key});

  @override
  State<PayFee> createState() => _PayFeeState();
}

class _PayFeeState extends State<PayFee> {
  int selectedValue = 1;
  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text('Payment Fee',
                style: theme.displayMedium?.copyWith(fontSize: 24.sp)),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Choose Your Plan',
                  style: GoogleFonts.lato(textStyle: theme.labelMedium),
                )),
            SizedBox(
              height: 20.h,
            ),
            Container(
              // margin: EdgeInsets.symmetric(vertical: 20.h,horizontal: 20.w),
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: white, width: 2.h),
                  color: secondary),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PayAmountTile(
                      title: '1 Month Subscription',
                      subtitle: 'Rs 1500',
                      value: 1,
                      groupValue: selectedValue,
                      onChanged: (int? value) {
                        setState(() {
                          selectedValue = value!;
                        });
                      }),
                  const Divider(
                    color: grey,
                  ),
                  PayAmountTile(
                      title: '3 Month Subscription',
                      subtitle: 'Rs 4500',
                      value: 2,
                      groupValue: selectedValue,
                      onChanged: (int? value) {
                        setState(() {
                          selectedValue = value!;
                        });
                      }),
                  const Divider(
                    color: grey,
                  ),
                  PayAmountTile(
                      title: '6 Month Subscription',
                      subtitle: 'Rs 8000',
                      value: 3,
                      groupValue: selectedValue,
                      onChanged: (int? value) {
                        setState(() {
                          selectedValue = value!;
                        });
                      }),
                  const Divider(
                    color: grey,
                  ),
                  PayAmountTile(
                      title: '12 Month Subscription',
                      subtitle: 'Rs 15000',
                      value: 4,
                      groupValue: selectedValue,
                      onChanged: (int? value) {
                        setState(() {
                          selectedValue = value!;
                        });
                      }),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => (PaymentDetails(
                              selectedValue: selectedValue,
                            ))));
              },
              child: IntrinsicWidth(
                child: Container(
                    // width: 150.h,
                    alignment: Alignment.center,
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                    decoration: BoxDecoration(
                        color: accent, borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        const Text(
                          "Pay",
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16.h,
                          color: Colors.black,
                        )
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
