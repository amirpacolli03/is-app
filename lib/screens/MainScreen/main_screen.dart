import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:is_app/blocs/product/product_bloc.dart';
import 'package:is_app/blocs/product/product_event.dart';
import 'package:is_app/blocs/product/product_state.dart';
import 'package:is_app/models/product.dart';
import 'package:is_app/utils/app_strings.dart';
import 'package:is_app/utils/routes.dart';
import 'package:is_app/utils/style.dart';
import 'package:is_app/widgets/product_card.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppStrings.translateKeys("app_name"),
          style: TextStyle(fontSize: 22, color: AppStyle.mainAppColor),
        ),
        elevation: 0.5,
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, ProductState state) {
          if (state is ProductsLoadInProgress) {
            return _loadingWidget();
          } else if (state is ProductsLoadSuccess) {
            return _buildProductsList(context, state);
          } else if (state is ProductsLoadFailure) {
            return _errorWidget();
          }
          return _errorWidget();
        },
      ),
      floatingActionButton: Container(
        width: ScreenUtil().setHeight(170),
        height: ScreenUtil().setHeight(170),
        child: FloatingActionButton(
          backgroundColor: AppStyle.mainAppColor,
          onPressed: () {
            Navigator.pushNamed(
              context,
              Routes.createUpdateProductScreen,
            );
          },
          child: Icon(
            Icons.add,
            size: ScreenUtil().setSp(120),
          ),
        ),
      ),
    );
  }

  Widget _buildProductsList(context, ProductsLoadSuccess state) {
    return Container(
      child: ListView.builder(
        itemCount: state.products.length,
        itemBuilder: (context, index) {
          Product product = state.products[index];
          return ProductCard(
            product: product,
            onTap: () {
              Navigator.pushNamed(context, Routes.productDetailsScreen,
                  arguments: product);
            },
            moreButtonTap: () {
              BlocProvider.of<ProductBloc>(context).add(DeleteProduct(product));
            },
          );
        },
      ),
    );
  }

  Widget _loadingWidget() {
    return Center(
      child: SizedBox(
        height: ScreenUtil().setHeight(200),
        width: ScreenUtil().setHeight(200),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppStyle.mainAppColor),
        ),
      ),
    );
  }

  Widget _errorWidget() {
    return Center(
      child: Text(
        AppStrings.translateKeys("error_message"),
        style: TextStyle(
          fontSize: ScreenUtil().setSp(40),
          color: AppStyle.mainAppColor,
        ),
      ),
    );
  }
}
