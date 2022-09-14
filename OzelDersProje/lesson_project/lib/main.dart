// ignore_for_file: avoid_print

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lesson_project/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lesson_project/views/screens/homepage.dart';
import 'package:lesson_project/views/screens/login_page.dart';
import 'package:lesson_project/views/screens/offline_screen.dart';
import 'package:lesson_project/views/widgets/theme_data.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print(FirebaseAuth.instance.currentUser);
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('tr')],
      path: 'assets/translations',
      fallbackLocale: const Locale('tr'),
      saveLocale: true,
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);

      return StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, AsyncSnapshot<ConnectivityResult> snapshot) {
          return snapshot.data == ConnectivityResult.mobile ||
                  snapshot.data == ConnectivityResult.wifi
              ? MaterialApp(
                  debugShowCheckedModeBanner: false,
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  title: 'Project Title',
                  theme: ApplicationTheme().applicationThemeData,
                  home: FirebaseAuth.instance.currentUser == null
                      ? loginPage()
                      : homepage(),
                )
              : MaterialApp(
                  title: 'Project Title Offline',
                  theme: ApplicationTheme().applicationThemeData,
                  home: offlineScreen(),
                );
        },
      );

      /*  return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'Flutter Demo',
          theme: ApplicationTheme().applicationThemeData,
          home: FirebaseAuth.instance.currentUser == null
              ? loginPage()
              : homepage());*/
    });
  }
}
