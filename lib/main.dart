import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nike_shop_project/data/repo/banner_repository.dart';
import 'package:nike_shop_project/theme.dart';
import 'package:nike_shop_project/ui/auth/auth.dart';
import 'package:nike_shop_project/ui/root.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance();
  runApp(MyApp());
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
    const defaultTextStyle = TextStyle(fontFamily: "IranYekan");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa'), // farsi
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
          titleMedium: defaultTextStyle.copyWith(
            fontSize: 14,
            color: LightThemeColor.secondaryTextColor,
          ),
          labelLarge:
              defaultTextStyle.apply(color: LightThemeColor.secondaryTextColor),
          bodyMedium: defaultTextStyle,
          titleLarge: defaultTextStyle.copyWith(
              fontWeight: FontWeight.bold, fontSize: 15),
          bodySmall:
              defaultTextStyle.apply(color: LightThemeColor.secondaryTextColor),
        ),
        colorScheme: const ColorScheme.light(
            primary: LightThemeColor.primaryColor,
            secondary: LightThemeColor.secondaryColor,
            onSecondary: Colors.white),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const RootScreen(),
    );
  }
}
