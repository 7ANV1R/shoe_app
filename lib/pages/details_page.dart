import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shoe_app/const/ui_helper.dart';
import 'package:shoe_app/data/shoe_model.dart';

import '../const/asset_const.dart';
import '../local_package/slide_to_go.dart';
import '../util/hex_color.dart';

class DetailsPage extends StatefulHookConsumerWidget {
  const DetailsPage({super.key, required this.shoe});
  final Shoe shoe;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailsPageState();
}

class _DetailsPageState extends ConsumerState<DetailsPage> with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.shoe;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: nikeAppBarWithBackButton(size),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Container(
      //     height: 70,
      //     width: size.width,
      //     decoration: BoxDecoration(
      //       color: Colors.white,
      //       borderRadius: BorderRadius.circular(12),
      //       boxShadow: [
      //         BoxShadow(
      //           color: Colors.black.withOpacity(0.5),
      //           blurRadius: 10,
      //           offset: const Offset(0, -5),
      //         ),
      //       ],
      //     ),
      //     child: SlideAction(
      //       onSubmit: () {},
      //       sliderButtonIcon: const Icon(
      //         Icons.shopping_cart,
      //         color: Colors.white,
      //       ),
      //       text: 'Add to cart',
      //       textStyle: const TextStyle(
      //         fontSize: 18,
      //         color: Colors.white,
      //         fontWeight: FontWeight.w500,
      //       ),
      //       borderRadius: 12,
      //       elevation: 0,
      //       innerColor: HexColor(item.prodPrimaryColor),
      //       outerColor: HexColor(item.prodPrimaryColor).withOpacity(0.5),
      //     ),
      //   ),
      // ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$${item.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Hero(
                        tag: item.img,
                        child: Transform.rotate(
                          angle: -35 * math.pi / 180,
                          child: Container(
                            clipBehavior: Clip.none,
                            child: AnimatedBuilder(
                                animation: animationController,
                                builder: (context, snapshot) {
                                  final valueAnimation = Curves.linear.transform(animationController.value);
                                  return Opacity(
                                    opacity: 1,
                                    child: Image.asset(
                                      item.img,
                                      height: 297.88 + 20,
                                      width: 297.88 + 20,
                                    )
                                        .animate()
                                        .scaleXY(
                                          end: 1,
                                        )
                                        .rotate(
                                          begin: 0 * valueAnimation,
                                          end: 0.09 * valueAnimation,
                                        ),
                                  );
                                }),
                          ),
                        ),
                      ),
                      Text(
                        item.description,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      kVerticalSpaceXXXL,
                      kVerticalSpaceXXXL,
                    ],
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 70,
              width: size.width,
              child: SlideAction(
                onSubmit: () {},
                sliderButtonIcon: const Icon(
                  Icons.shopping_cart_checkout,
                  color: Colors.white,
                ),
                text: 'Add to cart',
                textStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                ),
                borderRadius: 12,
                elevation: 0,
                innerColor: HexColor(item.prodPrimaryColor),
                outerColor: Colors.grey.shade300,
              )
                  .animate(
                    onPlay: (controller) => controller.repeat(),
                  )
                  .shimmer(
                    duration: const Duration(seconds: 4),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSize nikeAppBarWithBackButton(Size size) {
    return PreferredSize(
      preferredSize: Size(size.width, kToolbarHeight),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 20),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: Hero(
            tag: 'nikeLogo',
            child: Image.asset(
              AppAssets.nikeLogo,
              width: 60,
            ),
          ),
          actions: [
            Hero(
              tag: 'searchIcon',
              child: Image.asset(
                AppAssets.searchIcon,
                width: 18,
                height: 18,
                // fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Hero(
              tag: 'cartIcon',
              child: Image.asset(
                AppAssets.cartIcon,
                width: 16,
                height: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
