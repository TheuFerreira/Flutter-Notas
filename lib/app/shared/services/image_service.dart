import 'dart:io';
import 'dart:typed_data';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {
  final _picker = ImagePicker();

  Future<File?> _cropImage(String path) async {
    File? newImage = await ImageCropper.cropImage(
      sourcePath: path,
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: 'Editar Imagem',
      ),
    );
    return newImage;
  }

  Future<Uint8List?> getImage() async {
    XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    if (file == null) return null;

    File? imageUpdated = await _cropImage(file.path);
    if (imageUpdated == null) return null;

    Uint8List buffer = await imageUpdated.readAsBytes();
    return buffer;
  }
}
