import 'package:ddara/core/exception/group_join_error_code.dart';

class GroupJoinState {
  final String inviteCode;
  final bool isLoading;
  final int groupId;
  final String name;
  final GroupJoinErrorCode? errorCode;

  const GroupJoinState({
    this.inviteCode = '',
    this.isLoading = false,
    this.groupId = -1,
    this.name = '',
    this.errorCode,
  });

  GroupJoinState copyWith({
    String? inviteCode,
    bool? isLoading,
    int? groupId,
    String? name,
    GroupJoinErrorCode? errorCode,
  }) {
    return GroupJoinState(
      inviteCode: inviteCode ?? this.inviteCode,
      isLoading: isLoading ?? this.isLoading,
      groupId: groupId ?? this.groupId,
      name: name ?? this.name,
      errorCode: errorCode ?? this.errorCode,
    );
  }
}
