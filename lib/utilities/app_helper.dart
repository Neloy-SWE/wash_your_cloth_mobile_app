/* 
Created by Neloy on 11 September, 2026.
Email: taufiqneloy.swe@gmail.com
*/

String hidePhoneOrEmail({required String phoneOrEmail}) {
  return "${phoneOrEmail.substring(0, 2)}***${phoneOrEmail.substring(phoneOrEmail.length - 2, phoneOrEmail.length)}";
}
