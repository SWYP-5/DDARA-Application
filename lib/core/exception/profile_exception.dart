sealed class ProfileException implements Exception {}

/// 404 — 사용자를 찾을 수 없음.
class UserNotFoundException extends ProfileException {}