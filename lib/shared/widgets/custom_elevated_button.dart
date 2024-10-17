import 'package:edupower_dashboard/shared/font_helper.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    Key? key,
    this.textButton,
    this.bgColor,
    this.borderRadius,
    this.horizontal,
    this.gradient,
    this.leftWidget = const SizedBox(),
    this.rightWidget = const SizedBox(),
    this.miniumSize,
    this.function,
    this.doubleTap,
    this.textStyle,
    this.boxShadow,
    this.vertical,
    this.disabled = false,
    this.isOutline = false,
    this.transparentRipple = false,
    this.toolTip,
  }) : super(key: key);
  final String? textButton;
  final double? vertical;
  final double? horizontal;
  final double? borderRadius;
  final Color? bgColor;
  final LinearGradient? gradient;
  final List<BoxShadow>? boxShadow;
  final Size? miniumSize;
  final Widget? leftWidget;
  final Widget? rightWidget;
  final TextStyle? textStyle;
  final Function()? function;
  final Function()? doubleTap;
  final bool disabled;
  final bool isOutline;
  final String? toolTip;
  final bool? transparentRipple;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: !disabled ? doubleTap ?? () {} : () {},
      child: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: boxShadow,
          gradient: disabled ? null : gradient,
          color: disabled ? Colors.grey.withOpacity(0.8) : null,
          borderRadius: BorderRadius.circular(borderRadius ?? 12),
        ),
        child: Tooltip(
          message: toolTip ?? '',
          child: ElevatedButton(
            onPressed: !disabled ? function ?? () {} : () {},
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.resolveWith(
                (states) {
                  return states.contains(MaterialState.pressed)
                      ? transparentRipple == true
                          ? Colors.transparent
                          : null
                      : Colors.transparent;
                },
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 12),
                  side: isOutline
                      ? BorderSide(
                          color: disabled
                              ? Colors.grey.withOpacity(
                                  0.6) // Specify the outline color here
                              : Colors.purple, // Specify the outline color here
                          width: 2.0, // Adjust the outline width as needed
                        )
                      : BorderSide.none,
                ),
              ),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(
                  vertical: vertical ?? 15,
                  horizontal: horizontal ?? 13,
                ),
              ),
              minimumSize: MaterialStateProperty.all(miniumSize),
              backgroundColor: MaterialStateProperty.all(
                gradient == null ? bgColor : Colors.transparent,
              ),
              shadowColor: MaterialStateProperty.all(Colors.transparent),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                leftWidget!,
                Padding(
                  padding: EdgeInsets.only(
                      left: leftWidget == null ? 0 : 12,
                      right: rightWidget == null ? 0 : 12),
                  child: FittedBox(
                    child: Text(
                      textButton ?? '',
                      style: textStyle ??
                          mainBody4.copyWith(
                            color:
                                disabled ? Colors.white : Colors.grey.shade100,
                            fontWeight:
                                disabled ? FontWeight.w400 : FontWeight.w700,
                          ),
                    ),
                  ),
                ),
                rightWidget!
              ],
            ),
          ),
        ),
      ),
    );
  }
}
