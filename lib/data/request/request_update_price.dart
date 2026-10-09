/* 
Created by Neloy on 09 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

class RequestUpdatePrice {
  final double price;
  final double discountPrice;
  final double ironPressPrice;

  RequestUpdatePrice({
    required this.price,
    required this.discountPrice,
    required this.ironPressPrice,
  });

  Map<String, dynamic> toMap() => {
    'price': price,
    'discountPrice': discountPrice,
    'ironPressPrice': ironPressPrice,
  };
}
