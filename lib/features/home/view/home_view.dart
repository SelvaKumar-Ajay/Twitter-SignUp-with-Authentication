import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/features/tweets/views/tweet_view.dart';

import '../../../constants/constants.dart';
import '../../../theme/theme.dart';

class HomeView extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const HomeView(),
      );
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _page = 0;

  final appBar = UIConstants.appBar();

  void onChaneIcon(int index) {
    setState(() {
      _page = index;
    });
  }

  void onNewTweet() {
    Navigator.push(context, TweetView.route());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: IndexedStack(index: _page, children: UIConstants.bottomBarPages),
      floatingActionButton: FloatingActionButton(
        onPressed: onNewTweet,
        child: const Icon(
          Icons.add,
          color: Pallete.whiteColor,
          size: 28,
        ),
      ),
      bottomNavigationBar: CupertinoTabBar(
          currentIndex: _page,
          onTap: onChaneIcon,
          backgroundColor: Pallete.backgroundColor,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                _page == 0
                    ? AssetConstants.homeFilledIcon
                    : AssetConstants.homeOutlinedIcon,
                // ignore: deprecated_member_use
                color: Pallete.whiteColor,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AssetConstants.searchIcon,
                // ignore: deprecated_member_use
                color: Pallete.whiteColor,
              ),
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                _page == 2
                    ? AssetConstants.notifFilledIcon
                    : AssetConstants.notifOutlinedIcon,
                // ignore: deprecated_member_use
                color: Pallete.whiteColor,
              ),
            ),
          ]),
    );
  }
}
