import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:podium/src/service_requests/cubit/service_request_cubit.dart';
import 'package:podium/src/service_requests/view/service_request_call_support_button.dart';
import 'package:podium/src/service_requests/view/service_request_details_input.dart';

// Define a custom Form widget.
class ServiceRequestForm extends StatefulWidget {
  const ServiceRequestForm({super.key});

  @override
  ServiceRequestFormState createState() {
    return ServiceRequestFormState();
  }
}

class ServiceRequestFormState extends State<ServiceRequestForm> {
  File? fileController0;
  File? fileController1;
  File? fileController2;
  int activeFile = 0;
  Future<void> takePhoto(ImageSource source) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: source,
      maxWidth: 200,
      maxHeight: 250,
      imageQuality: 75,
    );
    debugPrint('image.path in takePhoto -> ${image?.path}');
    final xfileToFile = File(image!.path);

    switch (activeFile) {
      case 0:
        setState(() {
          fileController0 = xfileToFile;
        });
        break;
      case 1:
        setState(() {
          fileController1 = xfileToFile;
        });
        break;
      case 2:
        setState(() {
          fileController2 = xfileToFile;
        });
        break;
      default:
    }
    debugPrint('xfileToFile: $xfileToFile');
    debugPrint('fileController0: $fileController0');
    debugPrint('fileController1: $fileController1');
    debugPrint('fileController2: $fileController2');
  }

  Widget pictureBox1Child() {
    if (fileController0 != null && fileController1 == null) {
      return const Icon(Icons.add);
    } else if (fileController1 != null) {
      return Image.asset(
        fileController1!.path,
      );
    } else {
      return const Text('');
    }
  }

  Widget pictureBox2Child() {
    if (fileController0 != null &&
        fileController1 != null &&
        fileController2 == null) {
      return const Icon(Icons.add);
    } else if (fileController2 != null) {
      return Image.asset(
        fileController2!.path,
      );
    } else {
      return const Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ServiceRequestCubit, ServiceRequestState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ),
            );
        } else if (state.status.isSuccess) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ListView(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: Text(
                        'Service Requests',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const CallSupportButton(),
                    const DetailsInput(),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 250,
                          width: MediaQuery.of(context).size.width < 700
                              ? MediaQuery.of(context).size.width * .30
                              : 200,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                activeFile = 0;
                              });
                              takePhoto(ImageSource.camera);
                            },
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: fileController0 == null
                                    ? const Icon(Icons.camera_alt)
                                    : Image.asset(
                                        fileController0!.path,
                                      ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 250,
                          width: MediaQuery.of(context).size.width < 700
                              ? MediaQuery.of(context).size.width * .30
                              : 200,
                          child: GestureDetector(
                            onTap: () {
                              if (fileController0 == null) return;
                              setState(() {
                                activeFile = 1;
                              });
                              takePhoto(ImageSource.camera);
                            },
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: pictureBox1Child(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 250,
                          width: MediaQuery.of(context).size.width < 700
                              ? MediaQuery.of(context).size.width * .30
                              : 200,
                          child: GestureDetector(
                            onTap: () {
                              if (fileController0 == null ||
                                  fileController1 == null) return;
                              setState(() {
                                activeFile = 2;
                              });
                              takePhoto(ImageSource.camera);
                            },
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: pictureBox2Child(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: SizedBox(
                        height: 48.675,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: const ButtonStyle(
                            shadowColor:
                                MaterialStatePropertyAll(Colors.transparent),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                              ),
                            ),
                            side: MaterialStatePropertyAll(
                              BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.white),
                            foregroundColor:
                                MaterialStatePropertyAll(Colors.black),
                          ),
                          onPressed: () => ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              const SnackBar(
                                content: Text('Service Request Submitted'),
                              ),
                            ),
                          child: const Text('Submit'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
