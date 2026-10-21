/* 
Created by Neloy on 12 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/notification/bloc/notification_status_bloc.dart';
import 'package:wash_your_cloth_mobile_app/router/app_router.dart';

import '../../../../utilities/app_color.dart';
import '../../../../utilities/app_size.dart';
import '../../../../utilities/app_text.dart';

class ScreenHomeShop extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const ScreenHomeShop({super.key, required this.navigationShell});

  @override
  State<ScreenHomeShop> createState() => _ScreenHomeShopState();
}

class _ScreenHomeShopState extends State<ScreenHomeShop>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<NotificationStatusBloc>().add(
      const NotificationStatusEventStart(),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<NotificationStatusBloc>().add(
        const NotificationStatusEventStart(),
      );
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    context.read<NotificationStatusBloc>().add(
      const NotificationStatusEventStop(),
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> titles = [
      AppText.orderList,
      AppText.inventory,
      AppText.profile,
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[widget.navigationShell.currentIndex]),
        actions: [
          BlocBuilder<NotificationStatusBloc, NotificationStatusState>(
            builder: (context, state) => Stack(
              children: [
                IconButton(
                  tooltip: AppText.notifications,
                  onPressed: () =>
                      context.push(AppRouter.screenNotificationList),
                  icon: const Icon(Icons.notifications_none),
                ),
                if (state.unreadCount > 0)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: AppColor.colorDanger,
                        shape: BoxShape.circle,
                        border: Border.fromBorderSide(
                          BorderSide(color: Colors.white, width: 1.5),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          AppSize.gapW15,
        ],
      ),
      body: SafeArea(child: widget.navigationShell),
      bottomNavigationBar: NavigationBar(
        selectedIndex: widget.navigationShell.currentIndex,
        onDestinationSelected: (int index) {
          // Stateful navigation handle index switching natively
          widget.navigationShell.goBranch(
            index,
            initialLocation: index == widget.navigationShell.currentIndex,
          );
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.list_alt_outlined),
            selectedIcon: Icon(Icons.view_list, color: AppColor.colorPrimary),
            label: "",
          ),
          NavigationDestination(
            icon: Icon(Icons.inventory_2_outlined),
            selectedIcon: Icon(Icons.inventory, color: AppColor.colorPrimary),
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
