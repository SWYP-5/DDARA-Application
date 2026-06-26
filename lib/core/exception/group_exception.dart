sealed class GroupException implements Exception {}

/// 400 — 모임 이름 누락 또는 길이 초과.
class InvalidGroupNameException extends GroupException {}

/// 409 — 모임 최대 개수(20개) 초과.
class GroupLimitExceededException extends GroupException {}

/// 403 — 해당 모임의 멤버가 아님.
class NotGroupMemberException extends GroupException {}

/// 404 — 모임 없음.
class GroupNotFoundException extends GroupException {}

/// 400 — 초대 코드 누락.
class InvalidInviteCodeException extends GroupException {}

/// 409 — 모임 정원 초과.
class GroupFullException extends GroupException {}

/// 409 — 이미 참여 중인 모임.
class AlreadyJoinedGroupException extends GroupException {}
