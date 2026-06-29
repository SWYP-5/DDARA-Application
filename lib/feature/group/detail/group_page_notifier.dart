import 'package:ddara/core/exception/group_exception.dart';
import 'package:ddara/domain/provider/use_case_provider.dart';
import 'package:ddara/feature/group/detail/util/group_page_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GroupPageNotifier extends AutoDisposeFamilyNotifier<GroupPageState, int> {
  @override
  GroupPageState build(int groupId) {
    // GroupPage 가 넘긴 groupId 로 진입 시 자동 조회. (build 는 동기라 fire-and-forget)
    _load(groupId);

    return const GroupPageState(isLoading: true);
  }

  Future<void> _load(int groupId) async {
    final getGroupDetailUseCase = ref.read(getGroupDetailUseCaseProvider);

    try {
      final groupDetail = await getGroupDetailUseCase.getGroupDetail(groupId);
      state = state.copyWith(isLoading: false, groupDetail: groupDetail);
    } on NotGroupMemberException {
      state = state.copyWith(
        isLoading: false,
        errorMessage: '해당 모임의 멤버가 아니에요.',
      );
    } on GroupNotFoundException {
      state = state.copyWith(
        isLoading: false,
        errorMessage: '존재하지 않는 모임이에요.',
      );
    } catch (_) {
      // NetworkException 및 기타 예기치 못한 오류.
      state = state.copyWith(
        isLoading: false,
        errorMessage: '모임 정보를 불러오지 못했어요.',
      );
    }
  }
}
