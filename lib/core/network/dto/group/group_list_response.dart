import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_list_response.freezed.dart';
part 'group_list_response.g.dart';

@freezed
abstract class GroupListResponse with _$GroupListResponse {
  const factory GroupListResponse({required List<GroupResponse> groups}) =
      _GroupListResponse;

  factory GroupListResponse.fromJson(Map<String, dynamic> json) =>
      _$GroupListResponseFromJson(json);
}

@freezed
abstract class GroupResponse with _$GroupResponse {
  const factory GroupResponse({
    required int groupId,
    required String name,
    required String ownerNickname,
    required int memberCount,
    // 진행 중인 사이클이 없으면 null.
    required CurrentCycleResponse? currentCycle,
    required DateTime createdAt,
  }) = _GroupResponse;

  factory GroupResponse.fromJson(Map<String, dynamic> json) =>
      _$GroupResponseFromJson(json);
}

@freezed
abstract class CurrentCycleResponse with _$CurrentCycleResponse {
  const factory CurrentCycleResponse({
    required int cycleId,
    required String topic,
    required String status,
    required DateTime startedAt,
    required String? thumbnailUrl,
  }) = _CurrentCycleResponse;

  factory CurrentCycleResponse.fromJson(Map<String, dynamic> json) =>
      _$CurrentCycleResponseFromJson(json);
}
