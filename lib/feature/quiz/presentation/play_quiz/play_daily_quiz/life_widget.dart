import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LifeWidget extends ConsumerWidget {
  const LifeWidget({super.key, required this.incorrectCount});

  final int incorrectCount;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fullScreenWidth = MediaQuery.of(context).size.width;

    Icon favoriteIcon(int borderCount) {
      if (incorrectCount < borderCount) {
        return const Icon(Icons.favorite_rounded);
      }
      return const Icon(Icons.favorite_border_rounded);
    }

    return Align(
      child: SizedBox(
        width: fullScreenWidth / 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            favoriteIcon(1),
            favoriteIcon(2),
            const Icon(Icons.favorite_rounded),
          ],
        ),
      ),
    );
  }
}
