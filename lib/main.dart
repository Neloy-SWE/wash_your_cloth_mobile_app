/*
Created by Neloy on 18 May, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wash_your_cloth_mobile_app/data/network/api_call/notification/api_get_notification_list.dart';
import 'package:wash_your_cloth_mobile_app/data/repository/repository_notification.dart';
import 'package:wash_your_cloth_mobile_app/presentation/custom_widget/custom_snack_bar.dart';
import 'package:wash_your_cloth_mobile_app/presentation/screen/notification/bloc/notification_status_bloc.dart';

import 'data/client/client.dart';
import 'data/client/auth_session_expiry_notifier.dart';
import 'data/local/local_storage_service.dart';
import 'data/network/api_call/authentication/api_change_password.dart';
import 'data/network/api_call/authentication/api_change_phone.dart';
import 'data/network/api_call/authentication/api_login.dart';
import 'data/network/api_call/authentication/api_logout.dart';
import 'data/network/api_call/authentication/api_otp_verify.dart';
import 'data/network/api_call/authentication/api_refresh_token.dart';
import 'data/network/api_call/authentication/api_registration.dart';
import 'data/network/api_call/notification/api_get_notification_unread_count.dart';
import 'data/network/api_call/notification/api_notification_mark_read.dart';
import 'data/network/api_call/order/shop/api_get_order_details_shop.dart';
import 'data/network/api_call/order/user/api_get_order_details_user.dart';
import 'data/network/api_call/order/api_get_order_list.dart';
import 'data/network/api_call/order/api_update_order_status.dart';
import 'data/network/api_call/order/user/api_place_order.dart';
import 'data/network/api_call/profile/shop/api_profile_update_shop.dart';
import 'data/network/api_call/profile/shop/api_profile_view_shop.dart';
import 'data/network/api_call/profile/user/api_profile_update_user.dart';
import 'data/network/api_call/profile/user/api_profile_view_user.dart';
import 'data/network/api_call/resource/shop/item/api_get_item_list.dart';
import 'data/network/api_call/resource/shop/item/api_item_activation.dart';
import 'data/network/api_call/resource/shop/item/api_item_add.dart';
import 'data/network/api_call/resource/shop/item/api_item_update.dart';
import 'data/network/api_call/resource/shop/price/api_get_price_list_shop.dart';
import 'data/network/api_call/resource/shop/price/api_price_activation.dart';
import 'data/network/api_call/resource/shop/price/api_price_add.dart';
import 'data/network/api_call/resource/shop/price/api_price_update.dart';
import 'data/network/api_call/resource/shop/service/api_get_service_list.dart';
import 'data/network/api_call/resource/shop/service/api_service_activation.dart';
import 'data/network/api_call/resource/shop/service/api_service_add.dart';
import 'data/network/api_call/resource/shop/service/api_service_update.dart';
import 'data/network/api_call/resource/user/api_get_price_list_user.dart';
import 'data/network/api_call/shop/api_get_shop_list.dart';
import 'data/network/api_call/shop/user/api_get_shop_details_user.dart';
import 'data/repository/repository_authentication.dart';
import 'data/repository/repository_order.dart';
import 'data/repository/repository_profile.dart';
import 'data/repository/repository_shop.dart';
import 'data/repository/repository_shop_inventory.dart';
import 'presentation/bloc_global/global_bloc.dart';
import 'presentation/screen/shop/order/order_list/bloc/order_list_shop_bloc.dart';
import 'presentation/screen/authentication/logout/bloc/logout_bloc.dart';
import 'presentation/screen/user/order/order_list/bloc/order_list_user_bloc.dart';
import 'router/app_router.dart';
import 'utilities/app_text.dart';
import 'utilities/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthSessionExpiryNotifier>(
            create: (context) => AuthSessionExpiryNotifier(),
            dispose: (notifier) => notifier.dispose(),
          ),

          RepositoryProvider<LocalStorageService>(
            create: (context) => LocalStorageService(),
          ),

          RepositoryProvider<Client>(
            create: (context) => Client(
              localStorageService: context.read<LocalStorageService>(),
              authSessionExpiryNotifier: context
                  .read<AuthSessionExpiryNotifier>(),
            ),
          ),

          RepositoryProvider<IApiRefreshToken>(
            create: (context) =>
                ApiRefreshToken(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiLogin>(
            create: (context) => ApiLogin(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiLogout>(
            create: (context) => ApiLogout(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiRegistration>(
            create: (context) =>
                ApiRegistration(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiOTPVerify>(
            create: (context) => ApiOTPVerify(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiGetOrderList>(
            create: (context) =>
                ApiGetOrderList(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiGetOrderDetailsUser>(
            create: (context) =>
                ApiGetOrderDetailsUser(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiGetOrderDetailsShop>(
            create: (context) =>
                ApiGetOrderDetailsShop(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiGetShopList>(
            create: (context) => ApiGetShopList(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiGetShopDetailsUser>(
            create: (context) =>
                ApiGetShopDetailsUser(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiGetPriceListUser>(
            create: (context) =>
                ApiGetPriceListUser(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiPlaceOrder>(
            create: (context) => ApiPlaceOrder(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiOrderStatusUpdate>(
            create: (context) =>
                ApiOrderStatusUpdate(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiProfileViewUser>(
            create: (context) =>
                ApiProfileViewUser(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiProfileUpdateUser>(
            create: (context) =>
                ApiProfileUpdateUser(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiChangePassword>(
            create: (context) =>
                ApiChangePassword(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiChangePhone>(
            create: (context) => ApiChangePhone(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiProfileViewShop>(
            create: (context) =>
                ApiProfileViewShop(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiProfileUpdateShop>(
            create: (context) =>
                ApiProfileUpdateShop(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiGetPriceListShop>(
            create: (context) =>
                ApiGetPriceListShop(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiPriceActivation>(
            create: (context) =>
                ApiPriceActivation(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiPriceUpdate>(
            create: (context) => ApiPriceUpdate(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiGetServiceList>(
            create: (context) =>
                ApiGetServiceList(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiServiceActivation>(
            create: (context) =>
                ApiServiceActivation(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiServiceUpdate>(
            create: (context) =>
                ApiServiceUpdate(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiServiceAdd>(
            create: (context) => ApiServiceAdd(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiGetItemList>(
            create: (context) => ApiGetItemList(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiItemActivation>(
            create: (context) =>
                ApiItemActivation(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiItemUpdate>(
            create: (context) => ApiItemUpdate(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiItemAdd>(
            create: (context) => ApiItemAdd(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiPriceAdd>(
            create: (context) => ApiPriceAdd(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiGetNotificationList>(
            create: (context) =>
                ApiGetNotificationList(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiGetNotificationUnreadCount>(
            create: (context) =>
                ApiGetNotificationUnreadCount(client: context.read<Client>()),
          ),

          RepositoryProvider<IApiNotificationMarkRead>(
            create: (context) =>
                ApiNotificationMarkRead(client: context.read<Client>()),
          ),

          RepositoryProvider<IRepositoryAuthentication>(
            create: (context) => RepositoryAuthentication(
              localStorageService: context.read<LocalStorageService>(),
              apiRefreshToken: context.read<IApiRefreshToken>(),
              apiLogin: context.read<IApiLogin>(),
              apiLogout: context.read<IApiLogout>(),
              apiRegistration: context.read<IApiRegistration>(),
              apiOTPVerify: context.read<IApiOTPVerify>(),
              apiChangePassword: context.read<IApiChangePassword>(),
              apiChangePhone: context.read<IApiChangePhone>(),
            ),
          ),

          RepositoryProvider<IRepositoryOrder>(
            create: (context) => RepositoryOrder(
              apiGetOrderList: context.read<IApiGetOrderList>(),
              apiGetOrderDetailsUser: context.read<IApiGetOrderDetailsUser>(),
              apiPlaceOrder: context.read<IApiPlaceOrder>(),
              apiGetOrderDetailsShop: context.read<IApiGetOrderDetailsShop>(),
              apiUpdateOrderStatus: context.read<IApiOrderStatusUpdate>(),
            ),
          ),

          RepositoryProvider<IRepositoryShop>(
            create: (context) => RepositoryShop(
              apiGetShopList: context.read<IApiGetShopList>(),
              apiGetShopDetailsUser: context.read<IApiGetShopDetailsUser>(),
              apiGetPriceListUser: context.read<IApiGetPriceListUser>(),
            ),
          ),

          RepositoryProvider<IRepositoryProfile>(
            create: (context) => RepositoryProfile(
              apiProfileViewUser: context.read<IApiProfileViewUser>(),
              apiProfileViewShop: context.read<IApiProfileViewShop>(),
              apiProfileUpdateUser: context.read<IApiProfileUpdateUser>(),
              apiProfileUpdateShop: context.read<IApiProfileUpdateShop>(),
            ),
          ),

          RepositoryProvider<IRepositoryShopInventory>(
            create: (context) => RepositoryShopInventory(
              apiGetPriceListShop: context.read<IApiGetPriceListShop>(),
              apiPriceActivation: context.read<IApiPriceActivation>(),
              apiPriceUpdate: context.read<IApiPriceUpdate>(),
              apiGetServiceList: context.read<IApiGetServiceList>(),
              apiServiceActivation: context.read<IApiServiceActivation>(),
              apiServiceUpdate: context.read<IApiServiceUpdate>(),
              apiServiceAdd: context.read<IApiServiceAdd>(),
              apiGetItemList: context.read<IApiGetItemList>(),
              apiItemActivation: context.read<IApiItemActivation>(),
              apiItemUpdate: context.read<IApiItemUpdate>(),
              apiItemAdd: context.read<IApiItemAdd>(),
              apiPriceAdd: context.read<IApiPriceAdd>(),
            ),
          ),

          RepositoryProvider<IRepositoryNotification>(
            create: (context) => RepositoryNotification(
              apiGetNotificationList: context.read<IApiGetNotificationList>(),
              apiNotificationMarkRead: context.read<IApiNotificationMarkRead>(),
              apiGetNotificationUnreadCount: context
                  .read<IApiGetNotificationUnreadCount>(),
            ),
          ),

          // RepositoryProvider<AppRouter>(create: (context) => AppRouter()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<GlobalBloc>(
              create: (context) => GlobalBloc(
                repositoryAuthentication: context
                    .read<IRepositoryAuthentication>(),
                authSessionExpiryNotifier: context
                    .read<AuthSessionExpiryNotifier>(),
              )..add(GlobalEventGetLoginStatus()),
            ),
            BlocProvider<LogoutBloc>(
              create: (context) => LogoutBloc(
                repositoryAuthentication: context
                    .read<IRepositoryAuthentication>(),
              ),
            ),

            BlocProvider<OrderListUserBloc>(
              create: (context) => OrderListUserBloc(
                repositoryOrder: context.read<IRepositoryOrder>(),
              )..add(OrderListUserEventFetch()),
            ),
            BlocProvider<OrderListShopBloc>(
              create: (context) => OrderListShopBloc(
                repositoryOrder: context.read<IRepositoryOrder>(),
              )..add(OrderListShopEventFetch()),
            ),
            BlocProvider<NotificationStatusBloc>(
              create: (context) => NotificationStatusBloc(
                repositoryNotification: context.read<IRepositoryNotification>(),
                localStorageService: context.read<LocalStorageService>(),
                authSessionExpiryNotifier: context
                    .read<AuthSessionExpiryNotifier>(),
              ),
            ),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: AppRouter.door,
            theme: AppTheme.get,
            title: AppText.appTitle,
            builder: (context, child) {
              return BlocListener<GlobalBloc, GlobalState>(
                listenWhen: (previous, current) =>
                    !previous.sessionExpired && current.sessionExpired,
                listener: (context, state) {
                  context.read<NotificationStatusBloc>().add(
                    const NotificationStatusEventStop(),
                  );
                  if (!state.deferRedirectUntilResultDismissed) {
                    AppRouter.door.go(AppRouter.screenRole);
                    CustomSnackBar.primary(
                      context: context,
                      contentText: AppText.sessionExpireMessage,
                    );
                  }
                },
                child: MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(textScaler: TextScaler.noScaling),
                  child: child!,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
