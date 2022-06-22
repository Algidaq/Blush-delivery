abstract class IPermissionHandlerService {
  Future<bool> getStroagePermissionStatus();
  Future<bool> requestStoragePermissionStatus();
  Future<bool> getCameraPermissionStatus();
  Future<bool> requestCameraPermissionStatus();
}
