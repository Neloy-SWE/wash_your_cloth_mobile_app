/* 
Created by Neloy on 12 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of "profile_update_shop_bloc.dart";

sealed class ProfileUpdateShopState extends Equatable {
  const ProfileUpdateShopState();

  @override
  List<Object?> get props => [];
}

class ProfileUpdateShopStateInitial extends ProfileUpdateShopState {}

class ProfileUpdateShopStateLoading extends ProfileUpdateShopState {}

class ProfileUpdateShopStateResult extends ProfileUpdateShopState {
  final bool isNavigate;
  final String message;

  const ProfileUpdateShopStateResult({
    required this.message,
    required this.isNavigate,
  });

  @override
  List<Object?> get props => [message, isNavigate];
}
