enum SocialLoginType {
  google('GOOGLE'),
  kakao('KAKAO');

  const SocialLoginType(this.value);

  final String value;

  /// 저장된 문자열(`GOOGLE`/`KAKAO`)을 enum 으로 역매핑. 매칭 실패 시 null.
  static SocialLoginType? fromValue(String? value) {
    for (final type in SocialLoginType.values) {
      if (type.value == value) return type;
    }
    return null;
  }
}
