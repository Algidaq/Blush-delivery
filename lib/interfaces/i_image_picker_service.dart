import 'package:image_picker/image_picker.dart';

abstract class IImagePickerService {
  Future<XFile?> getImageFromGallery();
  Future<XFile?> getImageFromCamera();
}
