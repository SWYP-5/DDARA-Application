import 'package:ddara/core/designsystem/component/appbar/app_bar.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/router/route_path.dart';
import 'package:ddara/feature/group/detail/widget/header/started_header.dart';
import 'package:ddara/feature/group/widget/member_photo_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../../core/designsystem/component/text/app_text.dart';

/// 스타터(따라찍기 시작) 화면. (헤더만 잡아둔 상태 — 아래 본문은 추후 구현)
class StartedPage extends StatelessWidget {
  const StartedPage({super.key});

  // TODO: 모임 조회 API 응답의 모임 이름으로 대체. (현재 백엔드 스펙 대기 — 임시 더미)
  static const _dummyGroupName = '마라탕 걸즈';

  // TODO: 멤버 목록은 모임 조회 API 응답으로 대체. (백엔드 스펙 대기 — 임시 더미)
  static const _dummyMembers = ['지원', '도윤', '민주', '보현'];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: AppBar(
        title: _dummyGroupName,
        onBack: () => context.pop(),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          // 끝에서 더 당겨지는 바운스(overscroll)를 막고 가장자리에서 멈춘다.
          physics: const ClampingScrollPhysics(),
          // 상하 s6, 좌우 s5 여백.
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.s5,
            vertical: AppSpacing.s6,
          ),
          child: Column(
            // 상단부터 쌓되 가로는 중앙 정렬.
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: AppSpacing.s4,
            children: [
              StartedHeader(
                imageUri: "",
                // TODO: 모임 조회 API 응답으로 대체. (백엔드 스펙 대기 — 임시 더미)
                progress: (
                  round: 3,
                  topic: '마라탕 맛있게 먹기',
                  starterName: '도윤',
                  remainingTime: '14시간',
                ),
              ),
              // TODO: 헤더 아래 본문 구현 예정.
              const SizedBox(height: AppSpacing.s6),
              const AppText.headlineLarge(_dummyGroupName),
              const SizedBox(height: AppSpacing.s4),
              // 멤버 사진 카드 2칸 그리드. (카드 높이는 225 고정)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: AppSpacing.s3,
                      mainAxisSpacing: AppSpacing.s3,
                      mainAxisExtent: 225,
                    ),
                itemCount: _dummyMembers.length,
                itemBuilder: (context, index) {
                  // TODO: 실제 본인 여부/업로드 상태로 판별. (현재 더미)
                  // 첫 카드를 본인으로 보고, 본인이 아직 업로드하지 않았다고 가정한다.
                  final isMe = index == 0;
                  const myUploaded = false;
                  return MemberPhotoCard(
                    name: _dummyMembers[index],
                    // 본인은 미업로드(null), 타인은 사진이 있다고 가정. (더미 에셋)
                    image: isMe
                        ? null
                        : const AssetImage('assets/images/temp_image.jpg'),
                    onTakePhoto: isMe
                        ? () => context.push(RoutePath.startedCamera)
                        : null,
                    // 본인이 아직 업로드 안 했으면 타인 사진은 잠근다.
                    isLocked: !isMe && !myUploaded,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
