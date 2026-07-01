import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'util/join_group_state.dart';

class JoinGroupNotifier extends AutoDisposeNotifier<JoinGroupState> {
  @override
  JoinGroupState build() {
    return const JoinGroupState();
  }

  void nicknameOnChanged(String nickname) {
    state = state.copyWith(nickname: nickname);
  }

  /// 초대 코드와 [state.nickname] 으로 실제 모임 참여를 요청한다.
  Future<void> joinGroup(String inviteCode) async {
    if (state.isLoading) return;
    
    // TODO: 실제 모임 참여 API 연결. 연동 시 아래 흐름으로 채운다.
    //   state = state.copyWith(isLoading: true);
    //   final joinGroupUseCase = ref.read(joinGroupUseCaseProvider);
    //   try {
    //     final joined = await joinGroupUseCase(inviteCode, state.nickname);
    //     state = state.copyWith(isLoading: false, joinedGroupId: joined.groupId);
    //   } on AlreadyJoinedGroupException {
    //     state = state.copyWith(isLoading: false, errorMessage: '이미 참여 중인 모임이에요');
    //   } on GroupFullException {
    //     state = state.copyWith(isLoading: false, errorMessage: '이미 꽉 찬 모임이에요.');
    //   } on NetworkException {
    //     state = state.copyWith(isLoading: false, errorMessage: '네트워크 연결이 불안정합니다.');
    //   }
  }
}
