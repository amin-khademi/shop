import 'package:flutter/material.dart';
import 'package:nike_shop_project/data/repo/auth_repository.dart';

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
                  minimumSize:
                      MaterialStateProperty.all(const Size.fromHeight(56)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
                  backgroundColor: MaterialStateProperty.all(onbackground),
                  foregroundColor: MaterialStateProperty.all(
                      Theme.of(context).colorScheme.secondary))),
          colorScheme: themeData.colorScheme.copyWith(onSurface: Colors.white),
          inputDecorationTheme: InputDecorationTheme(
              labelStyle: const TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
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
              const SizedBox(
                height: 24,
              ),
              Text(
                isLogin ? "خوش آمدید" : "ثبت نام ",
                style: const TextStyle(fontSize: 22, color: onbackground),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "لطفا وارد حساب کاربری خود شوید",
                style: TextStyle(color: onbackground, fontSize: 14),
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 16,
                child: const TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(label: Text("آدرس ایمیل")),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const _PasswordTextField(onbackground: onbackground),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
                child: ElevatedButton(
                    onPressed: () {
                      try {
                        authRepository.login("tesrrt@gmail.com", "12fff3456");
                      } catch (e) {
                        debugPrint(e.toString());
                      }
                    },
                    child: Text(isLogin ? "ورود" : "ثبت نام")),
              ),
              const SizedBox(
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
                  const SizedBox(
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
