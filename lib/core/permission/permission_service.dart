enum PermissionResult { granted, denied, permanentlyDenied }

abstract interface class PermissionService {
  Future<bool> isCameraGranted();

  Future<PermissionResult> requestCamera();

  Future<bool> isNotificationGranted();

  Future<PermissionResult> requestNotification();

  Future<bool> isPhotosGranted();

  Future<PermissionResult> requestPhotos();

  Future<bool> openSettings();
}
