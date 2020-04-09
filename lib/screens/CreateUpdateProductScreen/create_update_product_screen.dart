import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:is_app/blocs/product/product_bloc.dart';
import 'package:is_app/blocs/product/product_event.dart';
import 'package:is_app/models/product.dart';
import 'package:is_app/screens/CreateUpdateProductScreen/widgets/image_widget.dart';
import 'package:is_app/utils/app_strings.dart';
import 'package:is_app/utils/style.dart';
import 'package:is_app/utils/validations.dart';
import 'package:is_app/widgets/custom_button.dart';
import 'package:is_app/widgets/custom_form_field.dart';

class CreateUpdateProductScreen extends StatefulWidget {
  final Product product;

  const CreateUpdateProductScreen({
    this.product,
  });

  @override
  _CreateUpdateProductScreenState createState() =>
      _CreateUpdateProductScreenState(product);
}

class _CreateUpdateProductScreenState extends State<CreateUpdateProductScreen> {
  Product product;
  bool isCreate;
  File _image;
  bool imageFieldError = false;

  _CreateUpdateProductScreenState(this.product);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (product == null) {
      product = Product();
      isCreate = true;
    } else {
      isCreate = false;
    }
    super.initState();
  }

  Future<File> getImage(ImageSource imageSource) async {
    return await ImagePicker.pickImage(source: imageSource);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            AppStrings.translateKeys(
                isCreate ? "create_product" : "update_product"),
            style: TextStyle(fontSize: 22, color: Colors.black),
          ),
          automaticallyImplyLeading: true,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Container(
                  width: 55,
                  child: InkWell(
                    onTap: _showAddImageDialog,
                    child: CreateUpdateProductScreenImage(
                        image: _image, product: product),
                  ),
                ),
                imageFieldError
                    ? Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          AppStrings.translateKeys(
                              "uploade_image_validation_error"),
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    : SizedBox(
                        height: 40,
                      ),
                CustomFormField(
                  value: product.name,
                  hintText: AppStrings.translateKeys("product_name"),
                  onSaved: (String value) {
                    product.name = value;
                  },
                  validator: AppValidations.minimumLengthValidation,
                ),
                CustomFormField(
                  value: product.description,
                  hintText: AppStrings.translateKeys("product_description"),
                  maxLines: null,
                  onSaved: (String value) {
                    product.description = value;
                  },
                  validator: AppValidations.descriptionFieldValidation,
                ),
                CustomFormField(
                  value: product.priceRange,
                  hintText: AppStrings.translateKeys("product_price_range"),
                  onSaved: (String value) {
                    product.priceRange = value;
                  },
                  validator: AppValidations.minimumLengthValidation,
                ),
                CustomFormField(
                  value: product.frameSize,
                  hintText: AppStrings.translateKeys("product_frame_size"),
                  onSaved: (String value) {
                    product.frameSize = value;
                  },
                  validator: AppValidations.requiredFieldValidation,
                ),
                CustomFormField(
                  value: product.category,
                  hintText: AppStrings.translateKeys("product_category"),
                  onSaved: (String value) {
                    product.category = value;
                  },
                  validator: AppValidations.minimumLengthValidation,
                ),
                CustomFormField(
                  value: product.location,
                  hintText: AppStrings.translateKeys("product_location"),
                  onSaved: (String value) {
                    product.location = value;
                  },
                  validator: AppValidations.minimumLengthValidation,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  onPressed: _onSaveButtonPressed,
                  text: AppStrings.translateKeys("save"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAddImageDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          backgroundColor: Colors.white,
          title: Text(
            AppStrings.translateKeys("add_image"),
            style: TextStyle(color: AppStyle.mainAppColor),
          ),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () async {
                _image = await getImage(ImageSource.camera);
                setState(() {});
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  AppStrings.translateKeys("camera"),
                  style: TextStyle(color: AppStyle.mainAppColor),
                ),
              ),
            ),
            SimpleDialogOption(
              onPressed: () async {
                _image = await getImage(ImageSource.gallery);
                setState(() {});
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  AppStrings.translateKeys("gallery"),
                  style: TextStyle(color: AppStyle.mainAppColor),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _onSaveButtonPressed() {
    final formState = _formKey.currentState;
    bool imageValidation = _image != null || product.photoUrl != null;

    if (formState.validate() && imageValidation) {
      if (_image != null) {
        product.isFromLocalStorage = true;
        product.photoUrl = _image.path;
      }
      formState.save();

      if (isCreate) {
        product.id = DateTime.now().millisecondsSinceEpoch;
        BlocProvider.of<ProductBloc>(context).add(AddProduct(product));
      } else {
        BlocProvider.of<ProductBloc>(context).add(UpdateProduct(product));
      }

      Navigator.pop(context);
    } else {
      if (!imageValidation) {
        imageFieldError = true;
        setState(() {});
      }
    }
  }
}
