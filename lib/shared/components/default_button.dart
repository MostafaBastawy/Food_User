import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  Function onPressed;
  String labelText;
  Color color;
  DefaultButton(
      {Key? key,
      required this.onPressed,
      required this.labelText,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: MaterialButton(
        onPressed: () {
          onPressed();
        },
        child: Text(
          labelText,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
