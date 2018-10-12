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

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.red),
        home: MyHomePage(title: 'Hello Sydney Flutterers'),
      );
}

class MyHomePage extends StatelessWidget {
  MyHomePage({this.title});
  final String title;
  final List<Location> locations = <Location>[
    const Location(
      name: 'Ann Arbor',
      address: '2300 Traverwood Drive, Ann Arbor, MI 48105, United States',
    ),
    const Location(
      name: 'Atlanta',
      address: '10 10th Street NE, Atlanta, GA 30309, United States',
    ),
    const Location(
      name: 'Sydney',
      address: '48 Pirrama Road, Sydney, NSW 2009, Australia',
    ),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(title)),
        body: ListView(children: locations),
      );
}

class Location extends StatelessWidget {
  const Location({this.name, this.address});
  final String name;
  final String address;
  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(name),
        subtitle: Text(address),
      );
}
