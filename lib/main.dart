import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nike_shop_project/data/repo/banner_repository.dart';
import 'package:nike_shop_project/theme.dart';
import 'package:nike_shop_project/ui/root.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bannerRepository.getAll().then((value) {
      debugPrint(value.toString());
    }).catchError((onError) {
      debugPrint(onError.toString());
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [Locale('fa')],
      title: 'Nike Shop',
      theme: AppTheme.lightTheme,
      home: const RootScreen(),
    );
  }
}
