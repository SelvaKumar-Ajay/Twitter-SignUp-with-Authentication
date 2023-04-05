import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/theme/palette.dart';

class UIConstants {
  static AppBar appBar() {
    return AppBar(
      title: SvgPicture.asset(
        AssetConstants.twitterLogo,
// ignore: deprecated_member_use
        color: Pallete.blueColor,
        height: 30.0,
      ),
      centerTitle: true,
    );
  }
}
