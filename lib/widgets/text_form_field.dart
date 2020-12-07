import 'package:flutter/material.dart';

class TextFormFieldEntry extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType textInputType;
  final double radius;
  final int maxLength;
  final String counterText;

  TextFormFieldEntry({
    Key key,
    this.maxLength,
    this.controller,
    this.hintText,
    this.textInputType,
    this.radius,
    this.counterText,
  }) : super(key: key);

  @override
  _TextFormFieldEntryState createState() => _TextFormFieldEntryState();
}

class _TextFormFieldEntryState extends State<TextFormFieldEntry> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        controller: widget.controller,
        maxLines: 5,
        minLines: 2,
        maxLength: widget.maxLength,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          counterText: widget.counterText,
          focusedBorder: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: TextStyle(fontSize: 13, color: Colors.white),
          counterStyle: TextStyle(fontSize: 13, color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(widget.radius),
            ),
            borderSide:
                BorderSide(color: Theme.of(context).accentColor, width: 1),
          ),
        ),
        keyboardType: widget.textInputType,
      ),
    );
  }
}
