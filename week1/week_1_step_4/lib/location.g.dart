// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Offices _$OfficesFromJson(Map<String, dynamic> json) {
  return Offices(
      offices: (json['offices'] as List)
          ?.map((e) =>
              e == null ? null : Location.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$OfficesToJson(Offices instance) =>
    <String, dynamic>{'offices': instance.offices};

Location _$LocationFromJson(Map<String, dynamic> json) {
  return Location(
      address: json['address'] as String,
      id: json['id'] as String,
      image: json['image'] as String,
      lat: (json['lat'] as num)?.toDouble(),
      lng: (json['lng'] as num)?.toDouble(),
      name: json['name'] as String,
      phone: json['phone'] as String,
      region: json['region'] as String);
}

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'address': instance.address,
      'id': instance.id,
      'image': instance.image,
      'lat': instance.lat,
      'lng': instance.lng,
      'name': instance.name,
      'phone': instance.phone,
      'region': instance.region
    };
