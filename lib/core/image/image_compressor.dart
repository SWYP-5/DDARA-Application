import 'package:flutter_image_compress/flutter_image_compress.dart';

/// 업로드 직전 이미지를 리사이즈 + 재인코딩하는 압축 유틸.
///
/// 적용 위치(예: 촬영 후 `onUpload`)는 호출하는 쪽에서 연결한다.
class ImageCompressor {
  const ImageCompressor._();

  /// [path] 의 이미지를 [maxSize] 정사각 박스에 맞춰 축소하고
  /// JPEG [quality] 로 재인코딩한 새 파일 경로를 반환한다. 실패 시 null.
  ///
  /// - 가로세로 비율은 유지하며, 원본보다 키우지는 않는다.
  /// - 비율 유지 특성상 더 짧은 변이 [maxSize] 에 맞춰지고, 긴 변은 그에 비례한다.
  ///   (예: 4000×3000, maxSize 1080 → 1440×1080)
  /// - EXIF 회전은 패키지가 자동 보정한다.
  static Future<String?> compress(
    String path, {
    int maxSize = 1080,
    int quality = 80,
  }) async {
    // 원본을 덮어쓰지 않도록 새 경로에 저장한다.
    final targetPath = '${path}_compressed.jpg';

    final result = await FlutterImageCompress.compressAndGetFile(
      path,
      targetPath,
      minWidth: maxSize,
      minHeight: maxSize,
      quality: quality,
      format: CompressFormat.jpeg,
    );

    return result?.path;
  }
}
