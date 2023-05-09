// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:podium/src/app/app.dart';
import 'package:podium/src/resident_portal/update_profile/update_profile.dart';

class UpdateProfilePhotoForm extends StatefulWidget {
  const UpdateProfilePhotoForm({super.key});

  @override
  State<UpdateProfilePhotoForm> createState() => _UpdateProfilePhotoFormState();
}

class _UpdateProfilePhotoFormState extends State<UpdateProfilePhotoForm> {
  File? fileController;
  Future<void> takePhoto(ImageSource source) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: source,
      maxWidth: 150,
      maxHeight: 150,
      imageQuality: 75,
    );
    final xfileToFile = File(image!.path);
    setState(() {
      fileController = xfileToFile;
    });
  }

  CircleAvatar getNewProfilePic() {
    if (fileController != null && !kIsWeb ) {
      return CircleAvatar(
        radius: 50,
        backgroundImage: Image.file(fileController!).image,
      );
    } else {
      return const CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage('lib/src/assets/images/podium_logo.png'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('UpdateProfilePhotoForm LOADED');
    final user = context.select((AppBloc bloc) => bloc.state.user);
    // const defaultProfilePic = 'lib/src/assets/images/podium_logo.png';
    final changeUserPhoto = context.select((UpdateProfilePhotoCubit cubit) => cubit);
    CircleAvatar getProfilePic() {
      if (user.photo != null) {
        return CircleAvatar(
          radius: 50,
          backgroundImage: Image.network(user.photo!).image,
        );
      } else {
        return const CircleAvatar(
          radius: 50,
          // backgroundImage: AssetImage(defaultProfilePic),
        );
      }
    }

    getProfilePic();
    getNewProfilePic();
    return SizedBox(
      height: 300,
      width: 300,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Text('Current Photo:'),
                  getProfilePic(),
                ],
              ),
              Column(
                children: [
                  const Text('New Photo:'),
                  getNewProfilePic(),
                ],
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              takePhoto(ImageSource.camera);
            },
            child: Row(
              children: const [Icon(Icons.camera), Text('Camera')],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              takePhoto(ImageSource.gallery);
            },
            child:  Row(
              children: const [Icon(Icons.camera_roll), Text('Gallery')],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              changeUserPhoto.updateWithNewPicture(fileController);
              Navigator.pop(context);
            },
            child: Row(
              children: const [Icon(Icons.save), Text('Save Picture')],
            ),
          ),
        ],
      ),
    );
  }
}
