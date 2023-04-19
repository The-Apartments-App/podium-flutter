import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:podium/src/appbar_back_button/appbar_back_button.dart';
import 'package:podium/src/resident_portal/user_payments/user_payments.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: PaymentsPage());

  @override
  Widget build(BuildContext context) {
    Future<void> initPaymentSheet() async {
      try {
        // 1. create payment intent on the server
        // final data = await _createTestPaymentSheet();

        // 2. initialize the payment sheet
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: const SetupPaymentSheetParameters(
            // Enable custom flow
            customFlow: true,
            // Main params
            merchantDisplayName: 'Flutter Stripe Store Demo',
            // applePay: true,
            // googlePay: true,
            style: ThemeMode.dark,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
        rethrow;
      }
    }

    initPaymentSheet();
    debugPrint('PAYMENTS SCREEN LOADED');
    const textStyle = TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    );

    return BlocProvider(
      create: (context) => PaymentBloc(),
      child: Scaffold(
        appBar: AppBar(
          leading: const AppBarBackButton(),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: BlocBuilder<PaymentBloc, PaymentState>(
          builder: (context, state) {
            return Column(
              children: [
                const Text(
                  r'Amount Due: $0',
                  style: textStyle,
                ),
                SizedBox(
                  height: 32,
                  width: MediaQuery.of(context).size.width,
                ),
                ElevatedButton(
                  onPressed: Stripe.instance.presentPaymentSheet,
                  child: const Text('Open Payment Sheet'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
