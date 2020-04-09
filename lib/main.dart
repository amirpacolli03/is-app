import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:is_app/blocs/product/product_event.dart';
import 'package:is_app/data/product_repository.dart';
import 'package:is_app/screens/MainScreen/main_screen.dart';
import 'package:is_app/utils/routes.dart';
import 'package:is_app/utils/style.dart';

import 'blocs/product/product_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) {
        return ProductBloc(ProductRepository())..add(LoadProducts());
      },
      child: ISApp(),
    ),
  );
}

class ISApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppStyle.appTheme,
      home: MainScreen(),
      routes: Routes.routesMap(context),
    );
  }
}
