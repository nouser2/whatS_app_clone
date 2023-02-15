import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatuoop_cl/common/widgets/error_screen.dart';
import 'package:whatuoop_cl/common/widgets/loader.dart';
import 'package:whatuoop_cl/feature/select_contacts/controller/select_contacts_controller.dart';
import 'package:whatuoop_cl/feature/select_contacts/repository/select_contacts_repository.dart';

class SelectContactsScreen extends ConsumerWidget {
  static const routeName = '/select_contact_screen';

  const SelectContactsScreen({super.key});

  void selectContact(
      WidgetRef ref, Contact selectedContact, BuildContext context) {
    ref
        .read(selectContactsRepositoryProvider)
        .selectContact(selectedContact, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select contact'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),
      body: ref.watch(getContactsProvider).when(
            data: (contacts) {
              return ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return InkWell(
                    onTap: () => selectContact(
                      ref,
                      contact,
                      context,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(
                          contact.displayName,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        leading: contact.photo == null
                            ? null
                            : CircleAvatar(
                                backgroundImage: MemoryImage(contact.photo!),
                                radius: 30,
                              ),
                      ),
                    ),
                  );
                },
              );
            },
            error: (error, stackTrace) => ErrorScreen(error: error.toString()),
            loading: () => const LoaderWidget(),
          ),
    );
  }
}
