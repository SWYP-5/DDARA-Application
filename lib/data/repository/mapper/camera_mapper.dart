import 'package:ddara/core/model/camera/starter_upload.dart';
import 'package:ddara/core/network/dto/camera/starter_upload_response.dart';

extension StarterUploadMapper on StarterUploadResponse {
  StarterUpload toDomain() {
    return StarterUpload(cycleId: cycleId);
  }
}
