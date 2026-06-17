// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SignUpRequest _$SignUpRequestFromJson(Map<String, dynamic> json) =>
    _SignUpRequest(
      provider: json['provider'] as String,
      accessToken: json['accessToken'] as String,
      birthDate: json['birthDate'] as String,
      termsAgreed: json['termsAgreed'] as bool,
      nickname: json['nickname'] as String,
    );

Map<String, dynamic> _$SignUpRequestToJson(_SignUpRequest instance) =>
    <String, dynamic>{
      'provider': instance.provider,
      'accessToken': instance.accessToken,
      'birthDate': instance.birthDate,
      'termsAgreed': instance.termsAgreed,
      'nickname': instance.nickname,
    };
