import 'package:flutter/material.dart';

class TitleRow extends StatelessWidget {
  final title, number;
  const TitleRow({Key? key, this.title, this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              children: [
                TextSpan(
                  text: "($number)",
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal),
                ),
              ]),
        ),
      ],
    );
  }
}
