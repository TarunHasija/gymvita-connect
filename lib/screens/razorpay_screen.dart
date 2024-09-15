import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gymvita_connect/utils/colors.dart';
import 'package:gymvita_connect/widgets/appbar.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayScreen extends StatefulWidget {
  const RazorpayScreen({super.key});

  @override
  State<RazorpayScreen> createState() => _RazorpayScreenState();
}

class _RazorpayScreenState extends State<RazorpayScreen> {
  late Razorpay _razorpay;
  TextEditingController amountController = TextEditingController();

  String razorpayKeyId = "rzp_test_clwiHIuZY3OkHp";
  String razorpayKeySecret = "55yEGDwXdmx3dUU3PdjHwQd5";

  void openCheckOut(amount) async {
    amount = amount * 100;
    var options = {
      'key': razorpayKeyId,
      'amount': amount,
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '9868101088', 'email': 'tarunhasija999@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error $e');
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Successfull ${response.paymentId!}",
        toastLength: Toast.LENGTH_SHORT);
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Failed${response.message!}",
        toastLength: Toast.LENGTH_SHORT);
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Failed${response.walletName!}",
        toastLength: Toast.LENGTH_SHORT);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Razorpay',
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20.h),
          child: Column(
            children: [
              SizedBox(
                height: 100.h,
              ),
              const Text('GymVita Connect'),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.all(8.h),
                child: TextFormField(
                  cursorColor: primary,
                  autofocus: false,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Enter amount to be paid',
                    labelStyle: TextStyle(color: grey, fontSize: 15.sp),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: grey,
                      width: 1.2.w,
                    )),
                    errorStyle: const TextStyle(color: Colors.red),
                  ),
                  controller: amountController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter amount';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  if (amountController.text.toString().isNotEmpty) {
                    setState(() {
                      int amount = int.parse(amountController.text.toString());
                      openCheckOut(amount);
                    });
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: Padding(
                  padding: EdgeInsets.all(8.h),
                  child: const Text("Make Payment"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
