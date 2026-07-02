import 'package:ddara/feature/group/gallery/util/cycle_photo_gallery_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CyclePhotoGalleryNotifier
    extends AutoDisposeFamilyNotifier<CyclePhotoGalleryState, int> {
  @override
  CyclePhotoGalleryState build(int cycleId) {
    // 진입 시 cycleId 로 모임 이름을 조회한다. (build 는 동기라 fire-and-forget)
    _loadGroupName(cycleId);

    return const CyclePhotoGalleryState(isLoading: true);
  }

  /// 사이클 정보를 조회해 이름만 state 에 담는다.
  /// (멤버별 사이클 사진은 별도 API 로 로드하므로 여기서는 이름만 다룬다)
  Future<void> _loadGroupName(int cycleId) async {

  }
}
