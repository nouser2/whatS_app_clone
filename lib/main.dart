import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatuoop_cl/color.dart';
import 'package:whatuoop_cl/common/widgets/error_screen.dart';
import 'package:whatuoop_cl/common/widgets/loader.dart';
import 'package:whatuoop_cl/feature/auth/controller/auth_controller.dart';
import 'package:whatuoop_cl/feature/landing/screen/landing_screen.dart';
import 'package:whatuoop_cl/firebase_options.dart';
import 'package:whatuoop_cl/router.dart';
import 'package:whatuoop_cl/screens/mobile_screen_layout.dart';
import 'package:whatuoop_cl/size_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'whats app clone',
      onGenerateRoute: (settings) => generateRoute(settings),
      theme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(color: appBarColor),
        backgroundColor: backgroundColor,
      ),
      home: const HomeWidget(),
    );
  }
}

class HomeWidget extends ConsumerWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig().setValues(context);
    return ref.watch(userDataAuthProvider).when(
          data: (user) {
            if (user == null) {
              return LandingPage();
            } else {
              return const MobileScreenLayout();
            }
          },
          error: (error, stackTrace) {
            return ErrorScreen(
              error: error.toString(),
            );
          },
          loading: () => const LoaderWidget(),
        );
  }
}
