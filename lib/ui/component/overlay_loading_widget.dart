import 'package:flutter/material.dart';

/// 二度押しを防止したいときなどに使用するオーバーレイローディング
class OverlayLoading extends StatelessWidget {
  const OverlayLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Colors.black26,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
