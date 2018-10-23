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
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';

// See https://medium.com/flutter-io/some-options-for-deserializing-json-with-flutter-7481325a4450
// for detail on how to use json_serializable with Flutter.
//
// Tl;dr:
// $ flutter packages pub run build_runner build

part 'api.g.dart';
part 'widgets.dart';

class FlutterRecipeApi {
  static const String _baseUrl =
      'https://flutter-recipe-api.appspot.com/recipes/';

  static Future<List<RecipeHeader>> listRecipes() async {
    final response = await http.get(_baseUrl);
    if (response.statusCode == 200) {
      final recipes = (json.decode(response.body) as List<dynamic>)
          .map((r) => RecipeHeader.fromJson(r as Map<String, dynamic>))
          .toList();
      print('Recipes: $recipes');
      return recipes;
    }

    print('Retrieving recipes failed: ${response.reasonPhrase}');
    throw FlutterApiException(
        'Could not retrieve Recipes: ${response.reasonPhrase}');
  }

  static Future<Recipe> getRecipe(int id) async {
    final response = await http.get('$_baseUrl$id');
    if (response.statusCode == 200) {
      final recipe = Recipe.fromJson(
          json.decode(response.body) as Map<String, dynamic>);
      print('Recipe: $recipe');
      return recipe;
    }

    print('Retrieving recipes failed: ${response.reasonPhrase}');
    throw FlutterApiException(
        'Could not retrieve Recipe $id: ${response.reasonPhrase}');
  }
}

class FlutterApiException implements Exception {
  FlutterApiException(this.cause);
  final String cause;
}

@JsonSerializable(fieldRename: FieldRename.snake)
class RecipeHeader {
  const RecipeHeader({
    this.id,
    this.name,
    this.shortDescription,
    this.imageId,
  });

  factory RecipeHeader.fromJson(Map<String, dynamic> json) =>
      _$RecipeHeaderFromJson(json);

  final int id;
  final String name;
  final String shortDescription;
  final String imageId;

  Map<String, dynamic> toJson() => _$RecipeHeaderToJson(this);

  @override
  String toString({DiagnosticLevel minLevel}) => json.encode(toJson());
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Recipe {
  const Recipe({
    this.id,
    this.name,
    this.shortDescription,
    this.imageId,
    this.ingredients,
    this.preparation,
    this.cooking,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => _$RecipeFromJson(json);

  final int id;
  final String name;
  final String shortDescription;
  final String imageId;
  final List<Ingredient> ingredients;
  final List<Step> preparation;
  final List<Step> cooking;

  Map<String, dynamic> toJson() => _$RecipeToJson(this);

  @override
  String toString({DiagnosticLevel minLevel}) => json.encode(toJson());
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Ingredient {
  const Ingredient({
    this.quantity,
    this.ingredient,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

  final String quantity;
  final String ingredient;

  Map<String, dynamic> toJson() => _$IngredientToJson(this);

  @override
  String toString({DiagnosticLevel minLevel}) => json.encode(toJson());
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Step {
  const Step({this.step});

  factory Step.fromJson(Map<String, dynamic> json) => _$StepFromJson(json);

  final String step;

  Map<String, dynamic> toJson() => _$StepToJson(this);

  @override
  String toString({DiagnosticLevel minLevel}) => json.encode(toJson());
}
