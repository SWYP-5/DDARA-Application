import 'package:flutter/material.dart';

class TermsPage extends StatelessWidget {
  final VoidCallback onNextButtonClicked;

  const TermsPage({
    super.key,
    required this.onNextButtonClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('약관 동의 페이지'),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: onNextButtonClicked,
            child: const Text('다음'),
          )
        ],
      ),
    );
  }
}
