import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class Picture extends StatefulWidget {
  const Picture({super.key, required this.onImageChange});
  final Function(File?) onImageChange;

  @override
  State<Picture> createState() => _PictureState();
}

class _PictureState extends State<Picture> {
  File? image;
  Future pickImage() async {
    try {
      final XFile? imageFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imageFile == null) return;

      final imageTemp = File(imageFile.path);

      setState(() => image = imageTemp);
      print(image);
      widget.onImageChange(image);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Add a profile picture"),
        Flexible(
          flex: 3,
          child: Padding(
              //flex 2
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(4), // Border width
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary,
                    shape: BoxShape.circle),
                child: ClipOval(
                    child: SizedBox.fromSize(
                  size: const Size.fromRadius(60), // Image radius
                  child: getImageWidget(image),
                )),
              )),
        ),
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: pickImage, child: const Text('Pick an Image')),
          ),
        ),
        const Spacer(
          flex: 2,
        )
      ],
    );
  }

  Widget getImageWidget(File? imageFile) {
    if (imageFile != null) {
      if (kIsWeb) {
        // Web platform: Use Image.network
        return Image.network(
          imageFile.path,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        );
      } else {
        // Mobile platform: Use Image.file
        return Image.file(
          imageFile,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        );
      }
    } else {
      // Show a placeholder image or some default content if no image is selected
      return SvgPicture.asset('assets/images/profile_image.svg');
    }
  }
}
