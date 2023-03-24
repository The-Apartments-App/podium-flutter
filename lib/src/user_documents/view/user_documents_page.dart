import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:podium/src/app/app.dart';
import 'package:podium/src/lease_reader/lease_reader.dart';

class DocumentsPage extends StatelessWidget {
  const DocumentsPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: DocumentsPage());

  @override
  Widget build(BuildContext context) {
    debugPrint('DOCUMENTS SCREEN LOADED');
    return Scaffold(
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
      body: Column(
        children: [
          const Text(
            'This is where you will find all of your documents.',
          ),
          TextButton(
            onPressed: () {
              showDialog(
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
              padding: EdgeInsets.fromLTRB(64, 32, 64, 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
