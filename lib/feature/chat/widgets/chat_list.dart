import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whatuoop_cl/common/enum/message_enum.dart';
import 'package:whatuoop_cl/common/provider/message_reply_provider.dart';
import 'package:whatuoop_cl/common/widgets/loader.dart';
import 'package:whatuoop_cl/feature/chat/controller/chat_controller.dart';
import 'package:whatuoop_cl/feature/chat/widgets/my_message_card.dart';
import 'package:whatuoop_cl/feature/chat/widgets/sender_messge_layout.dart';
import 'package:whatuoop_cl/models/message.dart';
import 'package:whatuoop_cl/size_config.dart';

class ChatList extends ConsumerStatefulWidget {
  final String recieverUserId;

  const ChatList(this.recieverUserId, {Key? key}) : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  final ScrollController messageController = ScrollController();
  SizeConfig size = SizeConfig();
  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void onMessageSwipe({
    required String message,
    required bool isMe,
    required MessageEnum messageEnum,
  }) {
    ref
        .read(messageReplyProvider.notifier)
        .update((state) => MessageReply(message, isMe, messageEnum));
  }

  @override
  Widget build(BuildContext context) {
    final String recieverUserId = widget.recieverUserId;
    return StreamBuilder<List<Message>>(
        stream: ref.read(chatControllerProvider).chatStream(recieverUserId),
        builder: (context, snpshot) {
          if (snpshot.connectionState == ConnectionState.waiting) {
            return const LoaderWidget();
          }
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            messageController
                .jumpTo(messageController.position.maxScrollExtent);
          });
          return ListView.builder(
            itemCount: snpshot.data!.length,
            controller: messageController,
            itemBuilder: (context, index) {
              final messageData = snpshot.data![index];
              var date = DateFormat.Hm().format(messageData.timeSent);
              if (!messageData.isSeen &&
                  (messageData.recieverid ==
                      FirebaseAuth.instance.currentUser!.uid)) {
                ref.read(chatControllerProvider).setChatMessageSeen(
                    context, recieverUserId, messageData.messageId);
              }
              if (messageData.senderId ==
                  FirebaseAuth.instance.currentUser!.uid) {
                return MyMessageCard(
                  size: size,
                  type: messageData.type,
                  message: messageData.text,
                  date: date,
                  repliedText: messageData.repliedMessage,
                  repliedMessageType: messageData.repliedMessageType,
                  isSeen: messageData.isSeen,
                  username: messageData.repliedTo,
                  onLeftSwipe: () => onMessageSwipe(
                    message: messageData.text,
                    isMe: true,
                    messageEnum: messageData.type,
                  ),
                );
              }
              return SenderMessageCard(
                size: size,
                message: messageData.text,
                date: date,
                type: messageData.type,
                onRightSwipe: () => onMessageSwipe(
                  message: messageData.text,
                  isMe: true,
                  messageEnum: messageData.type,
                ),
                repliedMessageType: messageData.repliedMessageType,
                repliedText: messageData.text,
                username: messageData.repliedTo,
              );
            },
          );
        });
  }
}
