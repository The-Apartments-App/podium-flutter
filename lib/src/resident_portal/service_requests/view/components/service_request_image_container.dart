import 'package:flutter/material.dart';

class ServiceRequestImageContainer extends StatelessWidget {
  const ServiceRequestImageContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10, // Adjust this value for desired shadow effect
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Add border radius
      ),
      child: SizedBox(
        height: 200,
        width: MediaQuery.of(context).size.width < 700
            ? MediaQuery.of(context).size.width * .28
            : 150,
        child: child,
      ),
    );
  }
}
