import 'package:ddara/core/exception/sign_up_exception.dart';
import 'package:ddara/core/model/auth/login.dart';
import 'package:ddara/core/model/auth/social_login_type.dart';
import 'package:ddara/data/datasource/auth/auth_datasource.dart';
import 'package:ddara/data/repository/mapper/auth_mapper.dart';
import 'package:ddara/domain/model/sign_up_command.dart';
import 'package:dio/dio.dart';

import '../../core/exception/login_exception.dart';
import '../../domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl(this._authRemoteDataSource);

  @override
  Future<Login> login(String token, SocialLoginType social) async {
    try {
      final response = await _authRemoteDataSource.login(token, social);
      return response.toDomain();
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 401:
          throw UnauthorizedException();

        default:
          throw NetworkException();
      }
    }
  }

  @override
  Future<Login> signUp(SignUpCommand signUp) async {
    try {
      final response = await _authRemoteDataSource.signUp(signUp.toDto());
      return response.toDomain();
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 400:
          // termsAgreed: false, birthDate 형식 오류, 또는 nickname 누락/20자 초과
          throw TypeMisMatchException();

        case 401:
          throw UnauthorizedException();

        case 403:
          // 만 14세 미만 → 프론트: 가입 차단 안내 화면. User 저장 안 됨
          throw AgeLimitException();
        default:
          throw NetworkException();
      }
    }
  }

  @override
  Future<String?> getAccessToken() async {
    return await _authRemoteDataSource.getAccessToken();
  }

  @override
  Future<String?> getRefreshToken() async {
    return await _authRemoteDataSource.getRefreshToken();
  }

  @override
  Future<void> saveAccessToken(String? token) async {
    await _authRemoteDataSource.saveAccessToken(token);
  }

  @override
  Future<void> saveRefreshToken(String? token) async {
    await _authRemoteDataSource.saveRefreshToken(token);
  }

  @override
  Future<String> refreshAccessToken(String refreshToken) async {
    final response = await _authRemoteDataSource.refreshAccessToken(
      refreshToken,
    );

    return response.accessToken;
  }
}
