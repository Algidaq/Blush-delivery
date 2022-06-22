import 'package:blush_delivery/interfaces/i_permission_handler_service.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerService implements IPermissionHandlerService {
  @override
  Future<bool> getStroagePermissionStatus() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      var value = await requestStoragePermissionStatus();
      return value;
    } else {
      return true;
    }
  }

  @override
  Future<bool> requestStoragePermissionStatus() async {
    var status = await Permission.storage.request();
    return status.isGranted;
  }

  @override
  Future<bool> getCameraPermissionStatus() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      var value = await requestStoragePermissionStatus();
      return value;
    } else {
      return true;
    }
  }

  @override
  Future<bool> requestCameraPermissionStatus() async {
    var status = await Permission.camera.request();
    return status.isGranted;
  }
}
