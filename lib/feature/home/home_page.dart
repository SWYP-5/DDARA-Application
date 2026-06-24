import 'package:ddara/core/designsystem/component/appbar/app_bar.dart';
import 'package:ddara/core/designsystem/component/logo.dart';
import 'package:ddara/feature/home/empty_group_page.dart';
import 'package:ddara/feature/home/group_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // TODO: 그룹 조회 API 연동 후 실제 모임 유무로 분기. (현재는 임시 토글)
  /// 모임 목록 화면 표시 여부. (false: EmptyGroupPage / true: GroupListPage)
  bool _showGroupList = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: AppBar(
        // 좌측 로고를 직접 배치하므로 뒤로가기 버튼 비활성화.
        showBackButton: false,
        padding: const EdgeInsetsDirectional.only(start: 20, end: 12),
        leading: const Align(alignment: Alignment.centerLeft, child: Logo()),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _NavIconButton(
              icon: SvgPicture.asset(
                'assets/images/ic_bell.svg',
                width: 26,
                height: 26,
              ),
              onPressed: () {
                // TODO: 알림 화면 이동
              },
            ),
            _NavIconButton(
              icon: SvgPicture.asset(
                'assets/images/ic_avatar.svg',
                width: 26,
                height: 26,
              ),
              onPressed: () {
                // TODO: 프로필 화면 이동
              },
            ),
          ],
        ),
      ),
      child: SafeArea(
        child: _showGroupList
            ? const GroupListPage()
            : EmptyGroupPage(
                onLater: () => setState(() => _showGroupList = true),
              ),
      ),
    );
  }
}

/// 네비게이션 바 우측 아이콘 버튼. (알림 · 프로필 공통)
class _NavIconButton extends StatelessWidget {
  const _NavIconButton({required this.icon, required this.onPressed});

  final Widget icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      minimumSize: Size.zero,
      onPressed: onPressed,
      child: icon,
    );
  }
}
