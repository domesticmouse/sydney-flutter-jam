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

import 'package:flutter/material.dart';
import './recipe_api/api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.orange),
        home: MyHomePage(title: 'Flutter Food'),
      );
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title})
      : _futureResponse = FlutterRecipeApi.listRecipes(),
        super(key: key);

  final String title;
  final Future<List<RecipeHeader>> _futureResponse;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: FutureBuilder<List<RecipeHeader>>(
          future: _futureResponse,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return ListView.builder(
                  itemBuilder: (context, index) =>
                      RecipeHeaderWidget(snapshot.data[index]),
                  itemCount: snapshot.data.length,
                );
              case ConnectionState.waiting:
                // TODO(DomesticMouse): Loading spinner
                return const Text('Loading');
              default:
                return const Text('');
            }
          },
        ),
      );
}
