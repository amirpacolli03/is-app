import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:is_app/models/product.dart';
import 'package:is_app/utils/style.dart';

import 'custom_dropdown.dart';
import 'custom_image.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function onTap;
  final Function moreButtonTap;

  ProductCard({@required this.product, this.onTap, this.moreButtonTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: onTap,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ScreenUtil().setSp(40)),
            ),
            elevation: 3,
            margin: EdgeInsets.symmetric(
                vertical: ScreenUtil().setHeight(25),
                horizontal: ScreenUtil().setWidth(40)),
            child: Padding(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(20),
                  right: 0,
                  top: ScreenUtil().setHeight(25),
                  bottom: ScreenUtil().setHeight(25)),
              child: Container(
                height: ScreenUtil().setHeight(360),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: ScreenUtil().setWidth(400),
                      height: ScreenUtil().setHeight(300),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setSp(30)),
                        child: CustomImage(
                          url: product.photoUrl,
                          isFromLocalStorage: product.isFromLocalStorage,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(50),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                                right: ScreenUtil().setWidth(70)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  product.name ?? "N/A",
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(50),
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Frame Size: ${product.frameSize ?? "N/A"}",
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(35),
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  "Category: ${product.category ?? "N/A"}",
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(35),
                                      fontWeight: FontWeight.w300),
                                ),
                                Text(
                                  "Location: ${product.location ?? "N/A"}",
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(35),
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                          ),
                          Spacer(
                            flex: 3,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: AppStyle.mainAppColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                          ScreenUtil().setSp(20)),
                                      bottomLeft: Radius.circular(
                                          ScreenUtil().setSp(20)),
                                    )),
                                padding:
                                    EdgeInsets.all(ScreenUtil().setHeight(25)),
                                child: Text(
                                  "See More",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400),
                                ),
                              )
                            ],
                          ),
                          Spacer(
                            flex: 1,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment(0.95, 0),
          child: CustomDropDown(product),
        )
      ],
    );
  }
}
