import 'package:ddara/domain/provider/use_case_provider.dart';
import 'package:ddara/feature/group/join/util/group_join_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/exception/group_exception.dart';
import '../../../core/exception/group_join_error_code.dart';
import '../../../core/exception/login_exception.dart';

class GroupJoinNotifier extends Notifier<GroupJoinState> {
  @override
  GroupJoinState build() {
    return GroupJoinState();
  }

  void inviteCodeOnChanged(String inviteCode) {
    state = state.copyWith(inviteCode: inviteCode);
  }

  Future<void> joinGroup() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);
    final getInviteGroupUseCase = ref.read(getInviteGroupUseCaseProvider);

    try {
      final inviteGroup = await getInviteGroupUseCase.getInviteGroup(
        state.inviteCode,
      );

      state = state.copyWith(
        isLoading: false,
        groupId: inviteGroup.groupId,
        name: inviteGroup.name,
      );
    } on InvalidInviteCodeException {
      state = state.copyWith(
        isLoading: false,
        errorCode: GroupJoinErrorCode.invalidInviteCode,
      );
    } on GroupNotFoundException {
      state = state.copyWith(
        isLoading: false,
        errorCode: GroupJoinErrorCode.groupNotFound,
      );
    } on GroupFullException {
      state = state.copyWith(
        isLoading: false,
        errorCode: GroupJoinErrorCode.groupLimitExceeded,
      );
    } on AlreadyJoinedGroupException {
      state = state.copyWith(
        isLoading: false,
        errorCode: GroupJoinErrorCode.alreadyJoinedGroup,
      );
    } on NetworkException {
      state = state.copyWith(
        isLoading: false,
        errorCode: GroupJoinErrorCode.unknown,
      );
    }
  }
}
