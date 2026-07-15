/* 
Created by Neloy on 15 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';

import '../../../client/client.dart';
import '../../../client/client_constant.dart';
import '../../../model/model_error.dart';
import '../../../model/model_order_list.dart';
import '../../api_path.dart';

part 'api_get_order_list_user.dart';

abstract class IApiGetOrderList {
  Future<(List<ModelOrderList>?, ModelError?)> getOrderList();
}
