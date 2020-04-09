// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    id: json['id'] as int,
    frameSize: json['frameSize'] as String,
    category: json['category'] as String,
    location: json['location'] as String,
    name: json['name'] as String,
    photoUrl: json['photoUrl'] as String,
    priceRange: json['priceRange'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'frameSize': instance.frameSize,
      'category': instance.category,
      'location': instance.location,
      'name': instance.name,
      'photoUrl': instance.photoUrl,
      'priceRange': instance.priceRange,
      'description': instance.description,
    };
