import 'package:flutter/material.dart';
import 'package:take_home/utils/constants.dart';

class KTextField extends StatefulWidget {
  final IconData icon;
  final String name;
  final String value;
  final TextStyle? style;
  final int? minLines;
  final int? maxLines;
  final bool autofocus;
  final AutovalidateMode? autovalidateMode;
  final String? Function(String? value)? validator;
  final void Function(String value)? onFocusLost;
  final void Function(String value)? onChanged;
  const KTextField({
    required this.icon,
    required this.name,
    required this.value,
    this.onFocusLost,
    this.onChanged,
    this.style,
    this.minLines,
    this.maxLines,
    this.autovalidateMode,
    this.validator,
    this.autofocus = false,
    Key? key,
  })  : assert((minLines ?? 1) >= 1),
        assert((maxLines ?? 1) >= 1),
        assert(maxLines != null ? (minLines ?? maxLines) <= maxLines : true),
        assert(minLines != null ? minLines <= (maxLines ?? minLines) : true),
        super(key: key);

  @override
  _KTextFieldState createState() => _KTextFieldState();
}

class _KTextFieldState extends State<KTextField> {
  late final FocusNode _focusNode;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: widget.value);
    if (widget.autofocus) {
      _controller.selection = TextSelection(
        baseOffset: 0,
        extentOffset: widget.value.length,
      );
    }

    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    _focusNode.dispose();

    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      controller: _controller,
      style: widget.style,
      keyboardType: TextInputType.text,
      autofocus: widget.autofocus,
      decoration: InputDecoration(
        labelStyle: TextStyle(
          color: Colors.black
        ),
        hintText: widget.name,
        labelText: widget.name,
        border: InputBorder.none,
        icon: Icon(widget.icon, color: kPrimaryColor,),
      ),
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      autovalidateMode: widget.autovalidateMode,
      validator: widget.validator,
      onChanged: (value) {
        if (widget.onChanged != null) widget.onChanged!(value);
      },
    );
  }

  void _onFocusChanged() {
    // Make sure the value validates.
    if (widget.validator != null &&
        widget.validator!(_controller.value.text) != null) return;

    if (widget.onFocusLost != null && !_focusNode.hasFocus) {
      widget.onFocusLost!(_controller.value.text);
    }
  }
}
