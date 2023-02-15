import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatuoop_cl/color.dart';
import 'package:whatuoop_cl/feature/auth/controller/auth_controller.dart';
import 'package:whatuoop_cl/feature/chat/widgets/bottom_chat_fireld.dart';
import 'package:whatuoop_cl/feature/chat/widgets/chat_list.dart';
import 'package:whatuoop_cl/models/user_model.dart';
import 'package:whatuoop_cl/size_config.dart';

class ChatScreenLayout extends ConsumerWidget {
  const ChatScreenLayout({
    Key? key,
    required this.name,
    required this.uid,
    required this.profile,
  }) : super(key: key);
  final String name;
  final String uid;
  final String profile;

  static const routeName = '/chat_screen';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig size = SizeConfig();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: size.getProportionateScreenHeight(71),
          backgroundColor: appBarColor,
          title: StreamBuilder<UserModel>(
              stream: ref.read(authControllerProvider).userDataById(uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                } else {
                  return Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: appBarColor,
                        radius: size.getProportionateScreenWidth(24),
                        backgroundImage: NetworkImage(profile),
                      ),
                      SizedBox(
                        width: size.getProportionateScreenWidth(14),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: size.getProportionateScreenHeight(11),
                          ),
                          Text(
                            name,
                          ),
                          SizedBox(
                            height: size.getProportionateScreenHeight(9),
                          ),
                          Text(
                            snapshot.data!.isOnline ? 'Online' : 'offline',
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    ],
                  );
                }
              }),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.video_call),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.call),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ],
          centerTitle: false,
        ),
        body: Column(
          children: [
            Expanded(
              child: ChatList(uid),
            ),
            BottomChatField(
              size: size,
              recieverUserId: uid,
            )
          ],
        ),
      ),
    );
  }
}
