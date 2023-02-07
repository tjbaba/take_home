import 'package:flutter/material.dart';

class BoardCreationList extends StatelessWidget {
  final void Function(String value)? onSelected;

  const BoardCreationList({
    this.onSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Text('Default'),
        ListTile(
          dense: true,
          title: const Text('Empty board'),
          onTap: () {
            if (onSelected != null) onSelected!('Empty Board');
          },
        ),
        const SizedBox(height: 8.0),
        const Text('Other templates'),
        ListTile(
          dense: true,
          title: const Text('Software Project'),
          subtitle: const Text('To Do, Doing, Done'),
          onTap: () {
            if (onSelected != null) onSelected!('Software Project');
          },
        ),
        ListTile(
          dense: true,
          title: const Text('Weekly Plan'),
          subtitle: const Text('Monday, Tuesday, Wednesday, …'),
          onTap: () {
            if (onSelected != null) onSelected!('Weekly Plan');
          },
        ),
        ListTile(
          dense: true,
          title: const Text('Quarterly Plan'),
          subtitle: const Text('Q1, Q2, Q3, Q4'),
          onTap: () {
            if (onSelected != null) onSelected!('Quarterly Plan');
          },
        ),
      ],
    );
  }
}
