import 'package:ddara/domain/repository/cycle_repository.dart';

import '../../../core/model/group/cycle_gallery.dart';

class GetCycleGalleryUseCase {
  GetCycleGalleryUseCase(this._cycleRepository);

  final CycleRepository _cycleRepository;

  Future<CycleGallery> call(int cycleId) async {
    final test = await _cycleRepository.getCycleGallery(cycleId);
    print("테스트 사이클: $test");
    return test;
  }
}
