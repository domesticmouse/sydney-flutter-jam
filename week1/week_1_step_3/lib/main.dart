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

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './location.dart';

void main() => runApp(MyApp(http.Client()));

class MyApp extends StatefulWidget {
  const MyApp(this._client);
  final http.Client _client;

  @override
  State<StatefulWidget> createState() => _MyAppState(_client);
}

class _MyAppState extends State<StatefulWidget> {
  _MyAppState(http.Client client) {
    init(client);
  }
  List<Location> locations = [];

  Future init(http.Client client) async {
    final response =
        await client.get('https://google.com/about/static/data/locations.json');

    if (response.statusCode == 200) {
      final offices =
          Offices.fromJson(json.decode(response.body) as Map<String, dynamic>);
      setState(() {
        locations = offices.offices;
      });
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.red),
        home: MyHomePage(
          title: 'Hello Sydney Flutterers',
          locations: locations,
        ),
      );
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({this.title, this.locations});
  final String title;
  final List<Location> locations;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(children: locations),
    );
  }
}
