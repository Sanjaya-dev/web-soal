import 'package:edupower_dashboard/app/home/models/drawer_menu_model.dart';
import 'package:edupower_dashboard/app/home/widgets/drawer_menu_widget.dart';
import 'package:edupower_dashboard/shared/font_helper.dart';
import 'package:edupower_dashboard/shared/size_helper.dart';
import 'package:flutter/material.dart';

class DrawerNestedMenuWidget extends StatelessWidget {
  final DrawerMenuModel menuData;
  final List<DrawerMenuModel> subMenu;
  final bool initialExpansion;
  const DrawerNestedMenuWidget(
      {super.key,
      required this.menuData,
      required this.subMenu,
      this.initialExpansion = false});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: initialExpansion,
        tilePadding: EdgeInsets.only(left: margin24 / 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Row(
          children: [
            menuData.iconData == null
                ? Container()
                : Icon(
                    menuData.iconData!,
                    size: 20,
                    color: const Color(0xff757575),
                  ),
            SizedBox(
              width: margin24 / 2,
            ),
            Text(menuData.name,
                style: mainFont.copyWith(
                    fontSize: 14,
                    color: const Color(0xff757575),
                    fontWeight: FontWeight.normal))
          ],
        ),
        children: [
          Container(
            margin: EdgeInsets.only(left: margin16),
            width: double.infinity,
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 23),
                    child: Container(
                      width: 2,
                      height: double.infinity,
                      decoration: BoxDecoration(
                          color: const Color(0xffdddddd),
                          borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: List.generate(subMenu.length, (index) {
                        return Container(
                          margin: EdgeInsets.only(
                              bottom: 4, top: index == 0 ? 4 : 0),
                          child: Row(
                            children: [
                              Container(
                                width: 13,
                                height: 2,
                                color: const Color(0xffdddddd),
                              ),
                              Expanded(
                                child: DrawerMenuWidget(
                                  isActive: subMenu[index].isActive,
                                  data: subMenu[index],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
