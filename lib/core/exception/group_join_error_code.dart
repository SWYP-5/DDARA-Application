/// 모임 참여(`POST /groups/join`) 실패 시 서버가 내려주는 에러 코드.
enum GroupJoinErrorCode {
  invalidInviteCode('INVALID_INVITE_CODE', '초대 코드를 입력해주세요.'),
  groupNotFound('GROUP_NOT_FOUND', '존재하지 않는 초대 코드입니다.'),
  groupLimitExceeded('GROUP_LIMIT_EXCEEDED', '모임 정원이 가득 찼습니다.'),
  alreadyJoinedGroup('ALREADY_JOINED_GROUP', '이미 참여 중인 모임입니다.'),

  /// 네트워크 오류 등 매칭되는 서버 코드가 없을 때의 기본값.
  unknown('UNKNOWN', '네트워크 연결이 불안정합니다.');

  const GroupJoinErrorCode(this.value, this.message);

  final String value;

  /// 사용자에게 노출할 안내 메시지.
  final String message;

  /// 서버 응답의 code 문자열을 enum 으로 역매핑. 매칭 실패 시 null.
  static GroupJoinErrorCode? fromValue(String? value) {
    for (final code in GroupJoinErrorCode.values) {
      if (code.value == value) return code;
    }
    return null;
  }
}
