import 'package:ddara/core/designsystem/component/appbar/app_bar.dart';
import 'package:ddara/core/model/group/group_detail.dart';
import 'package:ddara/core/router/route_path.dart';
import 'package:ddara/feature/group/widget/cycle_photo_gallery.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

/// 스타터(따라찍기 시작) 화면. (헤더만 잡아둔 상태 — 아래 본문은 추후 구현)
class StartedPage extends StatelessWidget {
  const StartedPage({super.key, required this.groupId, required this.cycleId});

  final int groupId;
  final int cycleId;

  // TODO: 모임 조회 API 응답의 모임 이름으로 대체. (현재 백엔드 스펙 대기 — 임시 더미)
  static const _dummyGroupName = '마라탕 걸즈';

  // TODO: 멤버 목록은 모임 조회 API 응답으로 대체. (백엔드 스펙 대기 — 임시 더미)
  static const _dummyMembers = ['지원', '도윤', '민주', '보현'];

  static final _dummyGroupCycle = GroupCycle(
    cycleId: 0,
    cycleNumber: 3,
    topic: '마라탕 맛있게 먹기',
    starterUserId: 0,
    status: 'in_progress',
    startedAt: DateTime.now(),
    deadlineAt: DateTime.now().add(const Duration(hours: 14)),
    starterNickname: '지원',
    starterImageUrl: '',
  );

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: AppBar(
        title: _dummyGroupName,
        onBack: () => context.pop(),
      ),
      child: SafeArea(
        child: CyclePhotoGallery(
          groupName: _dummyGroupName,
          headerImageUri: '',
          // TODO: 모임 조회 API 응답으로 대체. (백엔드 스펙 대기 — 임시 더미)
          progress: _dummyGroupCycle,
          // TODO: 실제 멤버/업로드 상태로 대체. (현재 더미)
          // 첫 카드를 본인으로 보고, 본인이 아직 업로드하지 않았다고 가정한다.
          members: [
            for (var i = 0; i < _dummyMembers.length; i++)
              (
                name: _dummyMembers[i],
                // TODO: 실제 업로드 사진으로 대체. (현재 데이터 없어 모두 미업로드)
                image: null,
                isMe: i == 0,
                // 본인이 아직 업로드 안 했으면 타인 사진은 잠근다.
                isLocked: i != 0,
              ),
          ],
          // 가이드로 스타터 사진 URL 을 넘긴다.
          // TODO: 실데이터 연결 시 실제 스타터 이미지 URL 로 교체. (현재 더미 — 빈 URL)
          onTakePhoto: () => context.push(
            RoutePath.startedCamera,
            extra: _dummyGroupCycle.starterImageUrl,
          ),
        ),
      ),
    );
  }
}
