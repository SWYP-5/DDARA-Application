import 'package:ddara/core/designsystem/component/button/app_pill_button.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/model/group/group_list.dart';
import 'package:ddara/core/router/route_path.dart';
import 'package:ddara/feature/home/widget/group_list_widget.dart';
import 'package:ddara/feature/home/widget/meeting_card.dart';
import 'package:ddara/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

/// 우측 하단 FAB 의 지름.
const double _fabSize = 56;

/// 참여한 모임이 하나 이상일 때 보여주는 모임 목록 화면.
///
/// 화면을 세로로 반 나눠 좌/우 두 열에 카드를 번갈아(지그재그) 배치한다.
/// 우측 열 맨 위에는 카드보다 작은 고정 위젯([HomeWidget])이 들어가, 그 높이
/// 차이만큼 우측 카드들이 위로 덜 내려오면서 자연스러운 지그재그가 만들어진다.
///
/// 카드 높이가 균일하므로 Masonry 패키지 없이 `Row` + `Column` 2개로 충분하다.
class GroupListPage extends StatefulWidget {
  const GroupListPage({super.key, required this.groups});

  /// 표시할 모임 목록. (상위 HomePage 에서 조회 결과를 주입)
  final List<Group> groups;

  @override
  State<GroupListPage> createState() => _GroupListPageState();
}

class _GroupListPageState extends State<GroupListPage> {
  /// FAB(추가 버튼) 열림 여부. true 면 + 아이콘이 x 로 바뀐다.
  bool _isMenuOpen = false;

  void _toggleMenu() => setState(() => _isMenuOpen = !_isMenuOpen);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final groups = widget.groups;
    return Stack(
      // 콘텐츠가 짧아도(빈 목록 등) 화면 전체 높이를 채워 FAB 가 항상 바닥에 붙도록.
      fit: StackFit.expand,
      children: [
        SingleChildScrollView(
          // 끝에서 더 당겨지는 바운스(overscroll)를 막고 가장자리에서 멈춘다.
          physics: const ClampingScrollPhysics(),
          // 위아래 s6, 좌우 s4. (하단은 FAB 에 가리지 않도록 버튼 높이만큼 더 여유)
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.s4,
            AppSpacing.s6,
            AppSpacing.s4,
            AppSpacing.s6 + _fabSize + AppSpacing.s4,
          ),
          child: Row(
            // 핵심: 두 열을 위 기준으로 정렬해야 고정 위젯이 만든 오프셋이 유지된다.
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 좌측 열: 짝수 인덱스 카드 (0, 2, 4 …)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: AppSpacing.s4,
                  children: [
                    for (var i = 0; i < groups.length; i += 2)
                      MeetingCard(
                        group: groups[i],
                        onTap: () => _openGroup(context, groups[i].groupId),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.s4),
              // 우측 열: 맨 위 고정 위젯 + 홀수 인덱스 카드 (1, 3, 5 …)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: AppSpacing.s4,
                  children: [
                    // 참여 중인 모임 개수를 주입. (지그재그 오프셋용 고정 위젯)
                    HomeWidget(count: groups.length),
                    for (var i = 1; i < groups.length; i += 2)
                      MeetingCard(
                        group: groups[i],
                        onTap: () => _openGroup(context, groups[i].groupId),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // 우측 하단 고정 FAB. 열리면 바로 위에 액션 버튼 2개가 나타난다.
        Positioned(
          right: AppSpacing.s5,
          bottom: AppSpacing.s5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: AppSpacing.s3,
            children: [
              // 열린 상태에서만 액션 버튼을 보여준다.
              // IntrinsicWidth + stretch 로 두 버튼 너비를 더 넓은 쪽에 맞춘다.
              if (_isMenuOpen)
                IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: AppSpacing.s3,
                    children: [
                      AppPillButton(
                        label: l10n.groupCreate,
                        onPressed: () => context.push(RoutePath.groupCreate),
                      ),
                      AppPillButton.outline(
                        label: l10n.groupEnter,
                        onPressed: () => context.push(RoutePath.groupJoin),
                      ),
                    ],
                  ),
                ),
              _FloatingAddButton(isOpen: _isMenuOpen, onPressed: _toggleMenu),
            ],
          ),
        ),
      ],
    );
  }

  void _openGroup(BuildContext context, int groupId) {
    context.push(RoutePath.group, extra: groupId);
  }
}

/// 우측 하단에 떠 있는 원형 추가 버튼.
/// [isOpen] 이면 + 대신 x(닫기) 아이콘을 보여준다.
class _FloatingAddButton extends StatelessWidget {
  const _FloatingAddButton({required this.onPressed, required this.isOpen});

  final VoidCallback onPressed;
  final bool isOpen;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minimumSize: Size.zero,
      onPressed: onPressed,
      child: Container(
        width: _fabSize,
        height: _fabSize,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.accentDefault,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColorPrimitives.black40,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          isOpen ? CupertinoIcons.xmark : CupertinoIcons.add,
          size: 28,
          color: AppColors.textOnAccent,
        ),
      ),
    );
  }
}
