import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatuoop_cl/color.dart';
import 'package:whatuoop_cl/common/utils/utils.dart';
import 'package:whatuoop_cl/feature/auth/controller/auth_controller.dart';
import 'package:whatuoop_cl/feature/select_contacts/screeens/select_contact_screen.dart';
import 'package:whatuoop_cl/feature/chat/widgets/contacts_list.dart';
import 'package:whatuoop_cl/feature/status/screen/confirmStatusScreen.dart';
import 'package:whatuoop_cl/feature/status/screen/statusContactScreen.dart';

class MobileScreenLayout extends ConsumerStatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  ConsumerState<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends ConsumerState<MobileScreenLayout>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late TabController tabBarController;
  late Icon floatingIcon;

  @override
  void initState() {
    super.initState();

    floatingIcon = const Icon(Icons.message);
    WidgetsBinding.instance.addObserver(this);
    tabBarController = TabController(length: 2, vsync: this);
    tabBarController.addListener(() {
      switch (tabBarController.index) {
        case 0:
          setState(() {
            floatingIcon = const Icon(Icons.message);
          });

          break;
        case 1:
          setState(() {
            floatingIcon = const Icon(Icons.camera_alt_outlined);
          });

          break;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    tabBarController.removeListener(() {});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        ref.read(authControllerProvider).setUserState(true);
        break;

      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        ref.read(authControllerProvider).setUserState(true);
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          elevation: 0,
          centerTitle: false,
          title: const Text(
            'whats App',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
              controller: tabBarController,
              indicatorColor: tabColor,
              indicatorWeight: 4,
              labelColor: tabColor,
              unselectedLabelColor: Colors.grey,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
              tabs: const [
                Tab(
                  text: 'CHATS',
                ),
                Tab(
                  text: 'STATUS',
                ),
              ]),
        ),
        body: TabBarView(controller: tabBarController, children: const [
          ContactsList(),
          StatusContactsScreen(),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            switch (tabBarController.index) {
              case 0:
                Navigator.pushNamed(
                  context,
                  SelectContactsScreen.routeName,
                );
                break;
              case 1:
                File? pickedImage = await pickImageFromGallery(context);
                if (pickedImage != null) {
                  // ignore: use_build_context_synchronously
                  Navigator.pushNamed(context, ConfirmStatusScreen.routeName,
                      arguments: {"file": pickedImage});
                }
                break;
              default:
            }
          },
          backgroundColor: tabColor,
          child: floatingIcon,
        ),
      ),
    );
  }
}
