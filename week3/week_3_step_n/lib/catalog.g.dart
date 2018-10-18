/*
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatalogItem _$CatalogItemFromJson(Map<String, dynamic> json) {
  return CatalogItem(
      name: json['name'] as String,
      categories:
          (json['categories'] as List)?.map((e) => e as String)?.toList(),
      subcategories:
          (json['subcategories'] as List)?.map((e) => e as String)?.toList(),
      description: json['description'] as String,
      link: json['link'] as String,
      image: json['image'] as String);
}

Map<String, dynamic> _$CatalogItemToJson(CatalogItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'categories': instance.categories,
      'subcategories': instance.subcategories,
      'description': instance.description,
      'link': instance.link,
      'image': instance.image
    };
