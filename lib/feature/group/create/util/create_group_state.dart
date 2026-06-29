class CreateGroupState {
  final String groupName;
  final String description;
  final bool isLoading;
  final int createGroupId;
  final String errorMessage;

  const CreateGroupState({
    this.groupName = '',
    this.description = '',
    this.isLoading = false,
    this.createGroupId = -1,
    this.errorMessage = '',
  });

  CreateGroupState copyWith({
    String? groupName,
    String? description,
    bool? isLoading,
    int? createGroupId,
    String? errorMessage,
  }) {
    return CreateGroupState(
      groupName: groupName ?? this.groupName,
      description: description ?? this.description,
      isLoading: isLoading ?? this.isLoading,
      createGroupId: createGroupId ?? this.createGroupId,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
