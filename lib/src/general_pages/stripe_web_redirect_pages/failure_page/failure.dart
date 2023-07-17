import 'package:flutter/material.dart';

class FailurePage extends StatelessWidget {
  const FailurePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Failure'),
      ),
      body: const Center(
        child: Text('Oops, your payment failed. Please try again.'),
      ),
    );
  }
}
