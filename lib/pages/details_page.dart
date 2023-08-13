import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../const/asset_const.dart';

class DetailsPage extends StatefulHookConsumerWidget {
  const DetailsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DetailsPageState();
}

class _DetailsPageState extends ConsumerState<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: nikeAppBarWithBackButton(size),
      body: const Placeholder(),
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
