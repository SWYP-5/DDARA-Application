import 'package:ddara/core/exception/group_exception.dart';
import 'package:ddara/domain/provider/use_case_provider.dart';
import 'package:ddara/feature/group/gallery/util/cycle_photo_gallery_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CyclePhotoGalleryNotifier
    extends AutoDisposeFamilyNotifier<CyclePhotoGalleryState, int> {
  @override
  CyclePhotoGalleryState build(int groupId) {
    // 진입 시 groupId 로 모임 이름을 조회한다. (build 는 동기라 fire-and-forget)
    _loadGroupName(groupId);

    return const CyclePhotoGalleryState(isLoading: true);
  }

  /// 모임 상세를 조회해 이름만 state 에 담는다.
  /// (멤버별 사이클 사진은 별도 API 로 로드하므로 여기서는 이름만 다룬다)
  Future<void> _loadGroupName(int groupId) async {
    final getGroupDetailUseCase = ref.read(getGroupDetailUseCaseProvider);

    try {
      final detail = await getGroupDetailUseCase.getGroupDetail(groupId);
      state = state.copyWith(isLoading: false, groupName: detail.name);
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
