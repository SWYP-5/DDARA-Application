import 'package:ddara/core/network/dto/profile/notification_settings_request.dart';
import 'package:ddara/core/network/dto/profile/notification_settings_response.dart';
import 'package:ddara/core/network/dto/profile/profile_response.dart';
import 'package:dio/dio.dart';

class ProfileDataSource {
  ProfileDataSource(this._dio);

  final Dio _dio;

  static final String _baseUrl = '/api/users/me';

  Future<ProfileResponse> getProfile() async {
    final response = await _dio.get(_baseUrl);
    return ProfileResponse.fromJson(response.data);
  }

  /// 회원 탈퇴. (요청 body·응답 body 없음)
  Future<void> deleteAccount() async {
    await _dio.delete(_baseUrl);
  }

  Future<NotificationSettingsResponse> changeNotificationSettings(
    NotificationSettingsRequest request,
  ) async {
    final response = await _dio.patch('$_baseUrl/notification-settings', data: request.toJson());
    return NotificationSettingsResponse.fromJson(response.data);
  }

  Future<NotificationSettingsResponse> getNotificationSettings() async {
    final response = await _dio.get('$_baseUrl/notification-settings');
    return NotificationSettingsResponse.fromJson(response.data);
  }
}
