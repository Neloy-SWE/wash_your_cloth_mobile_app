/* 
Created by Neloy on 30 August, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'profile_view_shop_bloc.dart';

sealed class ProfileViewShopEvent extends Equatable {
  const ProfileViewShopEvent();

  @override
  List<Object?> get props => [];
}

class ProfileViewShopEventFetch extends ProfileViewShopEvent {}
