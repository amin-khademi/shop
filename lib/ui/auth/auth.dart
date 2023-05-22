import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_shop_project/data/repo/auth_repository.dart';
import 'package:nike_shop_project/ui/auth/bloc/auth_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController usernameController =
      TextEditingController(text: "test@gmail.com");
  final TextEditingController passWordController =
      TextEditingController(text: "123456");

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    const onbackground = Colors.white;
    return Theme(
      data: themeData.copyWith(
        snackBarTheme: SnackBarThemeData(backgroundColor: themeData.colorScheme.primary),
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
        body: BlocProvider<AuthBloc>(
          create: (context) {
            final bloc = AuthBloc(authRepository);
            bloc.stream.forEach((state) {
              if (state is AuthSuccess) {
                Navigator.of(context).pop();
              } else if (state is AuthError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.exception.msg)));
              }
            });
            bloc.add(AuthStarted());
            return bloc;
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: BlocBuilder<AuthBloc, AuthState>(
              buildWhen: (previous, current) {
                return current is AuthLoading ||
                    current is AuthInitial ||
                    current is AuthError;
              },
              builder: (context, state) {
                return Column(
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
                      state.isLoginMode ? "خوش آمدید" : "ثبت نام ",
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
                      child: TextField(
                        controller: usernameController,
                        keyboardType: TextInputType.emailAddress,
                        decoration:
                            const InputDecoration(label: Text("آدرس ایمیل")),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    _PasswordTextField(
                      onbackground: onbackground,
                      controller: passWordController,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 20,
                      child: ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<AuthBloc>(context).add(
                                AuthButtonClicked(usernameController.text,
                                    passWordController.text));
                          },
                          child: state is AuthLoading
                              ? const CupertinoActivityIndicator()
                              : Text(state.isLoginMode ? "ورود" : "ثبت نام")),
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
                              color: onbackground.withOpacity(0.7),
                              fontSize: 13),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(onTap: (){
                          BlocProvider.of<AuthBloc>(context)
                                .add(AuthModeChangeIsClicked());
                        },
                          child: Text(
                              "ثبت نام",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: themeData.colorScheme.primary,
                                  decoration: TextDecoration.underline),
                            ),
                        ),
                        
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField({
    required this.onbackground,
    required this.controller,
  });

  final Color onbackground;
  final TextEditingController controller;

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
        controller: widget.controller,
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
