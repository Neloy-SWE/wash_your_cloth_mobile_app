/* 
Created by Neloy on 15 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:wash_your_cloth_mobile_app/data/model/model_order_list.dart';

class UseCaseOrderList {
  bool isListFetch;
  List<ModelOrderList>? orderList;
  String? message;

  UseCaseOrderList({required this.isListFetch, this.orderList, this.message});
}
