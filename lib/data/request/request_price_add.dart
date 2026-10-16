/* 
Created by Neloy on 09 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

class RequestPriceAdd {
  final String serviceId;
  final String itemId;
  final double price;
  final double discountPrice;
  final double ironPressPrice;

  RequestPriceAdd({
    required this.price,
    required this.discountPrice,
    required this.ironPressPrice,
    required this.serviceId,
    required this.itemId,
  });

  Map<String, dynamic> toMap() => {
    'serviceId': serviceId,
    'itemId': itemId,
    'price': price,
    'discountPrice': discountPrice,
    'ironPressPrice': ironPressPrice,
  };
}
