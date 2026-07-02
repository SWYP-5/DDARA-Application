import 'package:ddara/core/model/cycle/starter_upload.dart';
import 'package:ddara/core/network/dto/cycle/starter_upload_response.dart';

extension StarterUploadMapper on StarterUploadResponse {
  StarterUpload toDomain() {
    return StarterUpload(cycleId: cycleId);
  }
}
