import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker_web/image_picker_web.dart';

class Picture extends StatefulWidget {
  const Picture({super.key});

  @override
  State<Picture> createState() => _PictureState();
}

class _PictureState extends State<Picture> {
  Uint8List? image;
  Future pickImage() async {
    try {
      final image = await ImagePickerWeb.getImageAsBytes();
      if (image == null) return;
      setState(() => this.image = image);
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
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8), // Border width
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  shape: BoxShape.circle),
              child: ClipOval(
                  child: SizedBox.fromSize(
                size: const Size.fromRadius(48), // Image radius
                child: image != null
                    ? Image.memory(
                        image!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      )
                    : SvgPicture.asset(
                        'assets/images/profile_image.svg',
                        width: 70,
                        height: 70,
                      ),
              )),
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                pickImage();
              },
              child: const Text('Pick an Image')),
        ),
      ],
    );
  }
}
