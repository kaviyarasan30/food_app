import 'package:app/base/common_text_button.dart';
import 'package:app/base/show_custom_snackbar.dart';
import 'package:app/controllers/order_controller.dart';
import 'package:app/controllers/user_controller.dart';
import 'package:app/models/place_order_model.dart';
import 'package:app/pages/order/delivery_options.dart';
import 'package:app/pages/order/payment_option_button.dart';
import 'package:app/utils/styles.dart';
import 'package:app/widgets/app_text_field.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:app/base/no_data_page.dart';
import 'package:app/colors/colors.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/cart_controller.dart';
import 'package:app/controllers/location_controller.dart';
import 'package:app/controllers/popular_product_controller.dart';
import 'package:app/controllers/recommended_product_controller.dart';
// import 'package:food_app/pages/home/main_food_page.dart';
import 'package:app/routes/route_helper.dart';
import 'package:app/utils/app_constants.dart';
import 'package:app/utils/dimensions.dart';
import 'package:app/widgets/app_icon.dart';
import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/small_text.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController noteController = TextEditingController();
    return Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: Dimensions.height20 * 3,
                left: Dimensions.width20,
                right: Dimensions.width20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppIcon(
                      icon: Icons.arrow_back_ios,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconsize24,
                    ),
                    SizedBox(
                      width: Dimensions.width20 * 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getInitial());
                      },
                      child: AppIcon(
                        icon: Icons.home_outlined,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                        iconSize: Dimensions.iconsize24,
                      ),
                    ),
                    AppIcon(
                      icon: Icons.shopping_cart,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimensions.iconsize24,
                    ),
                  ],
                )),
            GetBuilder<CartController>(builder: (cartContoller) {
              return cartContoller.getItems.isNotEmpty
                  ? Positioned(
                      top: Dimensions.height20 * 5,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      bottom: 0,
                      child: Container(
                        margin: EdgeInsets.only(top: Dimensions.height15),
                        //color: Color.fromRGBO(244, 67, 54, 1),
                        child: MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: GetBuilder<CartController>(
                              builder: (CartController) {
                                var cartList = CartController.getItems;
                                return ListView.builder(
                                  itemCount: cartList.length,
                                  itemBuilder: (_, index) {
                                    return SizedBox(
                                      width: double.maxFinite,
                                      height: Dimensions.height20 * 5,
                                      child: Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              var popularIndex = Get.find<
                                                      PopularProductController>()
                                                  .popularProductList
                                                  .indexOf(cartList[index]
                                                      .product!);
                                              if (popularIndex >= 0) {
                                                Get.toNamed(
                                                    RouteHelper.getPopularFood(
                                                        popularIndex,
                                                        "cartpage"));
                                              } else {
                                                var recommendedIndex = Get.find<
                                                        RecommendedProductController>()
                                                    .recommendedProductList
                                                    .indexOf(cartList[index]
                                                        .product!);
                                                if (recommendedIndex < 0) {
                                                  Get.snackbar(
                                                      "History product",
                                                      "Product review is not availble for history products",
                                                      backgroundColor:
                                                          AppColors.mainColor,
                                                      colorText: Colors.white);
                                                } else {
                                                  Get.toNamed(RouteHelper
                                                      .getRecommendedFood(
                                                          recommendedIndex,
                                                          "cartpage"));
                                                }
                                              }
                                            },
                                            child: CachedNetworkImage(
                                              imageUrl: AppConstants.BASE_URL +
                                                  AppConstants.UPLOAD_URL +
                                                  CartController
                                                      .getItems[index].img!,
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                width: Dimensions.height20 * 5,
                                                height: Dimensions.height20 * 5,
                                                margin: EdgeInsets.only(
                                                    bottom:
                                                        Dimensions.height10),
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: imageProvider,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Dimensions.radius20),
                                                  color: Colors.white,
                                                ),
                                              ),
                                              placeholder: (context, url) =>
                                                  const CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                          SizedBox(
                                            width: Dimensions.width10,
                                          ),
                                          Expanded(
                                              child: SizedBox(
                                            height: Dimensions.height20 * 5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                BigText(
                                                  text: CartController
                                                      .getItems[index].name!,
                                                  color: Colors.black54,
                                                ),
                                                SmallText(text: "spicy"),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    BigText(
                                                      text: CartController
                                                          .getItems[index].price
                                                          .toString(),
                                                      color: Colors.redAccent,
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          top: Dimensions
                                                              .height10,
                                                          bottom: Dimensions
                                                              .height10,
                                                          left: Dimensions
                                                              .width10,
                                                          right: Dimensions
                                                              .width10),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                Dimensions
                                                                    .radius20),
                                                        color: Colors.white,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          GestureDetector(
                                                              onTap: () {
                                                                CartController.addItem(
                                                                    cartList[
                                                                            index]
                                                                        .product!,
                                                                    -1);
                                                              },
                                                              child: const Icon(
                                                                  Icons.remove,
                                                                  color: AppColors
                                                                      .signColor)),
                                                          SizedBox(
                                                              width: Dimensions
                                                                      .width10 /
                                                                  2),
                                                          BigText(
                                                              text: cartList[
                                                                      index]
                                                                  .quantity
                                                                  .toString()), //popularProduct.inCartItems.toString()),
                                                          SizedBox(
                                                              width: Dimensions
                                                                      .width10 /
                                                                  2),
                                                          GestureDetector(
                                                              onTap: () {
                                                                CartController.addItem(
                                                                    cartList[
                                                                            index]
                                                                        .product!,
                                                                    1);
                                                              },
                                                              child: const Icon(
                                                                  Icons.add,
                                                                  color: AppColors
                                                                      .signColor))
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ))
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            )),
                      ))
                  : const NoDataPage(text: "Your cart is empty!");
            })
          ],
        ),
        bottomNavigationBar:
            GetBuilder<OrderController>(builder: (orderController) {
          noteController.text = orderController.foodNote;
          return GetBuilder<CartController>(builder: (cartController) {
            return Container(
              height: Dimensions.bottomHeightBar + 50,
              padding: EdgeInsets.only(
                  top: Dimensions.height10,
                  bottom: Dimensions.height10,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20 * 2),
                      topRight: Radius.circular(Dimensions.radius20 * 2))),
              child: cartController.getItems.isNotEmpty
                  ? Column(
                      children: [
                        InkWell(
                          onTap: () => showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (_) {
                                    return Column(
                                      children: [
                                        Expanded(
                                          child: SingleChildScrollView(
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.9,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(
                                                          Dimensions.radius20),
                                                      topRight: Radius.circular(
                                                          Dimensions
                                                              .radius20))),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 520,
                                                    padding: EdgeInsets.only(
                                                        left:
                                                            Dimensions.width20,
                                                        right:
                                                            Dimensions.width20,
                                                        top: Dimensions
                                                            .height20),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const PaymentOptionButton(
                                                          icon: Icons.money,
                                                          title:
                                                              "cash on delivery",
                                                          subTitle:
                                                              'You pay after getting the delivery',
                                                          index: 0,
                                                        ),
                                                        SizedBox(
                                                          height: Dimensions
                                                              .height10,
                                                        ),
                                                        const PaymentOptionButton(
                                                          icon: Icons
                                                              .paypal_outlined,
                                                          title:
                                                              "digital payment",
                                                          subTitle:
                                                              'safer and faster way of payment',
                                                          index: 1,
                                                        ),
                                                        SizedBox(
                                                          height: Dimensions
                                                              .height30,
                                                        ),
                                                        Text(
                                                          "Delivery options",
                                                          style: robotoMedium,
                                                        ),
                                                        SizedBox(
                                                          height: Dimensions
                                                                  .height10 /
                                                              2,
                                                        ),
                                                        DeliveryOptions(
                                                            value: "delivery",
                                                            title:
                                                                "Home delivery",
                                                            amount: double
                                                                .parse(Get.find<
                                                                        CartController>()
                                                                    .totalAmount
                                                                    .toString()),
                                                            isFree: false),
                                                        SizedBox(
                                                          height: Dimensions
                                                              .height10,
                                                        ),
                                                        const DeliveryOptions(
                                                            value: "take away",
                                                            title: "Take away",
                                                            amount: 0,
                                                            isFree: false),
                                                        SizedBox(
                                                          height: Dimensions
                                                              .height20,
                                                        ),
                                                        Text(
                                                          "Additional notes",
                                                          style: robotoMedium,
                                                        ),
                                                        AppTextField(
                                                          textController:
                                                              noteController,
                                                          hintText: '',
                                                          icon: Icons.note,
                                                          maxLines: true,
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  })
                              .whenComplete(() => orderController
                                  .setFoodNote(noteController.text.trim())),
                          child: const SizedBox(
                            width: double.maxFinite,
                            child: CommonTextButton(text: "Payment option"),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  top: Dimensions.height20,
                                  bottom: Dimensions.height20,
                                  left: Dimensions.width20,
                                  right: Dimensions.width20),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: Dimensions.width10 / 2),
                                  BigText(
                                      text: "\$ ${cartController.totalAmount}"),
                                  SizedBox(width: Dimensions.width10 / 2),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (Get.find<AuthController>().userLoggedIn()) {
                                  // cartController.addToHistory();
                                  print("logged in?");
                                  if (Get.find<LocationController>()
                                      .addressList
                                      .isEmpty) {
                                    Get.toNamed(RouteHelper.getAddressPage());
                                  } else {
                                    // Get.offNamed(
                                    //   RouteHelper.getInitial(),
                                    // );
                                    // Get.offNamed(RouteHelper.getPaymentPage("100127",
                                    //     Get.find<UserController>().userModel!.id!));

                                    var location =
                                        Get.find<LocationController>()
                                            .getUserAddress();
                                    var cart =
                                        Get.find<CartController>().getItems;
                                    var user =
                                        Get.find<UserController>().userModel;

                                    PlaceOrderBody placeOrder = PlaceOrderBody(
                                        cart: cart,
                                        orderAmount: 100.0,
                                        distance: 10.0,
                                        scheduleAt: '',
                                        orderNote: orderController.foodNote,
                                        address: location.address,
                                        latitude: location.latitude,
                                        longitude: location.longitude,
                                        contactPersonName: user!.name,
                                        contactPersonNumber: user.phone,
                                        orderType: orderController.orderType,
                                        paymentMethod:
                                            orderController.paymentIndex == 0
                                                ? 'cash_on_delivery'
                                                : 'digital_payment');

                                    Get.find<OrderController>()
                                        .placeOrder(placeOrder, _callback);
                                  }
                                } else {
                                  Get.toNamed(RouteHelper.getSignInPage());
                                }
                              },
                              child: const CommonTextButton(text: "check out"),
                            )
                          ],
                        )
                      ],
                    )
                  : Container(),
            );
          });
        }));
  }

  void _callback(bool isSuccess, String message, String orderID) {
    if (isSuccess) {
      Get.find<CartController>().clear();
      Get.find<CartController>().removeCartSharedPreference();
      Get.find<CartController>().addToHistory();
      if (Get.find<OrderController>().paymentIndex == 0) {
        Get.offNamed(RouteHelper.getOrderSuccessPage(orderID, "Success"));
      } else {
        Get.offNamed(RouteHelper.getPaymentPage(
            orderID, Get.find<UserController>().userModel!.id));
      }
    } else {
      showCustomSnackBar(message);
    }
  }
}
