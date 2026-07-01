import 'package:ddara/core/designsystem/component/appbar/app_bar.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/router/route_path.dart';
import 'package:ddara/core/widget/app_dialog.dart';
import 'package:ddara/feature/profile/provider/notifier_provider.dart';
import 'package:ddara/feature/profile/util/profile_state.dart';
import 'package:ddara/feature/profile/widget/profile_header.dart';
import 'package:ddara/feature/profile/widget/profile_section.dart';
import 'package:ddara/core/widget/toast/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

/// 프로필 화면.
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileNotifierProvider);

    // 로그아웃 결과에 따라 분기: 성공 시 로그인 화면으로 이동, 실패 시 안내.
    ref.listen(profileNotifierProvider.select((s) => s.logoutStatus), (
      _,
      status,
    ) {
      if (!context.mounted) return;
      switch (status) {
        case LogoutStatus.success:
          context.go(RoutePath.login);
        case LogoutStatus.fail:
          Toast.showToast(context, '로그아웃에 실패했어요.', type: ToastType.error);
        case LogoutStatus.idle:
        case LogoutStatus.loading:
          break;
      }
    });

    return CupertinoPageScaffold(
      navigationBar: AppBar(title: '프로필', onBack: () => context.pop()),
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
              ProfileHeader(name: state.name),
              ProfileSection(
                label: '기본 정보',
                children: [
                  ProfileRow(label: '가입일', value: _formatDate(state.joinedAt)),
                ],
              ),
              ProfileSection(
                label: '알림',
                children: [
                  ProfileRow(
                    label: '알림 설정',
                    trailing: const ProfileChevron(),
                    onTap: () => context.push(RoutePath.notificationSettings),
                  ),
                ],
              ),
              ProfileSection(
                label: '지원',
                children: [
                  ProfileRow(
                    label: '약관 및 정책',
                    trailing: const ProfileChevron(),
                    onTap: () => context.push(RoutePath.termsPolicy),
                  ),
                  ProfileRow(
                    label: '문의하기',
                    trailing: const ProfileChevron(),
                    onTap: () => _contact(context, state.appVersion),
                  ),
                  ProfileRow(label: '앱 버전', value: state.appVersion),
                ],
              ),
              ProfileSection(
                label: '계정',
                children: [
                  ProfileRow(label: '연동 계정', value: state.linkedAccount),
                  ProfileRow(
                    label: '로그아웃',
                    labelColor: AppColors.statusDanger,
                    onTap: () => _confirmLogout(context, ref),
                  ),
                  ProfileRow(
                    label: '회원 탈퇴',
                    // TODO: 회원 탈퇴 처리. (현재는 미구현 안내 토스트)
                    onTap: () => Toast.showToast(
                      context,
                      '아직 구현되지 않았습니다.',
                      type: ToastType.error,
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

  /// 문의 메일 수신 주소.
  static const String _contactEmail = 'ddara.team3@gmail.com';

  /// 기본 메일 앱으로 문의 메일 작성 화면을 띄운다. (제목·본문 미리 채움)
  Future<void> _contact(BuildContext context, String appVersion) async {
    // mailto 쿼리는 공백을 '+' 가 아닌 '%20' 으로 인코딩해야 메일 앱이 제대로 읽는다.
    final query =
        <String, String>{
              'subject': '[따라] 문의하기',
              'body':
                  '문의 내용을 작성해 주세요.\n\n------------------\n앱 버전: $appVersion\n------------------',
            }.entries
            .map(
              (e) =>
                  '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
            )
            .join('&');

    final mailUri = Uri(scheme: 'mailto', path: _contactEmail, query: query);

    // 메일 앱이 없거나 실행에 실패하면 사용자에게 안내한다.
    final launched = await launchUrl(mailUri).catchError((_) => false);
    if (!launched && context.mounted) {
      Toast.showToast(
        context,
        '메일 앱을 열 수 없어요. ($_contactEmail)',
        type: ToastType.error,
      );
    }
  }

  /// DateTime → 'yyyy.MM.dd'. (없으면 빈 문자열)
  String _formatDate(DateTime? date) {
    if (date == null) return '';
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}.$month.$day';
  }

  /// 로그아웃 확인 다이얼로그를 띄우고, 확인 시에만 로그아웃을 진행한다.
  Future<void> _confirmLogout(BuildContext context, WidgetRef ref) async {
    final ok = await AppDialog.show(
      context,
      title: '로그아웃 할까요?',
      confirmLabel: '로그아웃',
    );
    if (ok) await ref.read(profileNotifierProvider.notifier).logout();
  }
}
