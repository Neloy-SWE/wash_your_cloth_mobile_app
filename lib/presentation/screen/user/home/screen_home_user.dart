/* 
Created by Neloy on 12 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wash_your_cloth_mobile_app/router/app_router.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_size.dart';

import '../../../../utilities/app_color.dart';
import '../../../../utilities/app_text.dart';
import '../../../screen/notification/bloc/notification_status_bloc.dart';

class ScreenHomeUser extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const ScreenHomeUser({super.key, required this.navigationShell});

  @override
  State<ScreenHomeUser> createState() => _ScreenHomeUserState();
}

class _ScreenHomeUserState extends State<ScreenHomeUser>
    with WidgetsBindingObserver {
  late final NotificationStatusBloc _notificationStatusBloc;

  @override
  void initState() {
    super.initState();
    _notificationStatusBloc = context.read<NotificationStatusBloc>();
    WidgetsBinding.instance.addObserver(this);
    _notificationStatusBloc.add(const NotificationStatusEventStart());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _notificationStatusBloc.add(const NotificationStatusEventStart());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _notificationStatusBloc.add(const NotificationStatusEventStop());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> titles = [
      AppText.orderList,
      AppText.shopList,
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
                  onPressed: () {
                    context.push(AppRouter.screenNotificationList);
                  },
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
