import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:podium/src/app_bar_back_button/app_bar_back_button.dart';
// import 'package:stripe_checkout/stripe_checkout.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: PaymentsPage());

  // Function to launch URL
  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('PAYMENTS SCREEN LOADED');

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

    if (!kIsWeb) {
      initPaymentSheet();
    }

    // Future<void> displayPaymentDetailsModal(String clientSecret) async {
    //   return showDialog(
    //     context: context,
    //     builder: (context) {
    //       return Dialog(
    //         child: Column(
    //           children: [
    //             Padding(
    //               padding: const EdgeInsets.all(16),
    //               child: SizedBox(
    //                 width: 800,
    //                 child: CardField(
    //                   decoration: InputDecoration(
    //                     border: OutlineInputBorder(
    //                       borderSide: const BorderSide(
    //                         color: Colors.grey,
    //                       ),
    //                       borderRadius: BorderRadius.circular(8),
    //                     ),
    //                   ),
    //                   enablePostalCode: true,
    //                   postalCodeHintText: 'ZIP Code',
    //                   countryCode: 'US',
    //                 ),
    //               ),
    //             ),
    //             ElevatedButton(
    //               onPressed: () {
    //                 Stripe.instance.confirmPayment(
    //                   paymentIntentClientSecret: clientSecret,
    //                   data: const PaymentMethodParams.card(
    //                     paymentMethodData: PaymentMethodData(),
    //                   ),
    //                 );
    //               },
    //               child: const Text('Submit'),
    //             ),
    //           ],
    //         ),
    //       );
    //     },
    //   );
    // }

    Future<void> showWebPaymentSheet() async {
      try {
        final paymentScreen = await FirebaseFunctions.instance
            .httpsCallable('routeToStripeCheckout')
            // ignore: inference_failure_on_function_invocation
            .call({'value': 'passed to firebase'});
        // ignore: avoid_dynamic_calls
        await _launchUrl(paymentScreen.data['url'] as String);
        // debugPrint('paymentIntent.data: ${paymentIntent.data}');
      } on FirebaseFunctionsException catch (error) {
        debugPrint('error.code: ${error.code}');
        debugPrint('error.details: ${error.details}');
        debugPrint('error.message: ${error.message}');
      } catch (error) {
        debugPrint('Generic error not, not a FirebaseFunctionsException');
        debugPrint('error: $error');
      }
    }

    return Scaffold(
      appBar: !kIsWeb
          ? AppBar(
              leading: const AppBarBackButton(route: '/residentProfile'),
              backgroundColor: Colors.transparent,
              elevation: 0,
            )
          : null,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 40, 0, 40),
                child: Row(
                  children: const [
                    if (kIsWeb) AppBarBackButton(route: '/residentProfile'),
                    Text(
                      'Payments',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () async {
                  if (!kIsWeb) {
                    debugPrint('!kIsWeb');
                    await Stripe.instance.presentPaymentSheet();
                  } else {
                    debugPrint('kIsWeb');
                    await showWebPaymentSheet();
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'Make a Payment',
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
              // TextButton(
              //   onPressed: () {
              //     showDialog<void>(
              //       context: context,
              //       builder: (context) {
              //         return Dialog(
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(40),
              //           ),
              //           elevation: 16,
              //           child: const Placeholder(),
              //         );
              //       },
              //     );
              //   },
              //   child: const Padding(
              //     padding: EdgeInsets.all(12),
              //     child: Text(
              //       'Payment methods',
              //       style: TextStyle(
              //         fontSize: 14,
              //         fontWeight: FontWeight.w400,
              //         color: Colors.black,
              //       ),
              //     ),
              //   ),
              // ),
              // Divider(
              //   indent: 25,
              //   endIndent: 25,
              //   thickness: 0,
              //   color: Colors.grey.shade400,
              // ),
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
        ),
      ),
    );
  }
}
