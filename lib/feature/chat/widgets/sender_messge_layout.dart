import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';

import 'package:whatuoop_cl/color.dart';
import 'package:whatuoop_cl/common/enum/message_enum.dart';
import 'package:whatuoop_cl/feature/chat/widgets/display_message_type.dart';
import 'package:whatuoop_cl/size_config.dart';

class SenderMessageCard extends StatelessWidget {
  const SenderMessageCard({
    Key? key,
    required this.size,
    required this.message,
    required this.date,
    required this.type,
    required this.onRightSwipe,
    required this.repliedText,
    required this.username,
    required this.repliedMessageType,
  }) : super(key: key);
  final SizeConfig size;
  final String message;
  final String date;
  final MessageEnum type;
  final VoidCallback onRightSwipe;
  final String repliedText;
  final String username;
  final MessageEnum repliedMessageType;

  @override
  Widget build(BuildContext context) {
    final isReplying = repliedText.isNotEmpty;

    return SwipeTo(
      onLeftSwipe: onRightSwipe,
      child: Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 45,
          ),
          child: Card(
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: senderMessageColor,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Stack(
              children: [
                Padding(
                  padding: type == MessageEnum.text
                      ? EdgeInsets.only(
                          left: size.getProportionateScreenWidth(9),
                          right: size.getProportionateScreenWidth(40),
                          top: size.getProportionateScreenHeight(0),
                          bottom: size.getProportionateScreenHeight(6),
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
                      if (isReplying) ...[
                        Text(
                          username,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Container(
                          padding: EdgeInsets.only(
                            left: size.getProportionateScreenWidth(7),
                            right: size.getProportionateScreenWidth(7),
                            top: size.getProportionateScreenHeight(7),
                            bottom: size.getProportionateScreenHeight(7),
                          ),
                          decoration: BoxDecoration(
                            color: backgroundColor.withOpacity(0.5),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                5,
                              ),
                            ),
                          ),
                          child: DisplayMessageType(
                            message: repliedText,
                            type: repliedMessageType,
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                      DisplayMessageType(
                        message: message,
                        type: type,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 2,
                  right: 10,
                  child: Text(
                    date,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
