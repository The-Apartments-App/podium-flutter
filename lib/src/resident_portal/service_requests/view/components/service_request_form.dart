import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:podium/src/resident_portal/service_requests/cubit/service_request_cubit.dart';
import 'package:podium/src/resident_portal/service_requests/view/components/service_request_call_support_button.dart';
import 'package:podium/src/resident_portal/service_requests/view/components/service_request_details_input.dart';
import 'package:podium/src/resident_portal/service_requests/view/components/service_request_image.dart';
import 'package:podium/src/resident_portal/service_requests/view/components/service_request_image_container.dart';
import 'package:podium/src/shared/components/app_bar_back_button.dart';

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
      maxHeight: 300,
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
      return const Icon(Icons.add_a_photo);
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
      return const Icon(Icons.add_a_photo);
    } else if (imageBytes2 != null) {
      return ServiceRequestImage(
        bytes: imageBytes2!,
      );
    } else {
      return const Text('');
    }
  }

  Future<void> sendServiceRequest() async {
    final email = Email(
      body: detailsInputController.text,
      subject: 'Podium Service Request',
      recipients: ['maintenance@podiumapartments.com'],
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      if (kDebugMode) {
        print(error);
      }
      platformResponse = error.toString();
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
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
        extendBodyBehindAppBar: true,
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: const [
                        if (kIsWeb) AppBarBackButton(route: '/residentProfile'),
                        Text(
                          'Service Requests',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const CallSupportButton(),
                  const SizedBox(height: 30),
                  const Divider(),
                  const SizedBox(height: 30),
                  const DetailsInput(),
                  const SizedBox(height: 8),
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
                              ? const Center(child: Icon(Icons.camera_alt))
                              : ServiceRequestImage(bytes: imageBytes0!),
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
                    padding: const EdgeInsets.only(top: 32),
                    child: SizedBox(
                      height: 48.675,
                      width: MediaQuery.of(context).size.width,
                      child: PlatformElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              const SnackBar(
                                content: Text('Service Request Submitted'),
                              ),
                            );
                          sendServiceRequest();
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
