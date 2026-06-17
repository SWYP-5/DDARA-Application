import 'package:ddara/core/model/auth/social_login_type.dart';
import 'package:ddara/core/network/dto/auth/sign_up_request.dart';
import 'package:dio/dio.dart';

import '../../../core/network/dto/auth/login_response.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource(this._dio);

  final Dio _dio;

  Future<LoginResponse> signUp(SignUpRequest signUp) async {
    try {
      final response = await _dio.post(
        '/api/auth/signup',
        data: signUp.toJson(),
      );
      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<LoginResponse> login(String token, SocialLoginType social) async {
    try {
      final response = switch (social) {
        SocialLoginType.google => await _googleLogin(token),
        SocialLoginType.kakao => await _kakaoLogin(token),
      };

      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<Response> _googleLogin(String token) async {
    return await _dio.post('/api/auth/google', data: {'accessToken': token});
  }

  Future<Response> _kakaoLogin(String token) async {
    return await _dio.post('/api/auth/kakao', data: {'accessToken': token});
  }
}
