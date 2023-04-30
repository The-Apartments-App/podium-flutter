import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:podium/src/resident_portal/update_profile/update_profile.dart';

class UploadPicture extends StatefulWidget {
  const UploadPicture({super.key});

  @override
  UploadPictureState createState() => UploadPictureState();
}

class UploadPictureState extends State<UploadPicture> {
  XFile? image;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future<void> getImage(ImageSource media) async {
    final img = await picker.pickImage(source: media);
    setState(() {
      image = img;
      if (img != null) {
        context.read<UpdateProfileCubit>();
      }
    });
  }

  //show popup dialog
  void myAlert() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          title: const Text('Please choose media to select'),
          content: SizedBox(
            height: MediaQuery.of(context).size.height / 6,
            child: Column(
              children: [
                ElevatedButton(
                  //if you click this button, user can upload image from gallery
                  onPressed: () {
                    Navigator.pop(context);
                    final photo = getImage(ImageSource.gallery);
                    debugPrint('photo from gallery is -> $photo');
                    // context.read<UpdateProfileCubit>()
                    // .profilePictureChanged(photo);
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.image),
                      Text('From Gallery'),
                    ],
                  ),
                ),
                ElevatedButton(
                  //if user click this button. user can upload image from camera
                  onPressed: () {
                    Navigator.pop(context);
                    final photo = getImage(ImageSource.camera);
                    debugPrint('photo from camera is -> $photo');
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.camera),
                      Text('From Camera'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: myAlert,
            child: const Text('Upload Photo'),
          ),
          const SizedBox(
            height: 10,
          ),
          //if image not null show the image
          //if image null show text
          if (image != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  //to show image, you type like this.
                  image!.path,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                ),
              ),
            )
          else
            const Text(
              'No Image',
              style: TextStyle(fontSize: 20),
            )
        ],
      ),
    );
  }
}
