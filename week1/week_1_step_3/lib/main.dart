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

void main() => runApp(new MyApp(http.Client()));

class MyApp extends StatefulWidget {
  MyApp(this._client);
  final http.Client _client;

  @override
  State<StatefulWidget> createState() => _MyAppState(_client);
}

class _MyAppState extends State<StatefulWidget> {
  List<Location> locations = [];
  _MyAppState(http.Client client) {
    init(client);
  }

  Future init(http.Client client) async {
    final response =
        await client.get('https://google.com/about/static/data/locations.json');

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      List<dynamic> officesJson = json.decode(response.body)['offices'];
      List<Location> locations = [];
      for (var i = 0; i < officesJson.length; i++) {
        locations.add(Location.fromJson(officesJson[i]));
      }
      setState(() => this.locations = locations);
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new MyHomePage(
        title: 'Hello Sydney Flutterers',
        locations: locations,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;
  final List<Location> locations;

  MyHomePage({
    this.title,
    this.locations,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) => locations[index],
      ),
    );
  }
}

class Location extends StatelessWidget {
  final String name;
  final String address;
  Location({this.name, this.address});
  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(name), subtitle: Text(address));
  }

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      address: json['address'],
    );
  }
}

