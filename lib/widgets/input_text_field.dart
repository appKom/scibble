import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:scibble/theme/scibble_color.dart';

class InputTextField extends StatefulWidget {
  final String label;
  final String input;
  final String suffix;
  final bool enabled;
  final TextInputType keyboardType;
  final Function(String value) setInput;
  List<TextInputFormatter> get inputFormatters {
    if (this.keyboardType == TextInputType.number)
      return [FilteringTextInputFormatter.digitsOnly];
    return null;
  }

  InputTextField({
    Key key,
    @required this.label,
    this.input: "",
    this.suffix: "",
    this.enabled,
    this.keyboardType: TextInputType.text,
    this.setInput,
  }) : super(key: key);

  @override
  _InputTextField createState() => _InputTextField();
}

class _InputTextField extends State<InputTextField> {
  _InputTextField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: TextField(
        onChanged: (value) => widget.setInput(value),
        enabled: widget.enabled,
        keyboardType: widget.keyboardType,
        controller: TextEditingController(text: widget.input),
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
          labelText: widget.label,
          border: OutlineInputBorder(),
          suffix: Text(widget.suffix),
        ),
      ),
    );
  }
}
