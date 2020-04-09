import 'package:equatable/equatable.dart';
import 'package:is_app/models/product.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductsLoadInProgress extends ProductState {}

class ProductsLoadSuccess extends ProductState {
  final List<Product> products;

  ProductsLoadSuccess(this.products);

  @override
  List<Object> get props => [products];
}

class ProductsLoadFailure extends ProductState {}
