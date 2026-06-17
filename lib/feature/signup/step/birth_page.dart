import 'package:ddara/feature/signup/step/util/birthday_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BirthPage extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final VoidCallback onNextButtonClicked;

  const BirthPage({
    super.key,
    required this.onChanged,
    required this.onNextButtonClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('생년월일 입력 페이지'),
          const SizedBox(height: 10),
          TextField(
            onChanged: onChanged,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              BirthdayInputFormatter(),
            ],
            decoration: const InputDecoration(
              hintText: '2000-01-01',
            ),
          ),
          ElevatedButton(
            onPressed: onNextButtonClicked,
            child: const Text('다음'),
          )
        ],
      ),
    );
  }
}
