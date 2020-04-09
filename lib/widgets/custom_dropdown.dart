import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:is_app/blocs/product/product_bloc.dart';
import 'package:is_app/blocs/product/product_event.dart';
import 'package:is_app/models/product.dart';
import 'package:is_app/utils/routes.dart';

class CustomDropDown extends StatefulWidget {
  final Product product;

  CustomDropDown(this.product) : super(key: UniqueKey());

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

enum ProductActions { delete, update }

class _CustomDropDownState extends State<CustomDropDown> {
  List<String> dropdownOptions = ["Delete", "Update"];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PopupMenuButton<ProductActions>(
        padding: EdgeInsets.only(top: 20),
        captureInheritedThemes: true,
        icon: Icon(Icons.more_vert),
        onSelected: (ProductActions result) {
          if (result == ProductActions.delete) {
            BlocProvider.of<ProductBloc>(context)
                .add(DeleteProduct(widget.product));
          } else {
            Navigator.pushNamed(
              context,
              Routes.createUpdateProductScreen,
              arguments: widget.product,
            );
          }
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<ProductActions>>[
          PopupMenuItem<ProductActions>(
            value: ProductActions.delete,
            child: Text(dropdownOptions[0]),
          ),
          PopupMenuItem<ProductActions>(
            value: ProductActions.update,
            child: Text(dropdownOptions[1]),
          ),
        ],
      ),
    );
  }
}
