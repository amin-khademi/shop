import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    const onbackground = Colors.white;
    return Theme(
      data: themeData.copyWith(
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size.fromHeight(56)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
                  backgroundColor: MaterialStateProperty.all(onbackground),
                  foregroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.secondary))),
          colorScheme: themeData.colorScheme.copyWith(onSurface: Colors.white),
          inputDecorationTheme: InputDecorationTheme(
              labelStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12)))),
      child: Scaffold(
        backgroundColor: themeData.colorScheme.secondary,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/img/nike_logo.png",
                width: 100,
                color: Colors.white,
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                isLogin ? "خوش آمدید" : "ثبت نام ",
                style: TextStyle(fontSize: 22, color: onbackground),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "لطفا وارد حساب کاربری خود شوید",
                style: TextStyle(color: onbackground, fontSize: 14),
              ),
              SizedBox(
                height: 24,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 16,
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(label: Text("آدرس ایمیل")),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              _PasswordTextField(onbackground: onbackground),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
                child: ElevatedButton(
                    onPressed: () {},
                    child: Text(isLogin ? "ورود" : "ثبت نام")),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "حساب کاربری ندارید ؟ ",
                    style: TextStyle(
                        color: onbackground.withOpacity(0.7), fontSize: 13),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: Text(
                      "ثبت نام",
                      style: TextStyle(
                          fontSize: 13,
                          color: themeData.colorScheme.primary,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField({
    super.key,
    required this.onbackground,
  });

  final Color onbackground;

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool _obscure = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 16,
      child: TextField(
        keyboardType: TextInputType.visiblePassword,
        obscureText: _obscure,
        decoration: InputDecoration(
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _obscure = !_obscure;
                  });
                },
                icon: Icon(
                  _obscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: widget.onbackground.withOpacity(0.6),
                )),
            label: const Text("رمز عبور")),
      ),
    );
  }
}