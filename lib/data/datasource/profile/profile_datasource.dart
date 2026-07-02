import 'package:ddara/core/network/dto/profile/profile_response.dart';
import 'package:dio/dio.dart';

class ProfileDataSource {
  ProfileDataSource(this._dio);

  final Dio _dio;

  static final String _baseUrl = '/api/users';

  Future<ProfileResponse> getProfile() async {
    final response = await _dio.get('$_baseUrl/me');
    return ProfileResponse.fromJson(response.data);
  }
}
