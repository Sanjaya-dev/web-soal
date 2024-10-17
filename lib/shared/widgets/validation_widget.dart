import 'package:edupower_dashboard/shared/font_helper.dart';
import 'package:edupower_dashboard/shared/size_helper.dart';
import 'package:flutter/material.dart';

class ValidationWidget extends StatelessWidget {
  final String? validation;
  final Widget child;
  const ValidationWidget({super.key, this.validation, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        child,
        validation == null
            ? const SizedBox()
            : Container(
                margin: EdgeInsets.only(top: margin8),
                child: Text(
                  validation!,
                  style: mainBody4.copyWith(color: Colors.red),
                ),
              ),
      ],
    );
  }
}
