/* 
Created by Neloy on 18 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

class RequestChangePhone {
  final String oldPhone;
  final String newPhone;

  RequestChangePhone({required this.oldPhone, required this.newPhone});

  Map<String, dynamic> toMap() => {'oldPhone': oldPhone, 'newPhone': newPhone};
}
