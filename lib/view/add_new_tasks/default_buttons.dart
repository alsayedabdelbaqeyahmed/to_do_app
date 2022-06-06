import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final BoxConstraints? size;

  final Color? textcolors;
  final Color? buttoncolors;
  final Function? press;
  final String? text;
  const DefaultButton({
    Key? key,
    this.size,
    this.text,
    this.buttoncolors,
    this.textcolors,
    this.press,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: press as void Function()?,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        padding: MaterialStateProperty.all(EdgeInsets.zero),
      ),
      child: Container(
        padding: EdgeInsets.zero,
        width: size!.maxWidth,
        height: size!.maxWidth * 0.18,
        decoration: BoxDecoration(
          color: buttoncolors,
        ),
        alignment: Alignment.center,
        child: Text(
          text!,
          style: TextStyle(color: textcolors, fontSize: size!.maxHeight * 0.04),
        ),
      ),
    );
  }
}
