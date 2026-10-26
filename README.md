# Wash Your Cloth Mobile App
Online laundry marketplace that connects customers with local laundry service providers.

## Features
- session based authentication that support multiple devices login.
- order management for both customer and laundry service provider.
- shop inventory management for laundry service provider.

## Tool & Technologies
1. Framework: flutter-3.41.9
2. Programming Language: Dart-3.41.9

## Packages
1. dio: ^5.9.2
2. flutter_bloc: ^9.1.1
3. bloc_concurrency: ^0.3.0
4. equatable: ^2.0.8
5. go_router: ^17.2.3
6. intl: ^0.20.2
7. flutter_secure_storage: ^11.2.0
8. socket_io_client: ^3.1.6

## Installation
1. this mobile app is dependent on the backend: [Wash Your Cloth API](https://github.com/Neloy-SWE/wash_your_cloth_api). make the mobile app fully functional, 1st of all setup backend by following the [instructions](https://github.com/Neloy-SWE/wash_your_cloth_api/blob/main/README.md).

2. make sure you have java 17.0.11 installed in your system. define path at ```android\gradle.properties``` based on your OS.

3. to setup flutter environment, follow the instructions from [flutter official site](https://docs.flutter.dev/install).

4. clone this repository:
    ```bash
    git clone https://github.com/Neloy-SWE/wash_your_cloth_mobile_app.git
    ```

5. navigate to the project directory(root folder):
    ```bash
    cd wash_your_cloth_mobile_app
    ```

6. install dependencies:
    ```bash
    flutter pub get
    ```

7. run the app:
    ```bash
    flutter run
    ```

## Project Structure        
    │   main.dart
    │   
    ├───data
    │   ├───client
    │   │       auth_session_expiry_notifier.dart
    │   │       client.dart
    │   │       client_constant.dart
    │   │       client_interceptor.dart
    │   │       
    │   ├───local
    │   │       local_storage_service.dart
    │   │       
    │   ├───model
    │   │       model_auth_action.dart
    │   │       model_error.dart
    │   │       model_item_activation.dart
    │   │       model_item_add.dart
    │   │       model_item_list.dart
    │   │       model_item_update.dart
    │   │       model_login.dart
    │   │       model_notification_item.dart
    │   │       model_order_details_shop.dart
    │   │       model_order_details_user.dart
    │   │       model_order_list.dart
    │   │       model_order_place.dart
    │   │       model_order_status_update.dart
    │   │       model_otp_request.dart
    │   │       model_paged_list.dart
    │   │       model_price_activation.dart
    │   │       model_price_add.dart
    │   │       model_price_list_shop.dart
    │   │       model_price_list_user.dart
    │   │       model_price_update.dart
    │   │       model_profile_update.dart
    │   │       model_profile_view_shop.dart
    │   │       model_profile_view_user.dart
    │   │       model_service_activation.dart
    │   │       model_service_add.dart
    │   │       model_service_list.dart
    │   │       model_service_update.dart
    │   │       model_shop_details.dart
    │   │       model_shop_list.dart
    │   │       
    │   ├───network
    │   │   │   api_path.dart
    │   │   │   
    │   │   └───api_call
    │   │       ├───authentication
    │   │       │       api_change_password.dart
    │   │       │       api_change_phone.dart
    │   │       │       api_login.dart
    │   │       │       api_logout.dart
    │   │       │       api_otp_verify.dart
    │   │       │       api_refresh_token.dart
    │   │       │       api_registration.dart
    │   │       │       
    │   │       ├───notification
    │   │       │       api_get_notification_list.dart
    │   │       │       api_get_notification_unread_count.dart
    │   │       │       api_notification_mark_read.dart
    │   │       │       
    │   │       ├───order
    │   │       │   │   api_get_order_list.dart
    │   │       │   │   api_update_order_status.dart
    │   │       │   │   
    │   │       │   ├───shop
    │   │       │   │       api_get_order_details_shop.dart
    │   │       │   │       
    │   │       │   └───user
    │   │       │           api_get_order_details_user.dart
    │   │       │           api_place_order.dart
    │   │       │           
    │   │       ├───profile
    │   │       │   ├───shop
    │   │       │   │       api_profile_update_shop.dart
    │   │       │   │       api_profile_view_shop.dart
    │   │       │   │       
    │   │       │   └───user
    │   │       │           api_profile_update_user.dart
    │   │       │           api_profile_view_user.dart
    │   │       │           
    │   │       ├───resource
    │   │       │   ├───shop
    │   │       │   │   ├───item
    │   │       │   │   │       api_get_item_list.dart
    │   │       │   │   │       api_item_activation.dart
    │   │       │   │   │       api_item_add.dart
    │   │       │   │   │       api_item_update.dart
    │   │       │   │   │       
    │   │       │   │   ├───price
    │   │       │   │   │       api_get_price_list_shop.dart
    │   │       │   │   │       api_price_activation.dart
    │   │       │   │   │       api_price_add.dart
    │   │       │   │   │       api_price_update.dart
    │   │       │   │   │       
    │   │       │   │   └───service
    │   │       │   │           api_get_service_list.dart
    │   │       │   │           api_service_activation.dart
    │   │       │   │           api_service_add.dart
    │   │       │   │           api_service_update.dart
    │   │       │   │           
    │   │       │   └───user
    │   │       │           api_get_price_list_user.dart
    │   │       │           
    │   │       └───shop
    │   │           │   api_get_shop_list.dart
    │   │           │   
    │   │           └───user
    │   │                   api_get_shop_details_user.dart
    │   │                   
    │   ├───repository
    │   │       repository_authentication.dart
    │   │       repository_notification.dart
    │   │       repository_order.dart
    │   │       repository_profile.dart
    │   │       repository_shop.dart
    │   │       repository_shop_inventory.dart
    │   │       
    │   ├───request
    │   │       request_change_password.dart
    │   │       request_change_phone.dart
    │   │       request_item.dart
    │   │       request_price_add.dart
    │   │       request_price_update.dart
    │   │       request_profile_update_shop.dart
    │   │       request_profile_update_user.dart
    │   │       request_service.dart
    │   │       
    │   └───use_case
    │       │   use_case_generic.dart
    │       │   
    │       ├───authentication
    │       │       use_case_login.dart
    │       │       use_case_otp_request.dart
    │       │       use_case_otp_verify.dart
    │       │       use_case_registration.dart
    │       │       
    │       └───order
    │               use_case_order_place.dart
    │               
    ├───presentation
    │   ├───bloc_global
    │   │       global_bloc.dart
    │   │       global_event.dart
    │   │       global_state.dart
    │   │       
    │   ├───custom_widget
    │   │       custom_button.dart
    │   │       custom_card.dart
    │   │       custom_details_item.dart
    │   │       custom_dialogue.dart
    │   │       custom_icon_frame.dart
    │   │       custom_list_header.dart
    │   │       custom_not_found.dart
    │   │       custom_order_item_card.dart
    │   │       custom_order_status_actions.dart
    │   │       custom_pagination_footer.dart
    │   │       custom_snack_bar.dart
    │   │       custom_status_badge.dart
    │   │       custom_text_field.dart
    │   │       custom_title.dart
    │   │       custom_titled_divider.dart
    │   │       custom_weekend_selector.dart
    │   │       
    │   └───screen
    │       ├───authentication
    │       │   ├───change_password
    │       │   │   │   screen_change_password.dart
    │       │   │   │   
    │       │   │   └───bloc
    │       │   │           change_password_bloc.dart
    │       │   │           change_password_event.dart
    │       │   │           change_password_state.dart
    │       │   │           
    │       │   ├───change_phone
    │       │   │   │   screen_change_phone.dart
    │       │   │   │   
    │       │   │   └───bloc
    │       │   │           change_phone_bloc.dart
    │       │   │           change_phone_event.dart
    │       │   │           change_phone_state.dart
    │       │   │           
    │       │   ├───login
    │       │   │   │   screen_login.dart
    │       │   │   │   
    │       │   │   └───bloc
    │       │   │           login_bloc.dart
    │       │   │           login_event.dart
    │       │   │           login_state.dart
    │       │   │           
    │       │   ├───logout
    │       │   │   └───bloc
    │       │   │           logout_bloc.dart
    │       │   │           logout_event.dart
    │       │   │           logout_state.dart
    │       │   │           
    │       │   ├───otp
    │       │   │   │   screen_otp.dart
    │       │   │   │   
    │       │   │   └───bloc
    │       │   │           otp_bloc.dart
    │       │   │           otp_event.dart
    │       │   │           otp_state.dart
    │       │   │           
    │       │   └───registration
    │       │       │   screen_registration.dart
    │       │       │   
    │       │       └───bloc
    │       │               registration_bloc.dart
    │       │               registration_event.dart
    │       │               registration_state.dart
    │       │               
    │       ├───notification
    │       │   ├───bloc
    │       │   │       notification_status_bloc.dart
    │       │   │       notification_status_event.dart
    │       │   │       notification_status_state.dart
    │       │   │       
    │       │   └───notification_list
    │       │       │   screen_notification_list.dart
    │       │       │   
    │       │       └───bloc
    │       │               notification_list_bloc.dart
    │       │               notification_list_event.dart
    │       │               notification_list_state.dart
    │       │               
    │       ├───role
    │       │       screen_role.dart
    │       │       
    │       ├───shop
    │       │   ├───home
    │       │   │       screen_home_shop.dart
    │       │   │       
    │       │   ├───inventory
    │       │   │   ├───item
    │       │   │   │   ├───item_add
    │       │   │   │   │   │   screen_item_add.dart
    │       │   │   │   │   │   
    │       │   │   │   │   └───bloc
    │       │   │   │   │           item_add_bloc.dart
    │       │   │   │   │           item_add_event.dart
    │       │   │   │   │           item_add_state.dart
    │       │   │   │   │           
    │       │   │   │   ├───item_list
    │       │   │   │   │   │   screen_item_list.dart
    │       │   │   │   │   │   
    │       │   │   │   │   └───bloc
    │       │   │   │   │           item_list_bloc.dart
    │       │   │   │   │           item_list_event.dart
    │       │   │   │   │           item_list_state.dart
    │       │   │   │   │           
    │       │   │   │   └───item_update
    │       │   │   │       │   screen_item_update.dart
    │       │   │   │       │   
    │       │   │   │       └───bloc
    │       │   │   │               item_update_bloc.dart
    │       │   │   │               item_update_event.dart
    │       │   │   │               item_update_state.dart
    │       │   │   │               
    │       │   │   ├───price
    │       │   │   │   ├───price_add
    │       │   │   │   │   │   screen_price_add.dart
    │       │   │   │   │   │   
    │       │   │   │   │   └───bloc
    │       │   │   │   │           price_add_bloc.dart
    │       │   │   │   │           price_add_event.dart
    │       │   │   │   │           price_add_state.dart
    │       │   │   │   │           
    │       │   │   │   ├───price_list
    │       │   │   │   │   │   screen_price_list.dart
    │       │   │   │   │   │   
    │       │   │   │   │   └───bloc
    │       │   │   │   │           price_list_shop_bloc.dart
    │       │   │   │   │           price_list_shop_event.dart
    │       │   │   │   │           price_list_shop_state.dart
    │       │   │   │   │           
    │       │   │   │   └───price_update
    │       │   │   │       │   screen_price_update.dart
    │       │   │   │       │   
    │       │   │   │       └───bloc
    │       │   │   │               price_update_bloc.dart
    │       │   │   │               price_update_event.dart
    │       │   │   │               price_update_state.dart
    │       │   │   │               
    │       │   │   └───service
    │       │   │       ├───service_add
    │       │   │       │   │   screen_service_add.dart
    │       │   │       │   │   
    │       │   │       │   └───bloc
    │       │   │       │           service_add_bloc.dart
    │       │   │       │           service_add_event.dart
    │       │   │       │           service_add_state.dart
    │       │   │       │           
    │       │   │       ├───service_list
    │       │   │       │   │   screen_service_list.dart
    │       │   │       │   │   
    │       │   │       │   └───bloc
    │       │   │       │           service_list_bloc.dart
    │       │   │       │           service_list_event.dart
    │       │   │       │           service_list_state.dart
    │       │   │       │           
    │       │   │       └───service_update
    │       │   │           │   screen_service_update.dart
    │       │   │           │   
    │       │   │           └───bloc
    │       │   │                   service_update_bloc.dart
    │       │   │                   service_update_event.dart
    │       │   │                   service_update_state.dart
    │       │   │                   
    │       │   ├───order
    │       │   │   ├───order_details
    │       │   │   │   │   screen_order_details_shop.dart
    │       │   │   │   │   
    │       │   │   │   └───bloc
    │       │   │   │           order_details_shop_bloc.dart
    │       │   │   │           order_details_shop_event.dart
    │       │   │   │           order_details_shop_state.dart
    │       │   │   │           
    │       │   │   └───order_list
    │       │   │       │   screen_order_list_shop.dart
    │       │   │       │   
    │       │   │       └───bloc
    │       │   │               order_list_shop_bloc.dart
    │       │   │               order_list_shop_event.dart
    │       │   │               order_list_shop_state.dart
    │       │   │               
    │       │   └───profile
    │       │       ├───update
    │       │       │   │   screen_profile_update_shop.dart
    │       │       │   │   
    │       │       │   └───bloc
    │       │       │           profile_update_shop_bloc.dart
    │       │       │           profile_update_shop_event.dart
    │       │       │           profile_update_shop_state.dart
    │       │       │           
    │       │       └───view
    │       │           │   screen_profile_shop.dart
    │       │           │   
    │       │           └───bloc
    │       │                   profile_view_shop_bloc.dart
    │       │                   profile_view_shop_event.dart
    │       │                   profile_view_shop_state.dart
    │       │                   
    │       ├───splash
    │       │       screen_splash.dart
    │       │       
    │       └───user
    │           ├───cart
    │           │   │   screen_cart.dart
    │           │   │   
    │           │   └───bloc
    │           │           order_place_bloc.dart
    │           │           order_place_event.dart
    │           │           order_place_state.dart
    │           │           
    │           ├───home
    │           │       screen_home_user.dart
    │           │       
    │           ├───order
    │           │   ├───order_details
    │           │   │   │   screen_order_details_user.dart
    │           │   │   │   
    │           │   │   └───bloc
    │           │   │           order_details_user_bloc.dart
    │           │   │           order_details_user_event.dart
    │           │   │           order_details_user_state.dart
    │           │   │           
    │           │   └───order_list
    │           │       │   screen_order_list_user.dart
    │           │       │   
    │           │       └───bloc
    │           │               order_list_user_bloc.dart
    │           │               order_list_user_event.dart
    │           │               order_list_user_state.dart
    │           │               
    │           ├───profile
    │           │   ├───update
    │           │   │   │   screen_profile_update_user.dart
    │           │   │   │   
    │           │   │   └───bloc
    │           │   │           profile_update_user_bloc.dart
    │           │   │           profile_update_user_event.dart
    │           │   │           profile_update_user_state.dart
    │           │   │           
    │           │   └───view
    │           │       │   screen_profile_user.dart
    │           │       │   
    │           │       └───bloc
    │           │               profile_view_user_bloc.dart
    │           │               profile_view_user_event.dart
    │           │               profile_view_user_state.dart
    │           │               
    │           └───shop
    │               ├───shop_details
    │               │   │   screen_shop_details_user.dart
    │               │   │   
    │               │   └───bloc
    │               │           shop_details_user_bloc.dart
    │               │           shop_details_user_event.dart
    │               │           shop_details_user_state.dart
    │               │           
    │               └───shop_list
    │                   │   screen_shop_list.dart
    │                   │   
    │                   └───bloc
    │                           shop_list_bloc.dart
    │                           shop_list_event.dart
    │                           shop_list_state.dart
    │                           
    ├───router
    │       app_router.dart
    │       
    └───utilities
            app_asset.dart
            app_color.dart
            app_constant.dart
            app_helper.dart
            app_size.dart
            app_text.dart
            app_text_formatter.dart
            app_theme.dart
            app_validator.dart


## Overview
- splash screen.
<p float="left">
  <img src="screenshots/1.splash.png" width="200"  alt="initial"/>

- role selection.
<p float="left">
  <img src="screenshots/2.roleSelect.png" width="200"  alt="initial"/>


  
### User Flow
- user can register and login to the app.
<p float="left">
  <img src="screenshots/3.1.login.png" width="200"  alt="initial"/>
  <img src="screenshots/user/3.2.userReg.png" width="200"  alt="initial"/>

- whenever a new user registers, change password or update phone number, user need to verify the action by providing OTP sent to the registered phone number.
<p float="left">
  <img src="screenshots/17.otp.png" width="200"  alt="initial"/>

- user can view shop list and shop details. inside shop details user can find price list and can add items to cart. from the cart, user can place order for laundry services.
<p float="left">
  <img src="screenshots/user/5.shopList.png" width="200"  alt="initial"/>
  <img src="screenshots/user/5.1.shopDetails.png" width="200"  alt="initial"/>
  <img src="screenshots/user/5.2.priceList.png" width="200"  alt="initial"/>
  <img src="screenshots/user/5.3.selectOrder.png" width="200"  alt="initial"/>
  <img src="screenshots/user/6.1.cartView.png" width="200"  alt="initial"/>
  <img src="screenshots/user/6.2.cartOrderPlace.png" width="200"  alt="initial"/>

- user can view order list and order details.
<p float="left">
  <img src="screenshots/4.orderList.png" width="200"  alt="initial"/>
  <img src="screenshots/user/4.1.orderDetails.png" width="200"  alt="initial"/>
  <img src="screenshots/user/4.2.orderItems.png" width="200"  alt="initial"/>

- user can view and update profile.
<p float="left">
  <img src="screenshots/user/7.userProfile.png" width="200"  alt="initial"/>
  <img src="screenshots/user/7.1.update.png" width="200"  alt="initial"/>

### Shop Flow
- shop can register and login to the app.
<p float="left">
  <img src="screenshots/3.1.login.png" width="200"  alt="initial"/>
  <img src="screenshots/shop/3.2.1.shopReg.png" width="200"  alt="initial"/>
  <img src="screenshots/shop/3.2.2.shopReg.png" width="200"  alt="initial"/>

- shop can view its own order list and order details. shop can update order status from order details.
<p float="left">
  <img src="screenshots/4.orderList.png" width="200"  alt="initial"/>
  <img src="screenshots/shop/10.1.orderDetails.png" width="200"  alt="initial"/>
  <img src="screenshots/shop/10.2.orderStatusUpdate.png" width="200"  alt="initial"/>

- shop can manage its own inventory. shop can add, update and activate/deactivate items, prices and services. activation/deactivation of either service or item will be responsible to show/hide the corresponding price from price list for the user. shop can show/hide the price by activating/deactivating the price as well.
<p float="left">
  <img src="screenshots/shop/12.1.priceList.png" width="200"  alt="initial"/>
  <img src="screenshots/shop/12.2.addPrice.png" width="200"  alt="initial"/>
  <img src="screenshots/shop/12.3.updatePrice.png" width="200"  alt="initial"/>
  <img src="screenshots/shop/13.1.serviceList.png" width="200"  alt="initial"/>
  <img src="screenshots/shop/13.2.seviceAdd.png" width="200"  alt="initial"/>
  <img src="screenshots/shop/13.3.serviceUpdate.png" width="200"  alt="initial"/>
  <img src="screenshots/shop/14.1.itemList.png" width="200"  alt="initial"/>
  <img src="screenshots/shop/14.2.itemAdd.png" width="200"  alt="initial"/>
  <img src="screenshots/shop/14.3.itemUpdate.png" width="200"  alt="initial"/>

- shop can view and update profile.
<p float="left">
  <img src="screenshots/shop/15.1.shopProfile.png" width="200"  alt="initial"/>
  <img src="screenshots/shop/15.2.shopDetails.png" width="200"  alt="initial"/>
  <img src="screenshots/shop/15.3.shopUpdate.png" width="200"  alt="initial"/>
  <img src="screenshots/shop/15.4.shopUpdateMore.png" width="200"  alt="initial"/>

- there are also some common features for both user and shop like change password, change phone number and notification list.
<p float="left">
  <img src="screenshots/8.phoneUpdate.png" width="200"  alt="initial"/>
  <img src="screenshots/9.passwordUpdate.png" width="200"  alt="initial"/>

- user notification list.
<p float="left">
  <img src="screenshots/user/16.notification.png" width="200"  alt="initial"/>

- shop notification list.
<p float="left">
  <img src="screenshots/shop/11.1.notification.png" width="200"  alt="initial"/>


## Future Improvements
- implement payment gateway for order payment.
- latitude and longitude based location pick show shop list for user.
- implement order tracking for user.
- chat facility between user and shop.
- include convenient time details during order placement to pick up and delivery for user.

## Support
If you find this repository useful, consider giving it a star.

For feedbacks or suggestions:
Email: taufiqneloy.swe@gmail.com