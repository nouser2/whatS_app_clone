import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatuoop_cl/color.dart';
import 'package:whatuoop_cl/common/widgets/loader.dart';
import 'package:whatuoop_cl/feature/status/controller/ststus_controller.dart';
import 'package:whatuoop_cl/feature/status/screen/status_screen.dart';
import 'package:whatuoop_cl/models/status.dart';

class StatusContactsScreen extends ConsumerWidget {
  const StatusContactsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<List<Status>>(
      future: ref.read(statusControllerProvider).getStatus(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoaderWidget();
        }

        print(snapshot.data!.first.whoCanSee);
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            var statusData = snapshot.data![index];
            return Padding(
              padding: const EdgeInsets.only(top: 7),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        StatusScreen.routeName,
                        arguments: {'status': statusData},
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                        title: Text(
                          statusData.username,
                        ),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            statusData.profilePic,
                          ),
                          radius: 30,
                        ),
                      ),
                    ),
                  ),
                  const Divider(color: dividerColor, indent: 85),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
