/* 
Created by Neloy on 12 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'profile_update_shop_bloc.dart';

sealed class ProfileUpdateShopEvent extends Equatable {
  const ProfileUpdateShopEvent();

  @override
  List<Object?> get props => [];
}

class ProfileUpdateShopEventSubmit extends ProfileUpdateShopEvent {
  final String ownerFirstName;
  final String ownerLastName;
  final String shopAddress;

  // final String longitude;
  // final String latitude;

  final String shopName;
  final String openTime;
  final String closeTime;
  final String weekends;
  final double deliveryCharge;

  const ProfileUpdateShopEventSubmit({
    required this.ownerFirstName,
    required this.ownerLastName,
    required this.shopAddress,
    // required this.longitude,
    // required this.latitude,
    required this.shopName,
    required this.openTime,
    required this.closeTime,
    required this.weekends,
    required this.deliveryCharge,
  });

  @override
  List<Object?> get props => [
    ownerFirstName,
    ownerLastName,
    shopAddress,
    shopName,
    openTime,
    closeTime,
    weekends,
    deliveryCharge,
  ];
}
