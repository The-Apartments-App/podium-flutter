import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:podium/src/service_requests/cubit/service_request_cubit.dart';

// Define a custom Form widget.
class ServiceRequestForm extends StatefulWidget {
  const ServiceRequestForm({super.key});

  @override
  ServiceRequestFormState createState() {
    return ServiceRequestFormState();
  }
}

class ServiceRequestFormState extends State<ServiceRequestForm> {
  ServiceType? dropdownController = ServiceType.nonemergency;
  File? fileController;
  Future<void> takePhoto(ImageSource source) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: source,
      maxWidth: 150,
      maxHeight: 150,
      imageQuality: 75,
    );
    debugPrint('image in takePhoto -> $image');
    final xfileToFile = File(image!.path);
    debugPrint('xfileToFile: $xfileToFile');
    setState(() {
      fileController = xfileToFile;
    });
  }

  Widget getPreviewImage() {
    // if (previewPhoto != null) {
    //   return CircleAvatar(
    //     radius: 50,
    //     backgroundImage: Image.network(user.photo!).image,
    //   );
    // } else {
    //   return const CircleAvatar(
    //     radius: 50,
    //     backgroundImage: AssetImage(defaultProfilePic),
    //   );
    // }
    return const Text('No Preview Image Available');
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'lib/src/assets/images/podium_logo.png',
                height: 120,
              ),
              const SizedBox(height: 16),
              const Text('Service Type'),
              // DropdownButton(
              //   value: dropdownController,
              //   items: const [
              //     DropdownMenuItem(
              //       value: ServiceType.nonemergency,
              //       child: Text('Non-Emergency'),
              //     ),
              //     DropdownMenuItem(
              //       value: ServiceType.emergency,
              //       child: Text('Emergency'),
              //     )
              //   ],
              //   onChanged: (value) => {
              //     // setState(() {
              //     //   dropdownController = value;
              //     // }),
              //     // context.read<ServiceRequestCubit>().serviceTypeChanged(value)
              //   },
              // ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => SimpleDialog(
                      title: const Text('Select Service Type'),
                      children: [
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context, ServiceType.nonemergency);
                            context
                                .read<ServiceRequestCubit>()
                                .serviceTypeChanged(ServiceType.nonemergency);
                          },
                          child: const Text('Non-Emergency'),
                        ),
                        SimpleDialogOption(
                          onPressed: () {
                            Navigator.pop(context, ServiceType.emergency);
                            context
                                .read<ServiceRequestCubit>()
                                .serviceTypeChanged(ServiceType.emergency);
                          },
                          child: const Text('Emergency'),
                        ),
                      ],
                    ),
                  ).then((value) {
                    if (value != null && value is ServiceType) {
                      setState(() {
                        dropdownController = value;
                      });
                    }
                  });
                },
                child: const Text('Select Service Type'),
              ),
              if (dropdownController == ServiceType.emergency)
                const Text(
                  'IF THIS IS A SERIOUS EMERGENCY CALL 911',
                  style: TextStyle(color: Colors.red),
                ),
              const Padding(
                padding: EdgeInsets.all(12),
                child: TextField(
                  minLines: 4,
                  maxLines: 7,
                  decoration: InputDecoration(
                    hintText: 'Provide details of service needed.',
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 200,
                width: MediaQuery.of(context).size.width * .85,
                child: getPreviewImage(),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text('Provide Pictures'),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: ElevatedButton(
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 4, 0),
                        child: Icon(Icons.camera),
                      ),
                      Text('Take Picture')
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: ElevatedButton(
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 4, 0),
                        child: Icon(Icons.camera_roll),
                      ),
                      Text('Upload Picture')
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () => ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text('Service Request Submitted'),
                    ),
                  ),
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
