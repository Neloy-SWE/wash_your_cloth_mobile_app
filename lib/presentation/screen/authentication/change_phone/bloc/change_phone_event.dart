/* 
Created by Neloy on 18 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'change_phone_bloc.dart';

sealed class ChangePhoneEvent extends Equatable {
  const ChangePhoneEvent();

  @override
  List<Object?> get props => [];
}

class ChangePhoneEventProceed extends ChangePhoneEvent {
  final String oldPhone;
  final String newPhone;

  const ChangePhoneEventProceed({
    required this.oldPhone,
    required this.newPhone,
  });

  @override
  List<Object?> get props => [oldPhone, newPhone];
}
