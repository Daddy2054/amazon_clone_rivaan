import 'package:amazon_clone_rivaan/common/widgets/bottom_bar.dart';
import 'package:amazon_clone_rivaan/constants/global_variables.dart';
import 'package:amazon_clone_rivaan/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone_rivaan/features/auth/services/auth_service.dart';
import 'package:amazon_clone_rivaan/providers/user_provider.dart';
import 'package:amazon_clone_rivaan/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon Clone',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme:
            const ColorScheme.light(primary: GlobalVariables.secondaryColor),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty ?
      const BottomBar()
      :const AuthScreen(),
    );
  }
}
