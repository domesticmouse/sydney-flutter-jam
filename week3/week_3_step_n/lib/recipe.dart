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
import './flutter_food_api.dart';

// See https://medium.com/flutter-io/some-options-for-deserializing-json-with-flutter-7481325a4450
// for detail on how to use json_serializable with Flutter.
//
// Tl;dr:
// $ flutter packages pub run build_runner build

part 'recipe.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RecipeHeader extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(name),
        subtitle: Text(shortDescription),
        onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Scaffold(
                      appBar: AppBar(
                        title: Text(name),
                      ),
                      body: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: FutureBuilder(
                              future: FlutterRecipeApi.getRecipe(id),
                              builder: (context, snapshot) =>
                                  Text(snapshot.connectionState.toString()),
                            ),
                          ),
                        ],
                      ),
                    ),
              ),
            ),
      );

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
    this.measure,
    this.ingredient,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

  final int quantity;
  final String measure;
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
