/// 프로필 조회(`GET /api/users/me`) 실패 시 서버가 내려주는 에러 코드.
enum ProfileErrorCode {
  userNotFound('USER_NOT_FOUND', '사용자를 찾을 수 없어요.'),

  /// 네트워크 오류 등 매칭되는 서버 코드가 없을 때의 기본값.
  unknown('UNKNOWN', '네트워크 연결이 불안정합니다.');

  const ProfileErrorCode(this.value, this.message);

  final String value;

  /// 사용자에게 노출할 안내 메시지.
  final String message;

  /// 서버 응답의 code 문자열을 enum 으로 역매핑. 매칭 실패 시 null.
  static ProfileErrorCode? fromValue(String? value) {
    for (final code in ProfileErrorCode.values) {
      if (code.value == value) return code;
    }
    return null;
  }
}