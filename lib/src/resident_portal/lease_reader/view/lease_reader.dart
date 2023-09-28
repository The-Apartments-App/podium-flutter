// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class LeaseReader extends StatelessWidget {
  const LeaseReader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .95,
      width: MediaQuery.of(context).size.width * .95,
      child: const PDFScreen(),
    );
  }
}

class PDFScreen extends StatefulWidget {
  const PDFScreen({
    super.key,
    this.path,
  });
  final String? path;

  @override
  PDFScreenState createState() => PDFScreenState();
}

class PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  String urlPDFPath = '';
  bool exists = true;
  bool loaded = false;
  String pdfUrl = '';

  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  late PDFViewController _pdfViewController;

  Future<String> getPdfUrl() async {
    final storageRef = FirebaseStorage.instance.ref();
    debugPrint('storageRef: $storageRef');
    final userLeaseAgreementRef = storageRef.child(
      'users/${FirebaseAuth.instance.currentUser?.uid}/lease_agreement/Washington-Standard-Residential-Lease-Agreement-Template.pdf',
    );
    debugPrint('userLeaseAgreementRef: $userLeaseAgreementRef');
    pdfUrl = await userLeaseAgreementRef.getDownloadURL();
    debugPrint('pdfUrl: $pdfUrl');
    return pdfUrl;
  }

  Future<File> getFileFromUrl(String url, String name) async {
    try {
      final data = await http.get(Uri.parse(url));
      final bytes = data.bodyBytes;
      final dir = await getApplicationDocumentsDirectory();
      final file = File(
        '${dir.path}/Washington-Standard-Residential-Lease-Agreement-Template.pdf',
      );
      debugPrint('dir.path: ${dir.path}');
      final urlFile = await file.writeAsBytes(bytes);
      debugPrint('urlFile: $urlFile');
      return urlFile;
    } catch (e) {
      throw Exception('Error opening url file');
    }
  }

  Future<void> requestPersmission() async {
    // await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    await Permission.storage.request().isGranted;
    await getPdfUrl();
  }

  @override
  void initState() {
    requestPersmission().then(
      (_) => {
        debugPrint('this is pdfUrl in initstate: $pdfUrl'),
        getFileFromUrl(pdfUrl, 'who cares').then(
          (value) => {
            setState(() {
              // ignore: unnecessary_null_comparison
              if (value != null) {
                debugPrint('value.path : ${value.path}');
                urlPDFPath = value.path;
                loaded = true;
                exists = true;
              } else {
                exists = false;
              }
            })
          },
        )
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(urlPDFPath);
    if (loaded) {
      return Scaffold(
        body: PDFView(
          filePath: urlPDFPath,
          swipeHorizontal: true,
          onError: (e) {
            //Show some error message or UI
          },
          onRender: (pages) {
            setState(() {
              _totalPages = pages!;
              pdfReady = true;
            });
          },
          onViewCreated: (PDFViewController vc) {
            setState(() {
              _pdfViewController = vc;
            });
          },
          onPageChanged: (int? page, int? total) {
            setState(() {
              _currentPage = page!;
            });
          },
          onPageError: (page, e) {},
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.chevron_left),
              iconSize: 50,
              color: Colors.black,
              onPressed: () {
                setState(() {
                  if (_currentPage > 0) {
                    _currentPage--;
                    _pdfViewController.setPage(_currentPage);
                  }
                });
              },
            ),
            Text(
              '${_currentPage + 1}/$_totalPages',
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              iconSize: 50,
              color: Colors.black,
              onPressed: () {
                setState(() {
                  if (_currentPage < _totalPages - 1) {
                    _currentPage++;
                    _pdfViewController.setPage(_currentPage);
                  }
                });
              },
            ),
          ],
        ),
      );
    } else {
      if (exists) {
        //Replace with your loading UI
        return const Scaffold(
          body: Text(
            'Loading..',
            style: TextStyle(fontSize: 20),
          ),
        );
      } else {
        //Replace Error UI
        return Scaffold(
          appBar: AppBar(
            title: const Text('Demo'),
          ),
          body: const Text(
            'PDF Not Available',
            style: TextStyle(fontSize: 20),
          ),
        );
      }
    }
  }
}
