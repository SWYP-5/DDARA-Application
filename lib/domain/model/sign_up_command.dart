import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_command.freezed.dart';

@freezed
abstract class SignUpCommand with _$SignUpCommand {
  const factory SignUpCommand({
    required String provider,
    required String accessToken,
    required String birthDate,
    required bool termsAgreed,
    required String nickname,
  }) = _SignUpCommand;
}
