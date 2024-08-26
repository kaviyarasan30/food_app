import 'package:flutter/material.dart';
import 'package:app/colors/colors.dart';
import 'package:app/pages/home/food_page_body.dart';
// import 'package:food_app/utils/dimensions.dart';
import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/small_text.dart';
// import 'package:flutter/src/rendering/box.dart';
import 'package:get/get.dart';
import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    // ignore: unused_local_variable
    final appBarHeight = screenHeight * 0.07;
    final appBarPadding = screenWidth * 0.05;
    final topMargin = screenHeight * 0.05;
    final bottomMargin = screenHeight * 0.02;

    return RefreshIndicator(
        onRefresh: _loadResource,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: topMargin, bottom: bottomMargin),
              padding: EdgeInsets.symmetric(horizontal: appBarPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(
                        text: "Bangladesh",
                        color: AppColors.mainColor,
                      ),
                      Row(
                        children: [
                          SmallText(
                            text: "Narsingdi",
                            color: Colors.black87,
                          ),
                          const Icon(Icons.arrow_drop_down_rounded)
                        ],
                      )
                    ],
                  ),
                  Center(
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.mainColor,
                      ),
                      child: const Icon(Icons.search, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            const Expanded(
                child: SingleChildScrollView(
              child: FoodPageBody(),
            ))
          ],
        ));
  }
}
