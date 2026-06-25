import 'package:ddara/core/exception/group_exception.dart';
import 'package:ddara/core/exception/login_exception.dart';
import 'package:ddara/core/model/group/create_group.dart';
import 'package:ddara/core/model/group/group_list.dart';
import 'package:ddara/data/datasource/group/group_datasource.dart';
import 'package:ddara/domain/repository/group_repository.dart';
import 'package:dio/dio.dart';

import 'mapper/group_mapper.dart';

class GroupRepositoryImpl implements GroupRepository {
  final GroupDataSource _groupDataSource;

  GroupRepositoryImpl(this._groupDataSource);

  @override
  Future<CreateGroup> createGroup(String groupName, String description) async {
    try {
      final response = await _groupDataSource.createGroup(
        groupName,
        description,
      );
      return response.toDomain();
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 400:
          // name 누락 또는 길이 초과
          throw InvalidGroupNameException();

        case 401:
          // 토큰 없음·만료 (인터셉터 복구도 실패한 경우)
          throw UnauthorizedException();

        case 409:
          // 모임 최대 개수(20개) 초과
          throw GroupLimitExceededException();

        default:
          throw NetworkException();
      }
    }
  }

  @override
  Future<GroupList> getGroupList() async {
    final response = await _groupDataSource.getGroupList();
    return response.toDomain();
  }
}
