import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product extends Equatable {
  int id;
  String frameSize;
  String category;
  String location;
  String name;
  String photoUrl;
  String priceRange;
  String description;
  bool isFromLocalStorage;

  Product({
    this.id,
    this.frameSize,
    this.category,
    this.location,
    this.name,
    this.photoUrl,
    this.priceRange,
    this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @override
  List<Object> get props => [
        id,
        frameSize,
        category,
        location,
        name,
        photoUrl,
        priceRange,
        description,
        isFromLocalStorage
      ];
}
