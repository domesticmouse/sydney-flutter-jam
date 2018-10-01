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

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new MyHomePage(title: 'Hello Sydney Flutterers'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  // A couple of Google office locations from
  // https://www.google.com/about/locations/
  final List<Location> locations = <Location>[
    Location(
      name: "Ann Arbor",
      address: "2300 Traverwood Drive, Ann Arbor, MI 48105, United States",
    ),
    Location(
      name: "Atlanta",
      address: "10 10th Street NE, Atlanta, GA 30309, United States",
    ),
    Location(
      name: "Sydney",
      address: "48 Pirrama Road, Sydney, NSW 2009, Australia",
    ),
  ];

  MyHomePage({this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        // https://flutter.io/cookbook/lists/basic-list/
        child: ListView(
          children: locations,
        ),
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
}
