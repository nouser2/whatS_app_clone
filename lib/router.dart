import 'package:flutter/material.dart';
import 'package:whatuoop_cl/common/widgets/error_screen.dart';
import 'package:whatuoop_cl/feature/auth/screen/login_screen.dart';
import 'package:whatuoop_cl/feature/auth/screen/otp_screen.dart';
import 'package:whatuoop_cl/feature/auth/screen/user_info_screen.dart';
import 'package:whatuoop_cl/feature/select_contacts/screeens/select_contact_screen.dart';
import 'package:whatuoop_cl/feature/chat/screens/chat_screen_layout.dart';
import 'package:whatuoop_cl/feature/status/screen/confirmStatusScreen.dart';
import 'package:whatuoop_cl/feature/status/screen/status_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) {
          return const LoginScreen();
        },
      );
    case OTPScreen.routeName:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) {
          return OTPScreen(
            verificationId: verificationId,
          );
        },
      );
    case UserInfoScreen.routeName:
      return MaterialPageRoute(
        builder: (context) {
          return const UserInfoScreen();
        },
      );
    case SelectContactsScreen.routeName:
      return MaterialPageRoute(
        builder: (context) {
          return const SelectContactsScreen();
        },
      );
    case ChatScreenLayout.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final name = arguments['name'];
      final uid = arguments['uid'];
      final profile = arguments['profile'];
      return MaterialPageRoute(
        builder: (context) {
          return ChatScreenLayout(
            name: name,
            uid: uid,
            profile: profile,
          );
        },
      );
    case StatusScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final profile = arguments['status'];
      return MaterialPageRoute(
        builder: (context) {
          return StatusScreen(
            status: profile,
          );
        },
      );
    case ConfirmStatusScreen.routeName:
      final arguments = settings.arguments as Map<String, dynamic>;
      final file = arguments['file'];
      return MaterialPageRoute(
        builder: (context) {
          return ConfirmStatusScreen(
            file: file,
          );
        },
      );

    default:
      return MaterialPageRoute(
        builder: (context) {
          return const Scaffold(
            body: ErrorScreen(
              error: 'the screen do not exist',
            ),
          );
        },
      );
  }
}
