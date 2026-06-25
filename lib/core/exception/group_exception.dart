sealed class GroupException implements Exception {}

/// 400 — 모임 이름 누락 또는 길이 초과.
class InvalidGroupNameException extends GroupException {}

/// 409 — 모임 최대 개수(20개) 초과.
class GroupLimitExceededException extends GroupException {}
