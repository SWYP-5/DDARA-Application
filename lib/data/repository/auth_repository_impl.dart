import 'package:ddara/core/model/auth/login.dart';
import 'package:ddara/core/model/auth/social_login_type.dart';
import 'package:ddara/data/datasource/auth/auth_datasource.dart';
import 'package:ddara/data/repository/mapper/mapper.dart';
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
}
