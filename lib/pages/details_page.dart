import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shoe_app/data/shoe_model.dart';

import '../const/asset_const.dart';

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
      body: SingleChildScrollView(
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
          ],
        ),
      )),
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
