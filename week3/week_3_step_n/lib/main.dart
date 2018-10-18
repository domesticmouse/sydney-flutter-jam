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
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:week_3_step_n/catalog.dart';

const String widgetsURL =
    'https://raw.githubusercontent.com/flutter/website/dash/src/_data/catalog/widgets.json';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.pink),
        home: MyHomePage(title: 'Bob\'s Widgets'),
      );
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title})
      : _futureResponse = http.get(widgetsURL),
        super(key: key);

  final String title;
  final Future<http.Response> _futureResponse;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: FutureBuilder<http.Response>(
          future: _futureResponse,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Text('ConnectionState.none');
              case ConnectionState.active:
                return const Text('ConnectionState.active');
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (snapshot.data.statusCode == 200) {
                  print(snapshot.data.body);
                  return ListView(
                      children:
                          // ignore: avoid_as
                          (json.decode(snapshot.data.body) as List<dynamic>)
                              .map((json) => CatalogItem.fromJson(
                                  // ignore: avoid_as
                                  json as Map<String, dynamic>))
                              .toList());
                }
                // We are looking at an error response of some kind.
                return Text(snapshot.data.body);

              case ConnectionState.waiting:
                return const Text('ConnectionState.waiting');
            }
          },
        ),
      );
}
