/* 
Created by Neloy on 30 August, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'profile_view_shop_bloc.dart';

sealed class ProfileViewShopState extends Equatable {
  const ProfileViewShopState();

  @override
  List<Object?> get props => [];
}

class ProfileViewShopStateInitial extends ProfileViewShopState {}

class ProfileViewShopStateLoading extends ProfileViewShopState {}

class ProfileViewShopStateFetch extends ProfileViewShopState {
  final ModelProfileViewShop profileViewShop;

  const ProfileViewShopStateFetch({required this.profileViewShop});

  @override
  List<Object?> get props => [profileViewShop];
}

class ProfileViewShopStateResult extends ProfileViewShopState {
  final String message;

  const ProfileViewShopStateResult({required this.message});

  @override
  List<Object?> get props => [message];
}
