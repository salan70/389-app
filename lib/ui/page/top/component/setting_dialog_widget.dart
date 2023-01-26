import 'package:flutter/material.dart';

class SettingDialog extends StatelessWidget {
  const SettingDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: SizedBox(
          height: 320,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 8,
              ),
              const Text('その他'),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.mail_outline_rounded),
                label: const Text('お問い合わせ'),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.description_rounded),
                label: const Text('利用規約'),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.person_rounded),
                label: const Text('プライバシーポリシー'),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close_rounded),
                label: const Text('閉じる'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
