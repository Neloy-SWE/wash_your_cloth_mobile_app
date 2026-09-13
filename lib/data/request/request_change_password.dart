/* 
Created by Neloy on 13 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

class RequestChangePassword {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  RequestChangePassword({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toMap() => {
    'oldPassword': oldPassword,
    'newPassword': newPassword,
    'confirmPassword': confirmPassword,
  };
}
