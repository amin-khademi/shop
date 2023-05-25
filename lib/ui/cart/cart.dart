import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:nike_shop_project/data/models/auth.dart';
import 'package:nike_shop_project/data/repo/auth_repository.dart';
import 'package:nike_shop_project/data/repo/cart_repository.dart';
import 'package:nike_shop_project/ui/auth/auth.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    cartRepository.getAll().then((value) {
      debugPrint(value.toString());
    }).catchError((e){
      debugPrint(e.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("سبد خرید"),
      ),
      body: ValueListenableBuilder(
        valueListenable: AuthRepository.authChangedNotifier,
        builder: (context, authstate, child) {
          bool isAuthenticated =
              authstate != null && authstate.accessToken.isNotEmpty;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(isAuthenticated
                    ? "خوش آمدید"
                    : "لطفا وارد حساب کاربری خود شوید"),
                isAuthenticated
                    ? ElevatedButton(
                        onPressed: () {
                          authRepository.signOut();
                        },
                        child: const Text("خروج از حساب"))
                    : ElevatedButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                  builder: (context) => const AuthScreen()));
                        },
                        child: const Text("ورود")),
                ElevatedButton(
                    onPressed: () async {
                      await authRepository.refreshToken();
                    },
                    child: const Text("refresh token"))
              ],
            ),
          );
        },
      ),
    );
  }
}
