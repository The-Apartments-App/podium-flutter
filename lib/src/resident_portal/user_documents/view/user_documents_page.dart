import 'package:flutter/material.dart';
import 'package:podium/src/appbar_back_button/appbar_back_button.dart';
import 'package:podium/src/lease_reader/lease_reader.dart';

class DocumentsPage extends StatelessWidget {
  const DocumentsPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: DocumentsPage());

  @override
  Widget build(BuildContext context) {
    debugPrint('DOCUMENTS SCREEN LOADED');
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
              'Documents',
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
                    child: const LeaseReader(),
                  );
                },
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'View Lease',
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
                    child: const LeaseReader(),
                  );
                },
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'Terms of service',
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
                    child: const LeaseReader(),
                  );
                },
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'Privacy policy',
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
