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
import './recipe.dart';

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
