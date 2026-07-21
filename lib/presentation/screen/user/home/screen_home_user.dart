/* 
Created by Neloy on 12 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/user/order/order_list/screen_order_list_user.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/user/profile/screen_profile_user.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/user/shop_list/screen_shop_list_user.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_text.dart';

import '../../../../utilities/app_color.dart';

class ScreenHomeUser extends StatefulWidget {
  const ScreenHomeUser({super.key});

  @override
  State<ScreenHomeUser> createState() => _ScreenHomeUserState();
}

class _ScreenHomeUserState extends State<ScreenHomeUser> {
  int currentPageIndex = 0;

  final List<Widget> _pages = [
    ScreenOrderListUser(),
    ScreenShopListUser(),
    ScreenProfileUser(),
  ];

  final List<String> _titles = [
    AppText.orderList,
    AppText.shopList,
    AppText.profile,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[currentPageIndex])),
      body: SafeArea(child: _pages[currentPageIndex]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.list_alt_outlined),
            selectedIcon: Icon(Icons.view_list, color: AppColor.colorPrimary),
            label: "",
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_bag_outlined),
            selectedIcon: Icon(
              Icons.shopping_bag,
              color: AppColor.colorPrimary,
            ),
            label: "",
          ),
          NavigationDestination(
            icon: Icon(Icons.person_2_outlined),
            selectedIcon: Icon(Icons.person, color: AppColor.colorPrimary),
            label: "",
          ),
        ],
      ),
    );
  }
}
