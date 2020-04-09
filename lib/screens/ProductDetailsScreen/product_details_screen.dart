import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:is_app/blocs/product/product_bloc.dart';
import 'package:is_app/blocs/product/product_event.dart';
import 'package:is_app/models/product.dart';
import 'package:is_app/utils/app_strings.dart';
import 'package:is_app/utils/routes.dart';
import 'package:is_app/utils/style.dart';
import 'package:is_app/widgets/custom_button.dart';
import 'package:is_app/widgets/custom_image.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            constraints: BoxConstraints(
              maxHeight: 450,
            ),
            child: CustomImage(
              url: product.photoUrl,
              isFromLocalStorage: product.isFromLocalStorage,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(50),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  product.name ?? "N/A",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(65),
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Description:",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(55),
                      fontWeight: FontWeight.w300),
                ),
                Text(
                  product.description ?? "N/A",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(50),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                _multiStyleTextWidget("price", product.priceRange),
                _multiStyleTextWidget("frame_size", product.frameSize),
                _multiStyleTextWidget("category", product.category),
                _multiStyleTextWidget("location", product.location),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: CustomButton(
                        onPressed: () {
                          _onUpdateButtonPressed(context);
                        },
                        text: AppStrings.translateKeys("update"),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: CustomButton(
                        onPressed: () {
                          _onDeleteButtonPressed(context);
                        },
                        text: AppStrings.translateKeys("delete"),
                        buttonColor: Colors.white,
                        textColor: AppStyle.mainAppColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _multiStyleTextWidget(String key, String value) {
    return Container(
      padding: EdgeInsets.only(top: 5),
      child: Row(
        children: <Widget>[
          Text(
            AppStrings.translateKeys(key) + ": ",
            style: TextStyle(
                fontSize: ScreenUtil().setSp(55), fontWeight: FontWeight.w300),
          ),
          Text(
            value ?? "N/A",
            style: TextStyle(
              fontSize: ScreenUtil().setSp(55),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _onUpdateButtonPressed(context) {
    Navigator.pushNamed(context, Routes.createUpdateProductScreen,
        arguments: product);
  }

  void _onDeleteButtonPressed(context) {
    BlocProvider.of<ProductBloc>(context).add(DeleteProduct(product));
    Navigator.pop(context);
  }
}
