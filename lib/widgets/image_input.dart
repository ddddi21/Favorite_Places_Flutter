// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path_provider/path_provider.dart';

class ImageInput extends StatefulWidget {
  final Function onSelectImage;

  ImageInput(this.onSelectImage);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;
  Uint8List _webImage = Uint8List(10);

  Future<void> takePicture() async {
    if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          _storedImage = File("a");
          _webImage = f;
        });
      }
      final tempDir = await getTemporaryDirectory();
      File file = await File('${tempDir.path}/image.png').create();
      file.writeAsBytesSync(_webImage);
      widget.onSelectImage(file);
    } else {
      var picture = ImagePicker();
      final imageFile = await picture.pickImage(
        source: ImageSource.camera,
        maxHeight: 600,
      );
      if (imageFile == null) {
        return;
      }

      //imageFile is of type XFile, but _storedImage is of type File
      //so .path converts it into type File.
      setState(() {
        _storedImage = File(imageFile.path);
      });

      /*  */
      final appDirectory = await syspaths.getApplicationDocumentsDirectory();
      final fileName = path.basename(imageFile.path);
      final savedImage =
      await _storedImage.copy('${appDirectory.path}/$fileName');
      widget.onSelectImage(savedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return buildForWeb(context);
    } else {
      return buildForMobile(context);
    }
  }

  Widget buildForMobile(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 175,
          height: 175,
          decoration: BoxDecoration(
            border: Border.all(width: 1.5, color: Colors.grey),
          ),
          child: _storedImage == null
              ? Center(
                  child: Text(
                    'No image captured!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 19,
                    ),
                  ),
                )
              : Image.file(
                  _storedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
            icon: Icon(Icons.camera),
            label: Text(
              'Capture Image',
              textAlign: TextAlign.center,
            ),
            style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                    TextStyle(color: Theme.of(context).primaryColor))),
            onPressed: takePicture,
          ),
        ),
      ],
    );
  }

  Widget buildForWeb(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 175,
          height: 175,
          decoration: BoxDecoration(
            border: Border.all(width: 1.5, color: Colors.grey),
          ),
          child: _storedImage == null
              ? Center(
                  child: Text(
                    'No image captured!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 19,
                    ),
                  ),
                )
              : Image.memory(
                  _webImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
            icon: Icon(Icons.camera),
            label: Text(
              'Capture Image',
              textAlign: TextAlign.center,
            ),
            style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                    TextStyle(color: Theme.of(context).primaryColor))),
            onPressed: takePicture,
          ),
        ),
      ],
    );
  }
}
