import 'package:ddara/core/designsystem/component/app_text_field.dart';
import 'package:ddara/core/designsystem/component/appbar/app_bar.dart';
import 'package:ddara/core/designsystem/component/button/app_button.dart';
import 'package:ddara/core/designsystem/component/text/app_text.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/widget/toast/toast.dart';
import 'package:ddara/feature/group/create/provider/notifier_provider.dart';
import 'package:ddara/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/route_path.dart';

class GroupCreatePage extends ConsumerStatefulWidget {
  const GroupCreatePage({super.key});

  @override
  ConsumerState<GroupCreatePage> createState() => _GroupCreatePageState();
}

class _GroupCreatePageState extends ConsumerState<GroupCreatePage> {
  final _nameController = TextEditingController();
  final _introController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 모임 이름 입력 여부에 따라 '만들기' 버튼 활성화 상태가 바뀐다.
    _nameController.addListener(_onNameChanged);
  }

  void _onNameChanged() => setState(() {});

  /// 모임 이름이 비어있지 않아야 생성 가능.
  bool get _canSubmit => _nameController.text.trim().isNotEmpty;

  @override
  void dispose() {
    _nameController.removeListener(_onNameChanged);
    _nameController.dispose();
    _introController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final notifier = ref.read(createGroupNotifierProvider.notifier);

    ref.listen(createGroupNotifierProvider, (prev, next) {
      if (prev?.createGroupId == -1 && next.createGroupId > -1) {
        context.pushReplacement(RoutePath.group, extra: next.createGroupId);
        return;
      }

      final errorMessage = next.errorMessage;

      if (errorMessage.isNotEmpty) {
        Toast.showToast(context, errorMessage, type: ToastType.error);
      }
    });

    return CupertinoPageScaffold(
      navigationBar: AppBar(title: l10n.groupCreate, onBack: () => context.pop()),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: AppSpacing.s5,
            right: AppSpacing.s5,
            top: AppSpacing.s4,
            bottom: AppSpacing.s4,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.s3,
            children: [
              AppText.headlineLarge(l10n.groupCreateTitle),
              AppText.body(l10n.groupCreateSubtitle),
              const SizedBox(height: AppSpacing.s2),
              AppTextField(
                label: l10n.groupCreateNameLabel,
                placeholder: l10n.groupCreateNamePlaceholder,
                controller: _nameController,
                highlightWhenFilled: true,
                onChanged: notifier.groupNameOnChanged,
              ),
              const SizedBox(height: AppSpacing.s2),
              AppTextField(
                label: l10n.groupCreateIntroLabel,
                placeholder: l10n.groupCreateIntroPlaceholder,
                controller: _introController,
                highlightWhenFilled: true,
                onChanged: notifier.descriptionOnChanged,
              ),
              const Spacer(),
              AppButton(
                label: l10n.groupCreateSubmit,
                onPressed: _canSubmit
                    ? () {
                        notifier.createGroup();
                      }
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
