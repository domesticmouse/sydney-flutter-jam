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

part of 'recipe.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeHeader _$RecipeHeaderFromJson(Map<String, dynamic> json) {
  return RecipeHeader(
      id: json['id'] as int,
      name: json['name'] as String,
      shortDescription: json['short_description'] as String,
      imageId: json['image_id'] as String);
}

Map<String, dynamic> _$RecipeHeaderToJson(RecipeHeader instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'short_description': instance.shortDescription,
      'image_id': instance.imageId
    };

Recipe _$RecipeFromJson(Map<String, dynamic> json) {
  return Recipe(
      id: json['id'] as int,
      name: json['name'] as String,
      shortDescription: json['short_description'] as String,
      imageId: json['image_id'] as String,
      ingredients: (json['ingredients'] as List)
          ?.map((e) =>
              e == null ? null : Ingredient.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      preparation: (json['preparation'] as List)
          ?.map((e) =>
              e == null ? null : Step.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      cooking: (json['cooking'] as List)
          ?.map((e) =>
              e == null ? null : Step.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$RecipeToJson(Recipe instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'short_description': instance.shortDescription,
      'image_id': instance.imageId,
      'ingredients': instance.ingredients,
      'preparation': instance.preparation,
      'cooking': instance.cooking
    };

Ingredient _$IngredientFromJson(Map<String, dynamic> json) {
  return Ingredient(
      quantity: json['quantity'] as int,
      measure: json['measure'] as String,
      ingredient: json['ingredient'] as String);
}

Map<String, dynamic> _$IngredientToJson(Ingredient instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'measure': instance.measure,
      'ingredient': instance.ingredient
    };

Step _$StepFromJson(Map<String, dynamic> json) {
  return Step(step: json['step'] as String);
}

Map<String, dynamic> _$StepToJson(Step instance) =>
    <String, dynamic>{'step': instance.step};
