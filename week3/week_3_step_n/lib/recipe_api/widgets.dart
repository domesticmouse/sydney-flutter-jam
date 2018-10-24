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

part of 'api.dart';

class RecipeHeaderWidget extends StatelessWidget {
  const RecipeHeaderWidget(this.recipeHeader);
  final RecipeHeader recipeHeader;

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(recipeHeader.name),
        subtitle: Text(recipeHeader.shortDescription),
        onTap: () => tapHandler(context),
      );

  void tapHandler(BuildContext context) {
    final recipeFuture = FlutterRecipeApi.getRecipe(recipeHeader.id);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
              appBar: AppBar(
                title: Text(recipeHeader.name),
              ),
              body: SafeArea(
                child: FutureBuilder<Recipe>(
                  future: recipeFuture,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const Text('Loading');
                      case ConnectionState.done:
                        return RecipeWidget(snapshot.data);
                      default:
                        return const Text('todo');
                    }
                  },
                ),
              ),
            ),
      ),
    );
  }
}

class RecipeWidget extends StatelessWidget {
  const RecipeWidget(this.recipe);
  final Recipe recipe;

  @override
  Widget build(BuildContext context) => ListView(
        children: <Widget>[
          Text(recipe.shortDescription),
          const Text('Ingredients'),
          Column(
            children: recipe.ingredients
                .map((ingredient) => IngredientListTile(ingredient))
                .toList(),
          ),
          const Text('Preparation steps'),
          Column(
            children: recipe.preparation
                .map((step) => ListTile(title: Text(step.step)))
                .toList(),
          ),
          const Text('Cooking steps'),
          Column(
            children: recipe.cooking
                .map((step) => ListTile(title: Text(step.step)))
                .toList(),
          ),
        ],
      );
}

class IngredientListTile extends StatelessWidget {
  const IngredientListTile(this.ingredient);
  final Ingredient ingredient;
  @override
  Widget build(BuildContext context) => ListTile(
        title: Row(
          children: [
            Text(ingredient.quantity),
            const SizedBox(width: 4),
            Text(ingredient.ingredient),
          ],
        ),
      );
}
