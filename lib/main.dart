import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_system/authentication_service.dart';
import 'package:inventory_management_system/routs.dart';
import 'package:provider/provider.dart';

import 'Screens/Home/home_screen.dart';
import 'Screens/sign_in/sign_in_screen.dart';
import 'Screens/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeNotifier()),
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          initialData: null,
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        )
      ],
      builder: (context, child) {
        final themeProvider = Provider.of<ThemeNotifier>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: routes,
          title: 'Flutter Demo',
          themeMode: themeProvider.darkTheme ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          darkTheme: ThemeData.dark(),
          home: AuthenticationWrapper(),
        );
      },
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  static String routeName = "/AuthWrapper";
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      return HomeScreen();
    }
    return SignInScreen();
  }
}
