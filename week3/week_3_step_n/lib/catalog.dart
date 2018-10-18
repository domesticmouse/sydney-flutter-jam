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

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// See https://medium.com/flutter-io/some-options-for-deserializing-json-with-flutter-7481325a4450
// for detail on how to use json_serializable with Flutter.
//
// Tl;dr:
// $ flutter packages pub run build_runner build

part 'catalog.g.dart';

@JsonSerializable()
class CatalogItem extends StatelessWidget {
  const CatalogItem({
    this.name,
    this.categories,
    this.subcategories,
    this.description,
    this.link,
    this.image,
  });

  factory CatalogItem.fromJson(Map<String, dynamic> json) =>
      _$CatalogItemFromJson(json);

  final String name;
  final List<String> categories;
  final List<String> subcategories;
  final String description;
  final String link;
  final String image;

  Map<String, dynamic> toJson() => _$CatalogItemToJson(this);

  @override
  String toString({DiagnosticLevel minLevel}) => json.encode(toJson());

  @override
  Widget build(BuildContext context) => ListTile(
        leading: SvgPicture.string(
          image,
          width: 55,
          height: 55,
        ),
        title: Text(name),
        subtitle: Text(description),
      );
}
