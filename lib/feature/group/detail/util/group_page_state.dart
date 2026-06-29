import 'package:ddara/core/model/group/group_detail.dart';

class GroupPageState {
  final GroupDetail? groupDetail;
  final bool isLoading;
  final String errorMessage;

  const GroupPageState({
    this.groupDetail,
    this.isLoading = false,
    this.errorMessage = '',
  });

  GroupPageState copyWith({
    GroupDetail? groupDetail,
    bool? isLoading,
    String? errorMessage,
  }) {
    return GroupPageState(
      groupDetail: groupDetail ?? this.groupDetail,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
