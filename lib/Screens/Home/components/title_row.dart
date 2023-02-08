import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:take_home/providers/Firebase/Backend/backend.dart';

class TitleRow extends ConsumerWidget {
  final title, number;
  const TitleRow({Key? key, this.title, this.number}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
              text: title,
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
