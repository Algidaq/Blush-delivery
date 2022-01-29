abstract class IPermissionHandlerService {
  Future<bool> getStroagePermissionStatus();
  Future<bool> requestStoragePermissionStatus();
}
