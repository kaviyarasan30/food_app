import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:app/colors/colors.dart';
import 'package:app/controllers/popular_product_controller.dart';
import 'package:app/controllers/recommended_product_controller.dart';
import 'package:app/models/products_model.dart';
// import 'package:food_app/pages/food/popular_food_details.dart';
import 'package:app/routes/route_helper.dart';
import 'package:app/utils/app_constants.dart';
import 'package:app/utils/dimensions.dart';
import 'package:app/widgets/app_column.dart';
import 'package:app/widgets/big_text.dart';
import 'package:app/widgets/icon_and_text_widget.dart';
import 'package:app/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final screenHeight = MediaQuery.of(context).size.height;
        final pageViewHeight = screenHeight * 0.3;
        return Column(children: [
          GetBuilder<PopularProductController>(builder: (popularProducts) {
            final popularProductList = popularProducts.popularProductList;
            final itemCount = popularProductList.length;
            if (itemCount > 0) {
              return popularProducts.isLoaded
                  ? SizedBox(
                      height: pageViewHeight,
                      child: PageView.builder(
                        controller: pageController,
                        itemCount: itemCount,
                        itemBuilder: (context, position) {
                          return _buildPageItem(position,
                              popularProducts.popularProductList[position]);
                        },
                      ),
                    )
                  : Container();
            } else {
              // Show a loading indicator or empty state when popularProductList is empty.
              return const Center(
                  child: CircularProgressIndicator(
                color: AppColors.mainColor,
              ));
            }
          }),
          GetBuilder<PopularProductController>(builder: (popularProducts) {
            // ignore: unused_local_variable
            final popularProductList = popularProducts.popularProductList;
            final itemCount = popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length;
            if (itemCount > 0) {
              return DotsIndicator(
                dotsCount: itemCount,
                position: _currPageValue.floor(),
                decorator: DotsDecorator(
                  activeColor: AppColors.mainColor,
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              );
            } else {
              // Show an empty container when popularProductList is empty.
              return Container();
            }
          }),
          SizedBox(
            height: Dimensions.height20,
          ),
          Container(
              margin: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(text: "Recommended"),
                      SizedBox(width: Dimensions.width10),
                      Container(
                        margin: const EdgeInsets.only(bottom: 3),
                        child: BigText(text: ".", color: Colors.black26),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        margin: const EdgeInsets.only(top: 3),
                        child: SmallText(text: "Food Pairing"),
                      ),
                    ],
                  ),
                  //list of food and images
                  GetBuilder<RecommendedProductController>(
                      builder: (recommendedProduct) {
                    return recommendedProduct.isLoaded
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.only(top: 30),
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                padding: EdgeInsets.only(
                                    left: 5, right: Dimensions.width10),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: recommendedProduct
                                    .recommendedProductList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                            RouteHelper.getRecommendedFood(
                                                index, "home"));
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          children: [
                                            //image section
                                            Image.network(
                                              '${AppConstants.BASE_URL}${AppConstants.UPLOAD_URL}${Uri.encodeComponent(recommendedProduct.recommendedProductList[index].img!)}',
                                              width: Dimensions.listViewImgSize,
                                              height:
                                                  Dimensions.listViewImgSize,
                                              fit: BoxFit.cover,
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent?
                                                          loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                } else {
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      value: loadingProgress
                                                                  .expectedTotalBytes !=
                                                              null
                                                          ? loadingProgress
                                                                  .cumulativeBytesLoaded /
                                                              (loadingProgress
                                                                      .expectedTotalBytes ??
                                                                  1)
                                                          : null,
                                                    ),
                                                  );
                                                }
                                              },
                                              errorBuilder:
                                                  (BuildContext context,
                                                      Object error,
                                                      StackTrace? stackTrace) {
                                                return Container(
                                                  width: Dimensions
                                                      .listViewImgSize,
                                                  height: Dimensions
                                                      .listViewImgSize,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                .radius20),
                                                    color: Colors
                                                        .grey, // Placeholder color for failed images
                                                  ),
                                                  child: const Icon(
                                                    Icons.error_outline,
                                                    color: Colors.white,
                                                  ),
                                                );
                                              },
                                            ),

                                            Expanded(
                                              child: Container(
                                                height: Dimensions
                                                    .listViewTextcontSize,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topRight: Radius.circular(
                                                        Dimensions.radius20),
                                                    bottomRight:
                                                        Radius.circular(
                                                            Dimensions
                                                                .radius20),
                                                  ),
                                                  color: Colors.white,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: Dimensions.width10,
                                                      right:
                                                          Dimensions.width10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      BigText(
                                                          text: recommendedProduct
                                                              .recommendedProductList[
                                                                  index]
                                                              .name!),
                                                      SizedBox(
                                                          height: Dimensions
                                                              .height10),
                                                      SmallText(
                                                          text:
                                                              "With chinese characteristics"),
                                                      SizedBox(
                                                          height: Dimensions
                                                              .height10),
                                                      const Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          IconAndTextWidget(
                                                              icon: Icons
                                                                  .circle_sharp,
                                                              text: "Normal",
                                                              iconColor: AppColors
                                                                  .iconColor1),
                                                          IconAndTextWidget(
                                                              icon: Icons
                                                                  .location_on,
                                                              text: "1.7km",
                                                              iconColor: AppColors
                                                                  .mainColor),
                                                          IconAndTextWidget(
                                                              icon: Icons
                                                                  .access_time_rounded,
                                                              text: "32min",
                                                              iconColor: AppColors
                                                                  .iconColor2)
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ));
                                },
                              ),
                            ),
                          )
                        : const CircularProgressIndicator(
                            color: AppColors.mainColor,
                          );
                  })
                ],
              ))
        ]);
      },
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index, "home"));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: index.isEven ? const Color(0xFF69c5df) : const Color(0xFF9294cc),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(AppConstants.BASE_URL +
                          AppConstants.UPLOAD_URL +
                          popularProduct.img!))),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                  bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5.0,
                        offset: Offset(0, 5)),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height15, left: 15, right: 15),
                child: AppColumn(text: popularProduct.name!),
              ),
            ),
          )
        ],
      ),
    );
  }
}
