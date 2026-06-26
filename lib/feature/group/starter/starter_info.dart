import 'package:ddara/core/designsystem/component/app_text_field.dart';
import 'package:ddara/core/designsystem/component/button/app_button.dart';
import 'package:ddara/core/designsystem/design_system.dart';
import 'package:ddara/feature/group/starter/provider/notifier_provider.dart';
import 'package:ddara/feature/group/widget/take_photo_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 스타터 시작 화면 본문. (촬영 카드 · 컨셉 설명 입력 · 전송 버튼)
class StarterInfo extends ConsumerStatefulWidget {
  const StarterInfo({super.key});

  @override
  ConsumerState<StarterInfo> createState() => _StarterInfoState();
}

class _StarterInfoState extends ConsumerState<StarterInfo> {
  late final TextEditingController _conceptController;

  @override
  void initState() {
    super.initState();
    // 단계가 바뀌었다 돌아와도 입력값이 유지되도록 state 에서 복원한다.
    _conceptController = TextEditingController(
      text: ref.read(starterNotifierProvider).concept,
    );
  }

  @override
  void dispose() {
    _conceptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(starterNotifierProvider.notifier);
    final photo = ref.watch(starterNotifierProvider.select((s) => s.photo));
    final hasPhoto = photo != null;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.s5,
          vertical: AppSpacing.s6,
        ),
        // 키보드가 올라와 높이가 줄면 내용을 스크롤시켜 오버플로를 막는다.
        // 공간이 충분하면 Spacer 가 버튼을 하단에 고정한다.
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: AppSpacing.s5,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 465,
                        padding: const EdgeInsets.all(AppSpacing.s4),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: AppColors.bgSurface,
                          borderRadius: BorderRadius.circular(AppRadius.lg),
                          // 사진이 있으면 카드를 가득 채워 보여준다.
                          image: hasPhoto
                              ? DecorationImage(image: photo, fit: BoxFit.cover)
                              : null,
                        ),
                        // 사진이 없을 때만 가운데에 촬영 버튼을 표시한다.
                        child: hasPhoto
                            ? null
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TakePhotoButton(
                                    size: TakePhotoButtonSize.large,
                                    onPressed: notifier.goToCamera,
                                  ),
                                ],
                              ),
                      ),
                      AppTextField(
                        label: '컨셉 설명',
                        placeholder: '예) 마라탕 또 먹기',
                        controller: _conceptController,
                        highlightWhenFilled: true,
                        onChanged: notifier.conceptChanged,
                      ),
                      const Spacer(),
                      AppButton(
                        label: '멤버들에게 보내기',
                        // 사진이 없으면 비활성화.
                        onPressed: hasPhoto
                            ? () {
                                // TODO: 스타터 컨셉을 멤버들에게 전송. (백엔드 스펙 대기)
                              }
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
