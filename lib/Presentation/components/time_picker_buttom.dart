import 'package:flutter/material.dart';
import 'package:light_controller_app/constant/constant.dart';

class TimePickerButton extends StatelessWidget {
  final title;
  final text;
  final Function press;
  final Color color, textColor;
  const TimePickerButton({
    Key key,
    this.title,
    this.text,
    this.press,
    this.color = kBaseColor,
    this.textColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Container(
        color: kBaseColor,
        width: size.width * 0.4,
        height: size.width * 0.15,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
              ),
              Text(
                text,
                style: kTextTimeStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
