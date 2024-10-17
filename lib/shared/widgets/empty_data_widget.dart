import 'package:edupower_dashboard/shared/const_helper.dart';
import 'package:edupower_dashboard/shared/font_helper.dart';
import 'package:flutter/material.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 250,
          height: 250,
          child: Image.asset(ConstHelper.emptyDataIllustration),
        ),
        Text(
          'Data Kosong',
          style: mainFont.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          'Belum ada data yang dapat ditampilkan',
          style: mainFont.copyWith(fontSize: 12, color: Colors.black54),
        )
      ],
    );
  }
}
