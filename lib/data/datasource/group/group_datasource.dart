import 'package:ddara/core/network/dto/group/create_group_response.dart';
import 'package:dio/dio.dart';

class GroupDataSource {
  GroupDataSource(this._dio);

  final Dio _dio;
  static final String _baseUrl = '/api/groups';

  Future<CreateGroupResponse> createGroup(String groupName, String description) async {
    final response = await _dio.post(
      _baseUrl,
      data: {'name': groupName, 'description': description},
    );

    return CreateGroupResponse.fromJson(response.data);
  }
}
