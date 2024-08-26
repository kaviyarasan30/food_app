import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:app/base/custom_loader.dart';
import 'package:app/base/show_custom_snackbar.dart';
import 'package:app/colors/colors.dart';
import 'package:app/controllers/auth_controller.dart';
import 'package:app/pages/auth/sign_up_page.dart';
import 'package:app/routes/route_helper.dart';
import 'package:app/utils/dimensions.dart';
import 'package:app/widgets/app_text_field.dart';
import 'package:app/widgets/big_text.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();

    void login(AuthController authController) {
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();

      if (phone.isEmpty) {
        showCustomSnackBar("Type in your phone number", title: "Phone number");
      } else if (password.isEmpty) {
        showCustomSnackBar("Type in your password", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password cant not be less than six characters",
            title: "Password");
      } else {
        authController.login(phone, password).then((status) {
          if (status.isSuccess) {
            Get.offAndToNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(
          builder: (authController) {
            return !authController.isLoading
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(height: Dimensions.screenHeight * 0.05),
                        //app logo
                        SizedBox(
                          height: Dimensions.screenHeight * 0.25,
                          child: const Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 80,
                              backgroundImage:
                                  AssetImage("assets/images/logo_image01.jpg"),
                            ),
                          ),
                        ),
                        //welcome session
                        Container(
                          margin: EdgeInsets.only(
                              left: Dimensions.screenHeight * 0.05),
                          width: double.maxFinite,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello",
                                style: TextStyle(
                                  fontSize: Dimensions.font20 * 3 +
                                      Dimensions.font20 / 2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Singn into your account",
                                style: TextStyle(
                                  fontSize: Dimensions.font20,
                                  //fontWeight: FontWeight.bold,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        //email
                        AppTextField(
                            textController: phoneController,
                            hintText: "Phone",
                            icon: Icons.phone_android),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        //password
                        AppTextField(
                          textController: passwordController,
                          hintText: "Password",
                          icon: Icons.password_sharp,
                          isObscure: true,
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        //tag line
                        Row(
                          children: [
                            Expanded(child: Container()),
                            RichText(
                                text: TextSpan(
                                    text: "Sign into your account",
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: Dimensions.font20,
                                    ))),
                            SizedBox(
                              width: Dimensions.width20,
                            )
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.screenHeight * 0.05,
                        ),
                        //sign up
                        GestureDetector(
                          onTap: () {
                            //Get.toNamed(RouteHelper.getInitial());
                            login(authController);
                          },
                          child: Container(
                            width: Dimensions.screenWidth / 2,
                            height: Dimensions.screenHeight / 13,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius30),
                              color: AppColors.mainColor,
                            ),
                            child: Center(
                              child: BigText(
                                text: "Sign in",
                                size: Dimensions.font20 + Dimensions.font20 / 2,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.screenHeight * 0.05,
                        ),
                        //sign up options
                        RichText(
                            text: TextSpan(
                                text: "Don't an account?",
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.font20,
                                ),
                                children: [
                              TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Get.to(() => const SignUpPage(),
                                        transition: Transition.fade),
                                  text: " Create",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.mainBlackColor,
                                    fontSize: Dimensions.font20,
                                  ))
                            ])),
                      ],
                    ),
                  )
                : const CustomLoader();
          },
        ));
  }
}
