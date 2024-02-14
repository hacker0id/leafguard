import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Theme/colors.dart';
import '../Theme/styling.dart';
import '../screens/onBoardingScreen.dart';

class AppBarr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: secondaryColor.withOpacity(0.85),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(device.height * 0.15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: device.height * 0.07, left: device.width * 0.05),
                child: Text(
                  'LeafGuard',
                  style: kBodyText.copyWith(fontSize: 40, color: Colors.black),
                ),
              ),
              SizedBox(width: device.width * 0.05),
              Text(
                '..',
                style: kBodyText.copyWith(fontSize: 40, color: Colors.black),
              ),
              const Icon(
                FontAwesomeIcons.leaf,
                size: 45,
              ),
            ],
          ),
        ),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(2500),
          bottomLeft: Radius.circular(1200),
        )));
  }
}
