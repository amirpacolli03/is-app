import 'dart:io';

import 'package:flutter/material.dart';
import 'package:is_app/models/product.dart';
import 'package:is_app/utils/style.dart';
import 'package:is_app/widgets/custom_image.dart';

class CreateUpdateProductScreenImage extends StatelessWidget {
  const CreateUpdateProductScreenImage({
    Key key,
    @required File image,
    @required this.product,
  })  : _image = image,
        super(key: key);

  final File _image;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 325,
      decoration: BoxDecoration(
        color: AppStyle.mainAppColor.withOpacity(0.2),
        border: Border.all(color: AppStyle.mainAppColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: _image != null || product.photoUrl != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  CustomImage(
                    url: _image != null ? _image.path : product.photoUrl,
                    isFromLocalStorage:
                        _image != null ? true : product.isFromLocalStorage,
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(30),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(100)),
                      child: Icon(Icons.create),
                    ),
                  )
                ],
              ),
            )
          : Icon(
              Icons.add,
              size: 50,
              color: Colors.black,
            ),
    );
  }
}
