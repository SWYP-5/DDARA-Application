import 'package:ddara/core/designsystem/component/button/app_button.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/feature/group/detail/widget/header/empty_header.dart';
import 'package:ddara/feature/group/detail/widget/header/started_header.dart';
import 'package:flutter/cupertino.dart';

/// 모임 상세 화면 상단 헤더.
///
/// [imageUri] 가 없으면(따라찍기 전) [EmptyHeader] 를, 있으면 해당 이미지를 보여준다.
class GroupHeader extends StatelessWidget {
  const GroupHeader({
    super.key,
    this.imageUri,
    required this.progress,
    required this.navigateToStart,
    required this.onTakePhoto,
  });

  /// 대표로 보여줄 이미지 URI. null/빈 값이면 빈 상태로 본다.
  final String? imageUri;

  /// 시작된 상태에서 보여줄 따라찍기 진행 정보.
  final DdaraProgress progress;

  /// 빈 상태에서 '스타터 시작하기' 버튼을 눌렀을 때 실행할 콜백.
  final VoidCallback navigateToStart;

  /// 시작된 상태에서 '촬영하러 가기' 버튼을 눌렀을 때 실행할 콜백.
  final VoidCallback onTakePhoto;

  @override
  Widget build(BuildContext context) {
    // // 이미지가 없으면 빈 상태 헤더 + 시작 버튼.
    if (imageUri == null || imageUri!.isEmpty) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const EmptyHeader(),
          const SizedBox(height: AppSpacing.s5),
          AppButton(label: '내가 먼저 시작하기', onPressed: navigateToStart),
        ],
      );
    }

    // 따라찍기가 시작된 상태의 헤더 + 촬영 버튼.
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        StartedHeader(imageUri: "", progress: progress),
        const SizedBox(height: AppSpacing.s5),
        AppButton(label: '따라찍으러 가기', onPressed: onTakePhoto),
      ],
    );
  }
}
