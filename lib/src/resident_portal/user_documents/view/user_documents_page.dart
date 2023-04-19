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
        children: [
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
            child: Padding(
              padding: const EdgeInsets.fromLTRB(64, 32, 64, 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'View Lease',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Icon(
                    Icons.account_circle,
                    size: 36,
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
