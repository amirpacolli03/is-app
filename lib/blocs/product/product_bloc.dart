import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:is_app/data/product_repository.dart';
import 'package:is_app/models/product.dart';

import './bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc(this.productRepository);

  @override
  ProductState get initialState => ProductsLoadInProgress();

  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    if (event is LoadProducts) {
      yield* _mapProductsLoadedToState();
    } else if (event is AddProduct) {
      yield* _mapProductAddedToState(event);
    } else if (event is UpdateProduct) {
      yield* _mapProductUpdatedToState(event);
    } else if (event is DeleteProduct) {
      yield* _mapProductDeletedToState(event);
    }
  }

  Stream<ProductState> _mapProductsLoadedToState() async* {
    try {
      List<Product> products = await productRepository.loadData();
      yield ProductsLoadSuccess(products);
    } catch (e) {
      yield ProductsLoadFailure();
    }
  }

  Stream<ProductState> _mapProductAddedToState(AddProduct event) async* {
    if (state is ProductsLoadSuccess) {
      final List<Product> products =
          List.from((state as ProductsLoadSuccess).products)
            ..add(event.product);
      yield ProductsLoadSuccess(products);
    }
  }

  Stream<ProductState> _mapProductUpdatedToState(UpdateProduct event) async* {
    if (state is ProductsLoadSuccess) {
      List<Product> products = List.from(
        (state as ProductsLoadSuccess).products.map((product) {
          return product.id == event.product.id ? event.product : product;
        }),
      );

      yield ProductsLoadSuccess(products);
    }
  }

  Stream<ProductState> _mapProductDeletedToState(DeleteProduct event) async* {
    if (state is ProductsLoadSuccess) {
      final List<Product> products =
          List.from((state as ProductsLoadSuccess).products)
            ..remove(event.product);

      yield ProductsLoadSuccess(products);
    }
  }
}
