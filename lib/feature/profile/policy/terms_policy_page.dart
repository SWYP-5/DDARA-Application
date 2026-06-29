import 'package:ddara/core/designsystem/component/appbar/app_bar.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/router/route_path.dart';
import 'package:ddara/feature/profile/policy/policy_viewer_page.dart';
import 'package:ddara/feature/profile/widget/profile_section.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

/// 약관 및 정책 목록에서 보여줄 문서 1건.
const _policies = <PolicyViewerArgs>[
  PolicyViewerArgs(
    title: '서비스 이용 약관',
    assetPath: 'assets/policy/terms_of_service.md',
  ),
  PolicyViewerArgs(
    title: '개인정보 처리방침',
    assetPath: 'assets/policy/privacy_policy.md',
  ),
  PolicyViewerArgs(
    title: '운영정책(커뮤니티 가이드)',
    assetPath: 'assets/policy/community_guideline.md',
  ),
  PolicyViewerArgs(
    title: '청소년 보호정책',
    assetPath: 'assets/policy/youth_protection_policy.md',
  ),
];

/// 약관 및 정책 화면.
class TermsPolicyPage extends StatelessWidget {
  const TermsPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: AppBar(title: '약관 및 정책', onBack: () => context.pop()),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: AppSpacing.s3,
            left: AppSpacing.s4,
            right: AppSpacing.s4,
            bottom: AppSpacing.s6,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: AppSpacing.s5,
            children: [
              ProfileSection(
                label: '약관 및 정책',
                children: [
                  for (final policy in _policies)
                    ProfileRow(
                      label: policy.title,
                      trailing: const ProfileChevron(),
                      onTap: () => context.push(
                        RoutePath.policyViewer,
                        extra: policy,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
