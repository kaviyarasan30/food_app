import 'package:app/data/api/api_client.dart';
import 'package:app/models/place_order_model.dart';
import 'package:app/utils/app_constants.dart';
import 'package:get/get.dart';

class OrderRepo {
  final ApiClient apiClient;
  OrderRepo({required this.apiClient});
  Future<Response> placeOrder(PlaceOrderBody placeOrder) async {
    return await apiClient.postData(
        AppConstants.PLACE_ORDER_URI, placeOrder.toJson());
  }

  Future<Response> getOrderList() async {
    return await apiClient.getData(AppConstants.ORDER_LIST_URI);
  }
}
