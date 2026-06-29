class CreateGroupState {
  final String groupName;
  final String description;
  final String nickname;

  /// 닉네임 중복 여부. (서버 중복 체크 결과 — 추후 연동)
  final bool isNicknameDuplicate;
  final bool isLoading;
  final int createGroupId;
  final String errorMessage;

  const CreateGroupState({
    this.groupName = '',
    this.description = '',
    this.nickname = '',
    this.isNicknameDuplicate = false,
    this.isLoading = false,
    this.createGroupId = -1,
    this.errorMessage = '',
  });

  CreateGroupState copyWith({
    String? groupName,
    String? description,
    String? nickname,
    bool? isNicknameDuplicate,
    bool? isLoading,
    int? createGroupId,
    String? errorMessage,
  }) {
    return CreateGroupState(
      groupName: groupName ?? this.groupName,
      description: description ?? this.description,
      nickname: nickname ?? this.nickname,
      isNicknameDuplicate: isNicknameDuplicate ?? this.isNicknameDuplicate,
      isLoading: isLoading ?? this.isLoading,
      createGroupId: createGroupId ?? this.createGroupId,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
