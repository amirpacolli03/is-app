import 'package:flutter/cupertino.dart';
import 'package:is_app/screens/CreateUpdateProductScreen/create_update_product_screen.dart';
import 'package:is_app/screens/MainScreen/main_screen.dart';
import 'package:is_app/screens/ProductDetailsScreen/product_details_screen.dart';

class Routes {
  static String mainScreen = 'main_screen';
  static String productDetailsScreen = 'product_detals_screen';
  static String createUpdateProductScreen = 'create_update_product_screen';

  static Map<String, WidgetBuilder> routesMap(context) {
    return {
      Routes.mainScreen: (context) => MainScreen(),
      Routes.productDetailsScreen: (context) => ProductDetailsScreen(
            product: ModalRoute.of(context).settings.arguments,
          ),
      Routes.createUpdateProductScreen: (context) => CreateUpdateProductScreen(
            product: ModalRoute.of(context).settings.arguments,
          ),
    };
  }
}
