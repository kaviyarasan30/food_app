import 'package:app/pages/order/order_page.dart';
import 'package:flutter/material.dart';
import 'package:app/colors/colors.dart';
import 'package:app/pages/account/account_page.dart';
//import 'package:food_app/pages/auth/sign_up_page.dart';
import 'package:app/pages/cart/cart_history.dart';
import 'package:app/pages/home/main_food_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List pages = [const MainFoodPage(), const OrderPage(), const CartHistory(), const AccountPage()];

  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColors.mainColor,
          unselectedItemColor: Colors.amberAccent,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedFontSize: 0.0,
          unselectedFontSize: 0.0,
          currentIndex: _selectedIndex,
          onTap: onTapNav,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.archive),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'me',
            ),
          ]),
    );
  }
}
