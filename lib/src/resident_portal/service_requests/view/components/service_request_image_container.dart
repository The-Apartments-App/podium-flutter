import 'package:flutter/material.dart';
import 'package:podium/src/shared/shared_index.dart';

class ServiceRequestImageContainer extends StatelessWidget {
  const ServiceRequestImageContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: SizedBox(
        height: 350,
        width:
            isMobile(context) ? MediaQuery.of(context).size.width * .28 : 200,
        child: child,
      ),
    );
  }
}
