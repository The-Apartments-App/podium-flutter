import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:podium/src/app/app.dart';
import 'package:podium/src/user_payments/bloc/payments_bloc.dart';

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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => {
              context.flow<AppPage>().update((state) => AppPage.userHome),
            },
          ),
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
