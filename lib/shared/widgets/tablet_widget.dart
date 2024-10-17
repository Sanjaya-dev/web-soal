import 'package:edupower_dashboard/shared/font_helper.dart';
import 'package:edupower_dashboard/shared/size_helper.dart';
import 'package:flutter/material.dart';

class TableContainerWidget extends StatelessWidget {
  final String title;
  final int? customFlex;
  const TableContainerWidget({super.key, required this.title, this.customFlex});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: customFlex ?? 1,
      child: Container(
        height: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: margin40 / 4),
        color: title.toLowerCase().contains('hidden')
            ? Colors.transparent
            : Theme.of(context).primaryColor,
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: mainFont.copyWith(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}

class DataTableWidget extends StatelessWidget {
  final Widget? customData;
  final String data;
  final bool isOddData;
  final bool isRecentlyAdded;
  final int? customFlex;
  final Color? customColor;
  const DataTableWidget(
      {super.key,
      this.customData,
      this.customColor,
      required this.data,
      this.isRecentlyAdded = false,
      this.isOddData = true,
      this.customFlex});

  @override
  Widget build(BuildContext context) {
    final isHidden = data.toLowerCase().contains('hidden');
    return Flexible(
      flex: customFlex ?? 1,
      child: Tooltip(
        message: data,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(
              vertical: margin40 / 4, horizontal: margin24 / 2),
          decoration: BoxDecoration(
              color: customColor ??
                  (isRecentlyAdded
                      ? Colors.green.withOpacity(0.3)
                      : isOddData
                          ? Colors.white
                          : const Color(0xffD9D9D9).withOpacity(0.5)),
              border: Border.all(
                  color:
                      isHidden ? Colors.transparent : const Color(0xffD9D9D9))),
          child: customData ??
              Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  child: Text(
                    data,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: mainFont.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: isRecentlyAdded
                            ? const Color(0xff666666)
                            : isOddData
                                ? const Color(0xff666666)
                                : Theme.of(context).primaryColor),
                  )),
        ),
      ),
    );
  }
}
