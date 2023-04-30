import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:podium/src/appbar_back_button/appbar_back_button.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: PaymentsPage());

  @override
  Widget build(BuildContext context) {
    debugPrint('PAYMENTS SCREEN LOADED');
    // Future<void> initPaymentSheet() async {
    //   try {
    //     // 1. create payment intent on the server
    //     // final data = await _createTestPaymentSheet();

    //     // 2. initialize the payment sheet
    //     await Stripe.instance.initPaymentSheet(
    //       paymentSheetParameters: const SetupPaymentSheetParameters(
    //         // Enable custom flow
    //         customFlow: true,
    //         // Main params
    //         merchantDisplayName: 'Flutter Stripe Store Demo',
    //         // applePay: true,
    //         // googlePay: true,
    //         style: ThemeMode.dark,
    //       ),
    //     );
    //   } catch (e) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text('Error: $e')),
    //     );
    //     rethrow;
    //   }
    // }

    // initPaymentSheet();

    //   return BlocProvider(
    //     create: (context) => PaymentBloc(),
    //     child: Scaffold(
    //       appBar: AppBar(
    //         leading: const AppBarBackButton(),
    //         backgroundColor: Colors.transparent,
    //         elevation: 0,
    //       ),
    //       body: BlocBuilder<PaymentBloc, PaymentState>(
    //         builder: (context, state) {
    //           return Column(
    //             children: [
    //               const Text(
    //                 r'Amount Due: $0',
    //                 style: textStyle,
    //               ),
    //               SizedBox(
    //                 height: 32,
    //                 width: MediaQuery.of(context).size.width,
    //               ),
    //               ElevatedButton(
    //                 onPressed: Stripe.instance.presentPaymentSheet,
    //                 child: const Text('Open Payment Sheet'),
    //               ),
    //             ],
    //           );
    //         },
    //       ),
    //     ),
    //   );
    // }
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarBackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 40, 0, 40),
            child: Text(
              'Payments',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    elevation: 16,
                    child: const Placeholder(),
                  );
                },
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'Payment methods',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Divider(
            indent: 25,
            endIndent: 25,
            thickness: 0,
            color: Colors.grey.shade400,
          ),
          TextButton(
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    elevation: 16,
                    child: const Placeholder(),
                  );
                },
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'Statement history',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Divider(
            indent: 25,
            endIndent: 25,
            thickness: 0,
            color: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }
}
