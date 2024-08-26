// ignore_for_file: constant_identifier_names

class AppConstants {
  static const String APP_NAME = "DMFood";
  static const int APP_VERSION = 1;

  static const String BASE_URL =
      "https://53b9-2409-40f4-13-74d6-4c87-125a-c7c0-13ce.ngrok-free.app";
  static const String POPULAR_PRODUCT_URL = "/api/v1/products/popular";
  static const String RECOMMENDED_PRODUCT_URL = "/api/v1/products/recommended";
  static const String UPLOAD_URL = "/uploads/";

  //user and  auth end points
  static const String REGISTRATION_URL = "/api/v1/auth/register";
  static const String LOGIN_URL = "/api/v1/auth/login";
  static const String USER_INFO_URL = "/api/v1/customer/info";

  //new
  static const String USER_ADDRESS = "user_address";
  static const String ADD_USER_ADDRESS = "/api/v1/customer/address/add";
  static const String ADDRESS_LIST_URI = "/api/v1/customer/address/list";

  // config url
  static const String GEOCODE_URI = '/api/v1/config/geocode-api';
  static const String ZONE_URI = "/api/v1/config/get-zone-id";
  static const String SEARCH_LOCATION_URI =
      "/api/v1/config/place-api-autocomplete";
  static const String PLACE_DETAILS_URI = '/api/v1/config/place-api-details';

  //orders

  static const String PLACE_ORDER_URI = '/api/v1/customer/order/place';
  static const String ORDER_LIST_URI = '/api/v1/customer/order/list';

  static const String TOKEN = "";
  static const String PHONE = "";
  static const String PASSWORD = "";
  static const String CART_LIST = "Cart-list";
  static const String CART_HISTORY_LIST = "cart-history-list";
}
