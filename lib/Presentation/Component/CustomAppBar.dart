import 'package:flutter/material.dart';
import 'package:light_controller_app/constant/constant.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final Size preferredSize;

  final String firstTitle;
  final String title;

  CustomAppBar(
    this.firstTitle,
    this.title, {
    Key key,
  })  : preferredSize = Size.fromHeight(106),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 63,
      width: 414,
      decoration: BoxDecoration(
        color: kBackgroundColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "$firstTitle",
                      style: kBigTextStyle.copyWith(
                        fontSize: 25,
                      )
                    ),
                    SizedBox(width: 10),
                    Text(
                      "$title",
                      style: kTextStyle.copyWith(
                        fontSize: 22,
                      )
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
