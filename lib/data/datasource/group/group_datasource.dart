import 'package:ddara/core/network/dto/group/create_group_response.dart';
import 'package:ddara/core/network/dto/group/group_detail_response.dart';
import 'package:ddara/core/network/dto/group/group_list_response.dart';
import 'package:ddara/core/network/dto/group/invite_group_response.dart';
import 'package:dio/dio.dart';

class GroupDataSource {
  GroupDataSource(this._dio);

  final Dio _dio;
  static final String _baseUrl = '/api/groups';

  Future<CreateGroupResponse> createGroup(
    String groupName,
    String description,
    String nickName,
  ) async {
    final response = await _dio.post(
      _baseUrl,
      data: {'name': groupName, 'description': description, 'nickname': nickName},
    );

    return CreateGroupResponse.fromJson(response.data);
  }

  Future<GroupListResponse> getGroupList() async {
    final response = await _dio.get(_baseUrl);

    return GroupListResponse.fromJson(response.data);
  }

  Future<GroupDetailResponse> getGroupDetail(int groupId) async {
    final response = await _dio.get('$_baseUrl/$groupId');

    return GroupDetailResponse.fromJson(response.data);
  }

  Future<InviteGroupResponse> getInviteGroup(String inviteCode) async {
    final response = await _dio.post(
      '$_baseUrl/join',
      data: {'inviteCode': inviteCode},
    );

    return InviteGroupResponse.fromJson(response.data);
  }
}
