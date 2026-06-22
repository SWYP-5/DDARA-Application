enum PermissionResult { granted, denied, permanentlyDenied }

abstract interface class PermissionService {
  Future<bool> isCameraGranted();

  /// 카메라 권한이 영구 거부(또는 restricted) 상태인지.
  /// true 면 `requestCamera()` 를 호출해도 OS 권한 프롬프트가 더 이상 뜨지 않는다.
  Future<bool> isCameraPermanentlyDenied();

  Future<PermissionResult> requestCamera();

  Future<bool> isNotificationGranted();

  Future<PermissionResult> requestNotification();

  Future<bool> isPhotosGranted();

  Future<PermissionResult> requestPhotos();

  Future<bool> openSettings();
}
