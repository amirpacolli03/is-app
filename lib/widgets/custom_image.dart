import 'dart:io';

import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String url;
  final bool isFromLocalStorage;

  CustomImage({this.url, this.isFromLocalStorage});

  @override
  Widget build(BuildContext context) {
    return _showProductImage();
  }

  Widget _showProductImage() {
    if (isFromLocalStorage == true) {
      return Image.file(
        File(url ?? ""),
        fit: BoxFit.cover,
      );
    } else {
      return Image.network(
        url ?? "",
        fit: BoxFit.cover,
      );
    }
  }
}
