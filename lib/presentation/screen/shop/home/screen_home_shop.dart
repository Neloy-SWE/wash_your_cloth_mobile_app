/* 
Created by Neloy on 12 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../utilities/app_color.dart';
import '../../../../utilities/app_text.dart';

class ScreenHomeShop extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const ScreenHomeShop({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final List<String> titles = [
      AppText.orderList,
      AppText.profile,
    ];
    return Scaffold(
      appBar: AppBar(title: Text(titles[navigationShell.currentIndex])),
      body: SafeArea(child: navigationShell),
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (int index) {
          // Stateful navigation handle index switching natively
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.list_alt_outlined),
            selectedIcon: Icon(Icons.view_list, color: AppColor.colorPrimary),
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
