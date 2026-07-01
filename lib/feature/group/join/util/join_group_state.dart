class JoinGroupState {
  /// 모임에서 사용할 닉네임 입력값.
  final String nickname;

  final bool isLoading;

  /// 참여 완료된 모임 id. (참여 전·실패 시 -1)
  final int joinedGroupId;

  /// 에러 메시지. (없으면 빈 문자열)
  final String errorMessage;

  const JoinGroupState({
    this.nickname = '',
    this.isLoading = false,
    this.joinedGroupId = -1,
    this.errorMessage = '',
  });

  JoinGroupState copyWith({
    String? nickname,
    bool? isLoading,
    int? joinedGroupId,
    String? errorMessage,
  }) {
    return JoinGroupState(
      nickname: nickname ?? this.nickname,
      isLoading: isLoading ?? this.isLoading,
      joinedGroupId: joinedGroupId ?? this.joinedGroupId,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
