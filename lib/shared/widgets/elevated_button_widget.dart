import 'package:edupower_dashboard/shared/font_helper.dart';
import 'package:edupower_dashboard/shared/size_helper.dart';
import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final bool enabled;
  final Function() onTap;
  final bool isLoading;
  final String title;
  final Color? customColor;
  final double? customTextSize;
  final EdgeInsetsGeometry? customPadding;

  const ElevatedButtonWidget(
      {super.key,
      this.enabled = true,
      this.customColor,
      required this.onTap,
      this.isLoading = false,
      this.title = '',
      this.customTextSize,
      this.customPadding});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            backgroundColor: isLoading
                ? Colors.grey
                : customColor ?? Theme.of(context).primaryColor),
        onPressed: enabled ? onTap : null,
        child: Container(
          width: double.infinity,
          padding:
              customPadding ?? EdgeInsets.symmetric(vertical: margin24 / 2),
          child: Center(
            heightFactor: 1,
            child: Text(title,
                style: mainFont.copyWith(
                    fontSize: customTextSize ?? 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
          ),
        ));
  }
}
