import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';

import 'package:whatuoop_cl/color.dart';
import 'package:whatuoop_cl/common/enum/message_enum.dart';
import 'package:whatuoop_cl/feature/chat/widgets/display_message_type.dart';
import 'package:whatuoop_cl/size_config.dart';

class MyMessageCard extends StatelessWidget {
  final String message;
  final String date;
  final MessageEnum type;
  final VoidCallback onLeftSwipe;
  final String repliedText;
  final String username;
  final MessageEnum repliedMessageType;
  final bool isSeen;
  final SizeConfig size;

  const MyMessageCard({
    Key? key,
    required this.message,
    required this.date,
    required this.type,
    required this.onLeftSwipe,
    required this.repliedText,
    required this.username,
    required this.repliedMessageType,
    required this.isSeen,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isReplying = repliedText.isNotEmpty;

    return SwipeTo(
      onLeftSwipe: onLeftSwipe,
      child: Align(
        alignment: Alignment.centerRight,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: size.getProportionateScreenHeight(347),
            minWidth: size.getProportionateScreenHeight(100),
          ),
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            color: messageColor,
            margin: EdgeInsets.symmetric(
                vertical: size.getProportionateScreenHeight(2)),
            child: Stack(
              children: [
                Padding(
                  padding: type == MessageEnum.text
                      ? EdgeInsets.only(
                          left: size.getProportionateScreenWidth(9),
                          right: size.getProportionateScreenWidth(82),
                          top: size.getProportionateScreenHeight(0),
                          bottom: size.getProportionateScreenHeight(10),
                        )
                      : EdgeInsets.only(
                          left: size.getProportionateScreenWidth(7),
                          right: size.getProportionateScreenWidth(7),
                          top: size.getProportionateScreenHeight(0),
                          bottom: size.getProportionateScreenHeight(7),
                        ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isReplying) ...{
                        Column(
                          children: [
                            Text(
                              username,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                                height: size.getProportionateScreenHeight(4)),
                            Container(
                              padding: EdgeInsets.only(
                                left: size.getProportionateScreenWidth(7),
                                right: size.getProportionateScreenWidth(7),
                                bottom: size.getProportionateScreenHeight(7),
                                top: size.getProportionateScreenHeight(7),
                              ),
                              decoration: BoxDecoration(
                                  color: greyColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: DisplayMessageType(
                                message: repliedText,
                                type: repliedMessageType,
                              ),
                            ),
                          ],
                        ),
                      },
                      const SizedBox(height: 8),
                      DisplayMessageType(
                        message: message,
                        type: type,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 4,
                  right: 10,
                  child: Row(
                    children: [
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white60,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        isSeen ? Icons.done_all : Icons.done,
                        size: 20,
                        color: isSeen ? Colors.blue : Colors.white60,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
