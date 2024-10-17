import 'package:edupower_dashboard/app/home/models/drawer_menu_model.dart';
import 'package:edupower_dashboard/shared/font_helper.dart';
import 'package:edupower_dashboard/shared/size_helper.dart';
import 'package:flutter/material.dart';

class DrawerMenuWidget extends StatelessWidget {
  final DrawerMenuModel data;
  final Color? customColor;
  final bool isActive;
  const DrawerMenuWidget(
      {super.key, required this.data, this.customColor, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        data.onTap();
        Navigator.pop(context);
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color:
                isActive ? Theme.of(context).primaryColor : Colors.transparent),
        child: Row(
          children: [
            data.iconData == null
                ? Container()
                : Icon(data.iconData,
                    size: 20,
                    color: customColor ??
                        (isActive ? Colors.white : const Color(0xff757575))),
            SizedBox(
              width: margin24 / 2,
            ),
            Text(
              data.name,
              style: mainFont.copyWith(
                  fontSize: 14,
                  color: customColor ??
                      (isActive ? Colors.white : const Color(0xff757575))),
            )
          ],
        ),
      ),
    );
  }
}
