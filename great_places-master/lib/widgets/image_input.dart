//@dart = 2.9
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sysPath;

class ImageInput extends StatefulWidget {
  final Function selectImage;

  ImageInput(this.selectImage);

  /*flutter run --no-sound-null-safety*/
  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storeImage;

  Future<void> takenPic() async {
    final imageFile =
        await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storeImage = File(imageFile.path);
    });
    final appDir = await sysPath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');
    widget.selectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 160,
          height: 100,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _storeImage != null
              ? Image.file(
                  _storeImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  "No Image Taken",
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center,
        ),
        SizedBox(
          width: 10,
        ),
        ElevatedButton.icon(
            onPressed: takenPic,
            icon: Icon(Icons.camera),
            label: Text("Take Picture"))
      ],
    );
  }
}
