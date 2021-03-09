import 'package:appboy/providers/store_provider.dart';
import 'package:appboy/widget/vendorCategory.dart';
import 'package:appboy/widget/vendor_appbar.dart';
import 'package:appboy/widget/vendor_banner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VendorHomeScreen extends StatelessWidget {
  static const String id = 'vendor-screen';

  @override
  Widget build(BuildContext context) {
    var _store = Provider.of<StoreProvider>(context);

    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                VendorAppBar(),
              ];
            },
            body: Column(
              children: [
                VendorBanner(),
                VendorCategories(),
              ],
            )));
  }
}
