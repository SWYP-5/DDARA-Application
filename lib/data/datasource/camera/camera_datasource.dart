import 'dart:io';
import 'dart:typed_data';

import 'package:ddara/core/network/dto/camera/presign_response.dart';
import 'package:ddara/core/network/dto/camera/starter_upload_response.dart';
import 'package:ddara/core/network/dto/group/cycle_gallery_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class CameraDataSource {
  CameraDataSource(this._dio);

  final Dio _dio;
  static final String _baseUrl = '/api/groups';

  /// 촬영본을 리사이징·압축한 바이트를 반환한다. (실패 시 원본 바이트)
  Future<Uint8List> compress(String imagePath) async {
    final compressed = await FlutterImageCompress.compressWithFile(
      imagePath,
      minWidth: 1080,
      minHeight: 1080,
      quality: 85,
    );

    return compressed ?? await File(imagePath).readAsBytes();
  }

  /// S3 업로드용 presigned URL을 발급받는다.
  Future<PresignResponse> presign(String purpose, String contentType) async {
    final response = await _dio.post(
      '/api/uploads/presign',
      data: {'purpose': purpose, 'contentType': contentType},
    );

    return PresignResponse.fromJson(response.data);
  }

  /// presigned URL로 S3에 이미지 바이트를 직접 PUT 업로드한다.
  Future<void> uploadToS3(
    String uploadUrl,
    Uint8List bytes,
    String contentType,
  ) async {
    // 인증 인터셉터·baseUrl 없는 순수 Dio로 전송한다.
    // (Authorization 헤더가 붙으면 presigned 쿼리 서명과 충돌해 S3가 거부한다)
    final s3Dio = Dio();

    await s3Dio.put(
      uploadUrl,
      data: Stream.fromIterable([bytes]),
      options: Options(
        headers: {
          Headers.contentTypeHeader: contentType,
          Headers.contentLengthHeader: bytes.length,
        },
      ),
    );
  }

  /// 업로드된 이미지 URL로 새 사이클을 생성한다.
  Future<StarterUploadResponse> createCycle(
    int groupId,
    String topic,
    String imageUrl,
  ) async {
    final response = await _dio.post(
      '$_baseUrl/$groupId/cycles',
      data: {'topic': topic, 'imageUrl': imageUrl},
    );

    return StarterUploadResponse.fromJson(response.data);
  }

  /// 사이클의 멤버별 따라찍기 사진(shots)을 조회한다.
  Future<CycleGalleryResponse> getCycleGallery(int cycleId) async {
    final response = await _dio.get('/api/cycles/$cycleId/shots');

    return CycleGalleryResponse.fromJson(response.data);
  }
}
