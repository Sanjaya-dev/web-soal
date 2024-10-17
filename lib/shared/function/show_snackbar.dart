import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:html/parser.dart';

removeHtmlTag(String data) {
  final document = parse(data);
  final String parsedString = parse(document.body?.text).documentElement!.text;

  return parsedString;
}

showSnackbar(BuildContext context,
    {required String title, required String desc, Color? customColor}) {
  Flushbar(
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
    duration: const Duration(seconds: 2),
    flushbarPosition: FlushbarPosition.BOTTOM,
    backgroundColor: customColor ?? Theme.of(context).primaryColor,
    message: desc,
    title: title,
  ).show(context);
}
