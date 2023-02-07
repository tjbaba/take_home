import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:take_home/utils/constants.dart';
import '../widgets/k_textField.dart';

Color pickerColor = const Color(0xff443a49);
Color currentColor = const Color(0xff443a49);

class EditTaskDialog extends StatefulWidget {
  final void Function(Map value)? onSelected;
  final item;

  const EditTaskDialog({
    this.onSelected,
    this.item,
    Key? key,
  }) : super(key: key);

  @override
  State<EditTaskDialog> createState() => _EditTaskDialogState();
}

class _EditTaskDialogState extends State<EditTaskDialog> {

  Color taskCardColor = Colors.white;
  @override
  void initState() {
    // TODO: implement initState
    taskCardColor = widget.item.containsKey('color')? widget.item['color']: Colors.white;
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Task.title
         KTextField(
          icon: Icons.title,
          name: 'Title',
          value: '${widget.item['title']}',
          minLines: 1,
          maxLines: 3,

        ),

        // Task.description
         KTextField(
          icon: Icons.article,
          name: 'Description',
          value: widget.item['description'],
          style: TextStyle(fontStyle: FontStyle.italic),
          minLines: 1,
          maxLines: 10,
          // onFocusLost: (value) => context.read<BoardBloc>().add(
          //   EditCardEvent(
          //     position,
          //     card.copyWith(description: value),
          //   ),
          // ),
        ),

        //Task.color
        InputDecorator(
          decoration: const InputDecoration(
            labelText: 'Color',
            labelStyle: TextStyle(
              color: kPrimaryColor
            ),
            border: InputBorder.none,
            icon: Icon(Icons.color_lens, color: kPrimaryColor,),
          ),
          child: InkWell(
            onTap: (){
              colorPickerDialog();
            },
            child: Row(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  color: taskCardColor,
                  child: SizedBox(height: 40, width: 40,),
                ),
              ],
            ),
          )
        ),
      ],
    );
  }
  Future<bool> colorPickerDialog() async {
    return ColorPicker(
      // Use the dialogPickerColor as start color.
      color: taskCardColor,
      // Update the dialogPickerColor using the callback.
      onColorChanged: (Color color) =>
          setState(() => taskCardColor = color),
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
      actionButtons: const ColorPickerActionButtons(
        okButton: true,
        closeButton: true
      ),
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
      transitionBuilder: (BuildContext context,
          Animation<double> a1,
          Animation<double> a2,
          Widget widget) {
        final double curvedValue =
            Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(
              0.0, curvedValue * 200, 0.0),
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
