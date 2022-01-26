import 'package:blush_delivery/interfaces/i_image_picker_service.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService implements IImagePickerService {
  @override
  Future<XFile?> getImageFromCamera() async {
    return await ImagePicker().pickImage(source: ImageSource.camera);
  }

  @override
  Future<XFile?> getImageFromGallery() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }
}
