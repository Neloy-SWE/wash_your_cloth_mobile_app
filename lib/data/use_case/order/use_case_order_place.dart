/* 
Created by Neloy on 22 August, 2026.
Email: taufiqneloy.swe@gmail.com
*/

class OrderPlaceData {
  final String shopId;
  final String note;
  final List<ItemData> items;

  const OrderPlaceData({
    required this.shopId,
    required this.note,
    required this.items,
  });

  Map<String, dynamic> toJson() => {
    'shopId': shopId,
    'note': note,
    'items': items.map((item) => item.toMap()).toList(),
  };
}

class ItemData {
  final String priceId;
  final int quantity;
  final bool isIronPress;

  const ItemData({
    required this.priceId,
    required this.quantity,
    required this.isIronPress,
  });

  Map<String, dynamic> toMap() => {
    'priceId': priceId,
    'quantity': quantity,
    'isIronPress': isIronPress,
  };
}

class CartData {
  final String priceId;
  final int quantity;
  final bool isIronPress;
  final double unitPrice;
  final double ironPressPrice;
  final String serviceName;
  final String itemName;

  const CartData({
    required this.priceId,
    required this.quantity,
    required this.isIronPress,
    required this.unitPrice,
    required this.ironPressPrice,
    required this.serviceName,
    required this.itemName,
  });
}
