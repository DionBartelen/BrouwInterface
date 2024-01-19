import 'package:flutter/material.dart';

class CustomWidgetRow extends StatelessWidget {
  const CustomWidgetRow({
    super.key,
    required this.title,
    required this.widget,
  });

  final String title;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
          ),
          widget,
        ],
      ),
    );
  }
}
