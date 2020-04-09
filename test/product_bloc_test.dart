import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:is_app/blocs/product/product_bloc.dart';
import 'package:is_app/blocs/product/product_event.dart';
import 'package:is_app/blocs/product/product_state.dart';
import 'package:is_app/data/product_repository.dart';
import 'package:is_app/models/product.dart';
import 'package:mockito/mockito.dart';

class MockProductRepository extends Mock implements ProductRepository {}

class MockProductBloc extends MockBloc<ProductEvent, ProductState>
    implements ProductBloc {
  ProductRepository productRepository;

  MockProductBloc(this.productRepository);
}

void main() {
  group('Products Bloc', () {
    ProductRepository productRepository;
    ProductBloc productBloc;
    List<Product> products = [
      Product(
          id: 1,
          frameSize: "M",
          category: "Mountain",
          location: "Stuttgard",
          name: "Bicycle",
          priceRange: "Normal",
          description: "Nice bike",
          photoUrl: "url")
    ];
    Product product = Product(
        id: 2,
        frameSize: "M",
        category: "Mountain",
        location: "Stuttgard",
        name: "Bicycle",
        priceRange: "Normal",
        description: "Nice bike",
        photoUrl: "url");
    Product updatedProduct = Product(
        id: 2,
        frameSize: "M",
        category: "Mountain",
        location: "Stuttgard",
        name: "Updated Bicycle",
        priceRange: "Normal",
        description: "Nice bike",
        photoUrl: "url");

    setUp(() {
      productRepository = MockProductRepository();
      productBloc = ProductBloc(productRepository);
    });

    blocTest<ProductBloc, ProductEvent, ProductState>(
      'should emit ProductsLoadSuccess if repository throws',
      build: () {
        when(productRepository.loadData())
            .thenAnswer((_) => Future.value(products));
        return productBloc;
      },
      act: (ProductBloc bloc) async => bloc.add(LoadProducts()),
      expect: <ProductState>[
        ProductsLoadInProgress(),
        ProductsLoadSuccess(products)
      ],
    );

    blocTest<ProductBloc, ProductEvent, ProductState>(
      'should emit ProductsLoadFailure if repository throws',
      build: () {
        when(productRepository.loadData()).thenThrow(Exception());
        return productBloc;
      },
      act: (ProductBloc bloc) async => bloc.add(LoadProducts()),
      expect: <ProductState>[ProductsLoadInProgress(), ProductsLoadFailure()],
    );

    blocTest<ProductBloc, ProductEvent, ProductState>(
      'should emit ProductsLoadSuccess and add new product to list',
      build: () {
        when(productRepository.loadData()).thenAnswer((_) => Future.value([]));
        return productBloc;
      },
      act: (ProductBloc bloc) async =>
          bloc..add(LoadProducts())..add(AddProduct(product)),
      expect: <ProductState>[
        ProductsLoadInProgress(),
        ProductsLoadSuccess([]),
        ProductsLoadSuccess([product])
      ],
    );

    blocTest<ProductBloc, ProductEvent, ProductState>(
      'should emit ProductsLoadSuccess and delete the product from list',
      build: () {
        when(productRepository.loadData())
            .thenAnswer((_) => Future.value([product]));
        return productBloc;
      },
      act: (ProductBloc bloc) async =>
          bloc..add(LoadProducts())..add(DeleteProduct(product)),
      expect: <ProductState>[
        ProductsLoadInProgress(),
        ProductsLoadSuccess([product]),
        ProductsLoadSuccess([])
      ],
    );

    blocTest<ProductBloc, ProductEvent, ProductState>(
      'should emit ProductsLoadSuccess and update the product',
      build: () {
        when(productRepository.loadData())
            .thenAnswer((_) => Future.value([product]));
        return productBloc;
      },
      act: (ProductBloc bloc) async =>
          bloc..add(LoadProducts())..add(UpdateProduct(updatedProduct)),
      expect: <ProductState>[
        ProductsLoadInProgress(),
        ProductsLoadSuccess([product]),
        ProductsLoadSuccess([updatedProduct])
      ],
    );

    tearDown(() {
      productBloc?.close();
    });
  });
}
