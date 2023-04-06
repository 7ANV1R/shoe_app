import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shoe_app/data/shoe_model.dart';

class HomePage extends StatefulHookConsumerWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> with SingleTickerProviderStateMixin {
  PageController pageController = PageController();
  late AnimationController animationController;
  double currentPage = 0.0;

  @override
  void initState() {
    pageController.addListener(pageListener);
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    super.initState();
  }

  pageListener() {
    setState(() {
      currentPage = pageController.page!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isShowingDetailsPage = useState(false);
    ThemeData themeData = Theme.of(context);
    return Theme(
      data: ThemeData.light(),
      child: Scaffold(
        appBar: !isShowingDetailsPage.value
            ? AppBar(
                title: GestureDetector(
                  onTap: () {
                    animationController.reverse();
                  },
                  child: const Text(
                    'Shoe',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                backgroundColor: Colors.transparent,
                centerTitle: true,
                elevation: 0,
              )
            : null,
        body: Column(
          children: [
            const SizedBox(
              height: kToolbarHeight,
            ),
            Expanded(
              flex: 4,
              child: PageView.builder(
                controller: pageController,
                physics:
                    isShowingDetailsPage.value ? const NeverScrollableScrollPhysics() : const ScrollPhysics(),
                itemCount: Shoe.productList.length,
                itemBuilder: (context, index) {
                  final value = (currentPage - index).abs();
                  final scale = 1 - value.clamp(0, 0.2).toDouble();
                  final opacity = 1 - value.clamp(0, 1);

                  log('scale $scale');

                  Shoe item = Shoe.productList[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 10,
                        child: Container(
                          clipBehavior: Clip.none,
                          child: AnimatedBuilder(
                              animation: animationController,
                              builder: (context, snapshot) {
                                final valueAnimation = Curves.linear.transform(animationController.value);

                                return Opacity(
                                  opacity: opacity.toDouble(),
                                  child: Image.asset(
                                    item.img,
                                  )
                                      .animate()
                                      .scaleXY(
                                        end: scale,
                                      )
                                      .rotate(
                                        begin: 0 * valueAnimation,
                                        end: -0.09 * valueAnimation,
                                      ),
                                );
                              }),
                        ),
                      ),

                      /// [Boat Name and company]
                      if (isShowingDetailsPage.value != true)
                        Column(
                          children: [
                            Text(
                              item.name,
                              style: themeData.textTheme.titleLarge,
                            ),
                            Text(
                              '\$ ${item.price}',
                              style: themeData.textTheme.labelLarge,
                            ),
                          ],
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonNextPage extends StatelessWidget {
  const ButtonNextPage({
    Key? key,
    required bool isDark,
    required this.animationController,
    required this.ontap,
  })  : _isDark = isDark,
        super(key: key);

  final bool _isDark;
  final AnimationController animationController;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
          child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent, shadowColor: Colors.transparent, elevation: 0),
        onPressed: ontap,
        child: Text(
          'SPEC >',
          style: TextStyle(
            color: _isDark ? const Color(0xff63FFDA) : Colors.blue,
            fontSize: 20,
          ),
        ),
      )),
    );
  }
}
