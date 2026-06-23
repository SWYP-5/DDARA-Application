import 'package:ddara/feature/group/detail/widget/header/empty_header.dart';
import 'package:flutter/cupertino.dart';

/// 모임 상세 화면 상단 헤더.
///
/// [imageUri] 가 없으면(따라찍기 전) [EmptyHeader] 를, 있으면 해당 이미지를 보여준다.
class GroupHeader extends StatelessWidget {
  const GroupHeader({super.key, this.imageUri, required this.navigateToStart});

  /// 대표로 보여줄 이미지 URI. null/빈 값이면 빈 상태로 본다.
  final String? imageUri;

  /// 빈 상태에서 '스타터 시작하기' 버튼을 눌렀을 때 실행할 콜백.
  final VoidCallback navigateToStart;

  @override
  Widget build(BuildContext context) {
    final uri = imageUri;

    // 이미지가 없으면 빈 상태 헤더.
    if (uri == null || uri.isEmpty) {
      return EmptyHeader(navigateToStart: navigateToStart);
    }

    // TODO: 이미지가 있을 때의 헤더 UI 구현. (현재는 임시로 네트워크 이미지 표시)
    return Image.network(uri, fit: BoxFit.cover);
  }
}
