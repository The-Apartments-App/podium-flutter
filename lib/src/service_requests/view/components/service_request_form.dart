import 'package:emailjs/emailjs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:podium/src/service_requests/cubit/service_request_cubit.dart';
import 'package:podium/src/service_requests/view/components/service_request_call_support_button.dart';
import 'package:podium/src/service_requests/view/components/service_request_details_input.dart';
import 'package:podium/src/service_requests/view/components/service_request_image.dart';
import 'package:podium/src/service_requests/view/components/service_request_image_container.dart';

// Define a custom Form widget.
class ServiceRequestForm extends StatefulWidget {
  const ServiceRequestForm({super.key});

  @override
  ServiceRequestFormState createState() {
    return ServiceRequestFormState();
  }
}

class ServiceRequestFormState extends State<ServiceRequestForm> {
  Uint8List? imageBytes0;
  Uint8List? imageBytes1;
  Uint8List? imageBytes2;
  int activeFile = 0;

  TextEditingController detailsInputController = TextEditingController();
  Future<void> takePhoto() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 200,
      maxHeight: 250,
      imageQuality: 75,
    );
    final imageBytes = await image!.readAsBytes();

    switch (activeFile) {
      case 0:
        setState(() {
          imageBytes0 = imageBytes;
        });
        break;
      case 1:
        setState(() {
          imageBytes1 = imageBytes;
        });
        break;
      case 2:
        setState(() {
          imageBytes2 = imageBytes;
        });
        break;
      default:
    }
  }

  Widget pictureBox1Child() {
    if (imageBytes0 != null && imageBytes1 == null) {
      return const Icon(Icons.add);
    } else if (imageBytes1 != null) {
      return ServiceRequestImage(
        bytes: imageBytes1!,
      );
    } else {
      return const Text('');
    }
  }

  Widget pictureBox2Child() {
    if (imageBytes0 != null && imageBytes1 != null && imageBytes2 == null) {
      return const Icon(Icons.add);
    } else if (imageBytes2 != null) {
      return ServiceRequestImage(
        bytes: imageBytes2!,
      );
    } else {
      return const Text('');
    }
  }

  Future<void> sendServiceRequest(BuildContext context) async {
    // final privateKey = dotenv.env['EMAILJS_PRIVATE_KEY'];
    // final serviceID =
    //     dotenv.env['EMAILJS_SERVICE_ID'] ?? 'No service ID available';
    // final templateID =
    //     dotenv.env['EMAILJS_TEMPLATE_ID'] ?? 'No template ID available';
    const privateKey = 'tkDacOuC2kK9X6eBYw6LA';
    const serviceID = 'service_lslzt23';
    const templateID = 'template_xz7u84j';
    try {
      if (detailsInputController.text.isEmpty) {
        await showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Failure.'),
            content: const Text('Your message has not been sent.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
        return;
      }
      await EmailJS.send(
        serviceID,
        templateID,
        {
          'message': detailsInputController.text,
        },
        const Options(
          publicKey: 'MmTXgvYuIKZsRmifl',
          privateKey: privateKey,
        ),
      );
      debugPrint('SUCCESS!');
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Success!'),
          content: const Text('Your message has been sent.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    } catch (error) {
      if (error is EmailJSResponseStatus) {
        debugPrint('ERROR... ${error.status}: ${error.text}');
      }
      debugPrint(error.toString());
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
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Padding(
              padding: const EdgeInsets.all(20),
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
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            activeFile = 0;
                          });
                          takePhoto();
                        },
                        child: ServiceRequestImageContainer(
                          child: imageBytes0 == null
                              ? const Center(
                                  child: Icon(Icons.camera_alt),
                                )
                              : ServiceRequestImage(
                                  bytes: imageBytes0!,
                                ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (imageBytes0 == null) return;
                          setState(() {
                            activeFile = 1;
                          });
                          takePhoto();
                        },
                        child: ServiceRequestImageContainer(
                          child: pictureBox1Child(),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (imageBytes0 == null || imageBytes1 == null) {
                            return;
                          }
                          setState(() {
                            activeFile = 2;
                          });
                          takePhoto();
                        },
                        child: ServiceRequestImageContainer(
                          child: pictureBox2Child(),
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
                        onPressed: () => {
                          if (true)
                            {
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  const SnackBar(
                                    content: Text('Service Request Submitted'),
                                  ),
                                ),
                              sendServiceRequest(context),
                            }
                        },
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
    );
  }
}
