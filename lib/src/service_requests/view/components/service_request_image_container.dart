import 'package:flutter/material.dart';
import 'package:podium/shared/shared.dart';

class ServiceRequestImageContainer extends StatelessWidget {
  const ServiceRequestImageContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: isMobile(context) ? MediaQuery.of(context).size.width * .28 : 100,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
