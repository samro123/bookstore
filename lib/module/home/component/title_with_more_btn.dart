import 'package:appbook/shared/constants.dart';
import 'package:flutter/material.dart';
class TitleWithMoreBtn extends StatelessWidget {
  final String title;
  final Function() press;
  const TitleWithMoreBtn({
    super.key,
    required this.title,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
        ),
        onPressed: press,
        child: Text(title)
    );
  }
}