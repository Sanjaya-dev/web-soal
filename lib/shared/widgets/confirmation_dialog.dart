import 'package:edupower_dashboard/shared/font_helper.dart';
import 'package:edupower_dashboard/shared/size_helper.dart';
import 'package:edupower_dashboard/shared/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

Future<bool> showConfirmationDialog(BuildContext context,
    {String title = '', String desc = ''}) async {
  bool? result = await showDialog(
      context: context,
      builder: (context) {
        return ConfirmationDialogWidget(
          desc: desc,
          title: title,
        );
      });

  return result ?? false;
}

class ConfirmationDialogWidget extends StatelessWidget {
  final String title;
  final String desc;
  const ConfirmationDialogWidget(
      {super.key, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 300,
          padding:
              EdgeInsets.symmetric(vertical: margin16, horizontal: margin16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: mainBody3.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: margin8,
              ),
              Text(desc, textAlign: TextAlign.center, style: mainBody4),
              SizedBox(
                height: margin24,
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: CustomElevatedButton(
                      textButton: 'Tidak',
                      function: () {
                        Navigator.pop(context, false);
                      },
                      bgColor: Colors.orange,
                    ),
                  ),
                  SizedBox(
                    width: margin16,
                  ),
                  Flexible(
                    flex: 1,
                    child: CustomElevatedButton(
                      textButton: 'Ya',
                      function: () {
                        Navigator.pop(context, true);
                      },
                      bgColor: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
