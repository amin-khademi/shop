import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nike_shop_project/ui/home/home.dart';

const int homeIndex = 0;
const int cartIndex = 1;
const int profileIndex = 2;

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int selectedscreenindex = homeIndex;
  final List<int> _history = [];

  GlobalKey<NavigatorState> _homekey = GlobalKey();
  GlobalKey<NavigatorState> _cartkey = GlobalKey();
  GlobalKey<NavigatorState> _profilekey = GlobalKey();

  late final Map = {
    homeIndex: _homekey,
    cartIndex: _cartkey,
    profileIndex: _profilekey,
  };

  Future<bool> _onwillpop() async {
    final NavigatorState currentselectedTabnavigatorstate =
        Map[selectedscreenindex]!.currentState!;
    if (_homekey.currentState!.canPop()) {
      currentselectedTabnavigatorstate.pop();
      return false;
    } else if (_history.isNotEmpty) {
      setState(() {
        selectedscreenindex = _history.last;
        _history.removeLast();
      });
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onwillpop,
      child: Scaffold(
        body: IndexedStack(
          index: selectedscreenindex,
          children: [
            _navigator(_homekey, homeIndex, const HomeScreen()),
            _navigator(
                _cartkey,
                cartIndex,
                const Center(
                  child: Text("cart"),
                )),
            _navigator(
                _profilekey,
                profileIndex,
                const Center(
                  child: Text("profile"),
                ))
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home), label: "خانه"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.cart), label: "سبد خرید"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person), label: "پروفایل")
          ],
          currentIndex: selectedscreenindex,
          onTap: (selectedIndex) {
            setState(() {
              _history.remove(selectedscreenindex);
              _history.add(selectedscreenindex);
              selectedscreenindex = selectedIndex;
            });
          },
        ),
      ),
    );
  }

  Widget _navigator(GlobalKey key, int index, Widget child) {
    return key.currentContext == null && selectedscreenindex != index
        ? Container()
        : Navigator(
            key: key,
            onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => Offstage(
                      offstage: selectedscreenindex != index,
                      child: child,
                    )),
          );
  }
}
