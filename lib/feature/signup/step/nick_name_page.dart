import 'package:flutter/material.dart';

class NicknamePage extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final VoidCallback onSignUpButtonClicked;

  const NicknamePage({
    super.key,
    required this.onChanged,
    required this.onSignUpButtonClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('닉네임 입력 페이지'),
          TextField(
            maxLength: 20,
            textInputAction: TextInputAction.done,
            onChanged: onChanged,
            decoration: const InputDecoration(
              hintText: '닉네임을 입력해주세요',
              counterText: '',
            ),
          ),
          ElevatedButton(
            onPressed: onSignUpButtonClicked,
            child: const Text('회원가입'),
          ),
        ],
      ),
    );
  }
}
