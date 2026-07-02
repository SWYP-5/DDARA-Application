class CyclePhotoGalleryState {
  /// 모임 이름. 조회 전엔 빈 문자열.
  final String groupName;

  /// 모임 정보 조회 중 여부.
  final bool isLoading;

  /// 조회 실패 메시지. 비어 있으면 에러 없음.
  final String errorMessage;

  const CyclePhotoGalleryState({
    this.groupName = '',
    this.isLoading = false,
    this.errorMessage = '',
  });

  CyclePhotoGalleryState copyWith({
    String? groupName,
    bool? isLoading,
    String? errorMessage,
  }) {
    return CyclePhotoGalleryState(
      groupName: groupName ?? this.groupName,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
