import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:take_home/providers/edit_task/edit_task_provider.dart';
import 'package:take_home/utils/constants.dart';
import '../widgets/k_textField.dart';
import 'dart:math' as math;

Color pickerColor = const Color(0xff443a49);
Color currentColor = const Color(0xff443a49);

class EditTaskDialog extends ConsumerStatefulWidget {
  final void Function(Map value)? onSelected;
  final item, innerIndex, outerIndex;

  const EditTaskDialog({
    this.onSelected,
    this.item,
    this.outerIndex,
    this.innerIndex,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<EditTaskDialog> createState() => _EditTaskDialogState();
}

class _EditTaskDialogState extends ConsumerState<EditTaskDialog> {
  List<String> options = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
  ];

  @override
  void initState() {
    super.initState();
    ref.read(editTaskProvider).startDate != null
        ? ref.read(editTaskProvider).checkTime()
        : null;
    ref.read(editTaskProvider).checkValues(widget.item);
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(editTaskProvider);
    return ListView(
      children: [
        // Task.title
        KTextField(
          icon: Icons.title,
          name: 'Title',
          value: provider.title!,
          minLines: 1,
          maxLines: 3,
          onChanged: (value) {
            provider.title = value;
          },
        ),

        // Task.description
        KTextField(
          icon: Icons.article,
          name: 'Description',
          value: provider.description!,
          style: const TextStyle(fontStyle: FontStyle.italic),
          minLines: 1,
          maxLines: 10,
          onChanged: (value) {
            provider.description = value;
          },
          // onFocusLost: (value) => context.read<BoardBloc>().add(
          //   EditCardEvent(
          //     position,
          //     card.copyWith(description: value),
          //   ),
          // ),
        ),

        //Task.timer
        InputDecorator(
            decoration: const InputDecoration(
              labelText: 'Timer',
              labelStyle: TextStyle(color: kPrimaryColor),
              border: InputBorder.none,
              icon: Icon(
                Icons.timer,
                color: kPrimaryColor,
              ),
            ),
            child: InkWell(
              onTap: () async {
                provider.startTimer();
              },
              child: Row(
                children: [
                  provider.startDate == null
                      ? const Text('Start Timer')
                      : Consumer(builder: (context, watch, child) {

                        return Text("${watch.watch(editTaskProvider).timePassed}");
                  })
                ],
              ),
            )),

        //Task.color
        InputDecorator(
            decoration: const InputDecoration(
              labelText: 'Color',
              labelStyle: TextStyle(color: kPrimaryColor),
              border: InputBorder.none,
              icon: Icon(
                Icons.color_lens,
                color: kPrimaryColor,
              ),
            ),
            child: InkWell(
              onTap: () {
                colorPickerDialog();
              },
              child: Row(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    color: provider.color,
                    child: const SizedBox(
                      height: 40,
                      width: 40,
                    ),
                  ),
                ],
              ),
            )),

        //Task.dueDate
        InputDecorator(
            decoration: const InputDecoration(
              labelText: 'Due Date',
              labelStyle: TextStyle(color: kPrimaryColor),
              border: InputBorder.none,
              icon: Icon(
                Icons.hourglass_full,
                color: kPrimaryColor,
              ),
            ),
            child: InkWell(
              onTap: () async {
                provider.datePicker(context);
              },
              child: Row(
                children: [
                  provider.dueDate == null
                      ? const Text('Pick Date')
                      : Text(
                          DateFormat('dd MMM yyyy').format(provider.dueDate!))
                ],
              ),
            )),

        //Task.label
        InputDecorator(
            decoration: const InputDecoration(
              labelText: 'Label',
              labelStyle: TextStyle(color: kPrimaryColor),
              border: InputBorder.none,
              icon: Icon(
                Icons.label,
                color: kPrimaryColor,
              ),
            ),
            child: Wrap(
              // space between chips
              spacing: 10,
              // list of chips
              children: provider.options
                  .map((chip) => InkWell(
                        onTap: () {
                          provider.updateLabel(chip);
                        },
                        child: Chip(
                          label: Text(chip),
                          side: provider.label == chip
                              ? const BorderSide(color: Colors.black)
                              : null,
                          backgroundColor: kBackgroundColor,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          deleteIconColor: Colors.red,
                        ),
                      ))
                  .toList(),
            )),

        //Task.note
        // Task.description
        KTextField(
          icon: Icons.article,
          name: 'Note',
          value: provider.description!,
          style: const TextStyle(fontStyle: FontStyle.italic),
          minLines: 1,
          maxLines: 10,
          onChanged: (value) {
            provider.note = value;
          },
          // onFocusLost: (value) => context.read<BoardBloc>().add(
          //   EditCardEvent(
          //     position,
          //     card.copyWith(description: value),
          //   ),
          // ),
        ),
      ],
    );
  }

  Future<bool> colorPickerDialog() async {
    final provider = ref.watch(editTaskProvider);
    return ColorPicker(
      // Use the dialogPickerColor as start color.
      color: provider.color!,
      // Update the dialogPickerColor using the callback.
      onColorChanged: (Color color) => setState(() => provider.color = color),
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      wheelSubheading: Text(
        'Selected color and its shades',
        style: Theme.of(context).textTheme.titleSmall,
      ),
      actionButtons:
          const ColorPickerActionButtons(okButton: true, closeButton: true),
      showMaterialName: true,
      showColorName: true,
      showColorCode: true,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
      ),
      materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
      colorCodeTextStyle: Theme.of(context).textTheme.bodySmall,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: true,
        ColorPickerType.wheel: true,
      },
    ).showPickerDialog(
      context,
      // New in version 3.0.0 custom transitions support.
      transitionBuilder: (BuildContext context, Animation<double> a1,
          Animation<double> a2, Widget widget) {
        final double curvedValue =
            Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: widget,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
      constraints:
          const BoxConstraints(minHeight: 460, minWidth: 300, maxWidth: 320),
    );
  }
}
