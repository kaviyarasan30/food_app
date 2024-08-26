import 'package:app/base/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:app/base/custom_loader.dart';
import 'package:app/colors/colors.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/controllers/cart_controller.dart';
import 'package:app/controllers/location_controller.dart';
import 'package:app/controllers/user_controller.dart';
import 'package:app/routes/route_helper.dart';
import 'package:app/utils/dimensions.dart';
import 'package:app/widgets/account_widget.dart';
import 'package:app/widgets/app_icon.dart';
import 'package:app/widgets/big_text.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (userLoggedIn) {
      Get.find<UserController>().getUserInfo();
      Get.find<LocationController>().getAddressList();
      print("User has logged in");
    }
    return Scaffold(
        appBar: const CustomAppBar(title: "Profile"),
        body: GetBuilder<UserController>(
          builder: (userController) {
            return userLoggedIn
                ? (userController.isLoading
                    ? Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(top: Dimensions.height20),
                        child: Column(
                          children: [
                            //profile icon
                            AppIcon(
                              icon: Icons.person,
                              backgroundColor: AppColors.mainColor,
                              iconColor: Colors.white,
                              iconSize: Dimensions.height75,
                              size: Dimensions.height15 * 10,
                            ),
                            SizedBox(
                              height: Dimensions.height30,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    //name
                                    AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.person,
                                          backgroundColor: AppColors.mainColor,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(
                                            text: userController
                                                .userModel!.name)),

                                    SizedBox(
                                      height: Dimensions.height30,
                                    ),
                                    //phone
                                    AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.phone,
                                          backgroundColor:
                                              AppColors.yellowColor,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(
                                            text: userController
                                                .userModel!.phone)),

                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    //email
                                    AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.email,
                                          backgroundColor:
                                              AppColors.yellowColor,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(
                                            text: userController
                                                .userModel!.email)),

                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    //address
                                    GetBuilder<LocationController>(
                                        builder: (locationController) {
                                      if (userLoggedIn &&
                                          locationController
                                              .addressList.isEmpty) {
                                        return GestureDetector(
                                          onTap: () {
                                            Get.offNamed(
                                                RouteHelper.getAddressPage());
                                          },
                                          child: AccountWidget(
                                              appIcon: AppIcon(
                                                icon: Icons.location_on,
                                                backgroundColor:
                                                    AppColors.yellowColor,
                                                iconColor: Colors.white,
                                                iconSize:
                                                    Dimensions.height10 * 5 / 2,
                                                size: Dimensions.height10 * 5,
                                              ),
                                              bigText: BigText(
                                                  text:
                                                      "Fill in your Address")),
                                        );
                                      } else {
                                        return GestureDetector(
                                          onTap: () {
                                            Get.offNamed(
                                                RouteHelper.getAddressPage());
                                          },
                                          child: AccountWidget(
                                              appIcon: AppIcon(
                                                icon: Icons.location_on,
                                                backgroundColor:
                                                    AppColors.yellowColor,
                                                iconColor: Colors.white,
                                                iconSize:
                                                    Dimensions.height10 * 5 / 2,
                                                size: Dimensions.height10 * 5,
                                              ),
                                              bigText: BigText(
                                                  text: "Your Address")),
                                        );
                                      }
                                    }),

                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    //message
                                    AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.message_outlined,
                                          backgroundColor: Colors.redAccent,
                                          iconColor: Colors.white,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText: BigText(text: "Message")),

                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    //logout
                                    GestureDetector(
                                      onTap: () {
                                        if (Get.find<AuthController>()
                                            .userLoggedIn()) {
                                          Get.find<AuthController>()
                                              .clearSharedData();
                                          Get.find<CartController>().clear();
                                          Get.find<CartController>()
                                              .clearCartHistory();
                                          Get.find<LocationController>()
                                              .clearAddressList();
                                          Get.offNamed(
                                              RouteHelper.getSignInPage());
                                        } else {
                                          Get.offNamed(
                                              RouteHelper.getSignInPage());
                                        }
                                      },
                                      child: AccountWidget(
                                          appIcon: AppIcon(
                                            icon: Icons.logout,
                                            backgroundColor: Colors.redAccent,
                                            iconColor: Colors.white,
                                            iconSize:
                                                Dimensions.height10 * 5 / 2,
                                            size: Dimensions.height10 * 5,
                                          ),
                                          bigText: BigText(text: "Logout")),
                                    ),

                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : const CustomLoader())
                : Container(
                    child: Center(
                        child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: Dimensions.height20 * 8,
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    "assets/images/signintocontinue.png"))),
                      ),
                      SizedBox(
                        height: Dimensions.height15,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.getSignInPage());
                        },
                        child: Container(
                          width: double.maxFinite,
                          height: Dimensions.height20 * 5,
                          margin: EdgeInsets.only(
                              left: Dimensions.width20,
                              right: Dimensions.width20),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                          ),
                          child: Center(
                              child: BigText(
                            text: "Sign In",
                            color: Colors.white,
                            size: Dimensions.font20,
                          )),
                        ),
                      )
                    ],
                  )));
          },
        ));
  }
}
