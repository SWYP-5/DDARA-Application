import 'package:ddara/core/designsystem/component/app_text_field.dart';
import 'package:ddara/core/designsystem/component/appbar/app_bar.dart';
import 'package:ddara/core/designsystem/component/button/app_button.dart';
import 'package:ddara/core/designsystem/component/text/app_text.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/core/widget/error_message_dialog.dart';
import 'package:ddara/feature/group/create/provider/notifier_provider.dart';
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
    final notifier = ref.read(createGroupNotifierProvider.notifier);

    ref.listen(createGroupNotifierProvider, (prev, next) {
      if (prev?.createGroupId == -1 && next.createGroupId > -1) {
        context.pushReplacement(RoutePath.group, extra: next.createGroupId);
        return;
      }

      final errorMessage = next.errorMessage;

      if (errorMessage.isNotEmpty) {
        showErrorMessageDialog(context, message: errorMessage);
      }
    });

    return CupertinoPageScaffold(
      navigationBar: AppBar(title: '모임 만들기', onBack: () => context.pop()),
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
              const AppText.headlineLarge('모임 이름을 설정해주세요.'),
              const AppText.body('내가 먼저 찍으면, 친구들이 이 주제를 따라 찍어요'),
              const SizedBox(height: AppSpacing.s2),
              AppTextField(
                label: '모임 이름',
                placeholder: '예) 마라탕 걸즈',
                controller: _nameController,
                highlightWhenFilled: true,
                onChanged: notifier.groupNameOnChanged,
              ),
              const SizedBox(height: AppSpacing.s2),
              AppTextField(
                label: '한 줄 소개 (선택)',
                placeholder: '어떤 모임인지 알려주세요',
                controller: _introController,
                highlightWhenFilled: true,
                onChanged: notifier.descriptionOnChanged,
              ),
              const Spacer(),
              AppButton(
                label: '만들기',
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
