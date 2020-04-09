import 'package:equatable/equatable.dart';
import 'package:is_app/models/product.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadProducts extends ProductEvent {}

class AddProduct extends ProductEvent {
  final Product product;

  AddProduct(this.product);

  @override
  List<Object> get props => [product];
}

class DeleteProduct extends ProductEvent {
  final Product product;

  DeleteProduct(this.product);

  @override
  List<Object> get props => [product];
}

class UpdateProduct extends ProductEvent {
  final Product product;

  UpdateProduct(this.product);

  @override
  List<Object> get props => [product];
}
