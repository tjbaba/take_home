import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:take_home/providers/edit_project_provider/edit_project_provider.dart';
import 'package:take_home/providers/edit_task/edit_task_provider.dart';
import 'package:take_home/utils/constants.dart';
import '../widgets/k_textField.dart';
import 'dart:math' as math;

Color pickerColor = const Color(0xff443a49);
Color currentColor = const Color(0xff443a49);

class EditProjectDialouge extends ConsumerStatefulWidget {
  final name, description;

  const EditProjectDialouge({
    this.description, this.name,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<EditProjectDialouge> createState() => _EditProjectDialogState();
}

class _EditProjectDialogState extends ConsumerState<EditProjectDialouge> {


  @override
  void initState() {
    super.initState();
    ref.read(editProjectProvider).checkValues(widget.name, widget.description);
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(editProjectProvider);
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
