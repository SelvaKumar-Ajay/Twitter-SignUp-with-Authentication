import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';

import '../../../common reusable widgets/export_reusable_widgets.dart';
import '../../../theme/theme.dart';

class TweetView extends ConsumerStatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const TweetView(),
      );
  const TweetView({super.key});

  @override
  ConsumerState<TweetView> createState() => _TweetViewState();
}

class _TweetViewState extends ConsumerState<TweetView> {
  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserDetailsProvider).value;
    debugPrint(currentUser.toString());
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.close,
          size: 30,
        ),
        actions: [
          SmallRoundButton(
            label: textofTweet,
            onTap: () {},
            backroundColor: Pallete.blueColor,
            textColor: Pallete.whiteColor,
          )
        ],
      ),
      // ignore: unnecessary_null_comparison
      body: currentUser == null
          ? const LoaderIndicator()
          : SafeArea(
              child: SingleChildScrollView(
              child: Column(children: [
                Row(
                  children: [
                    const Text("HI"),
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(currentUser.profilePic.toString()),
                    ),
                  ],
                ),
              ]),
            )),
    );
  }
}
