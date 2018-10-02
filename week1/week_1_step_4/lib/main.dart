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
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';
import './configuration.dart';

void main() => runApp(new MyApp(http.Client()));

class MyApp extends StatefulWidget {
  final http.Client client;
  MyApp(this.client);
  @override
  State<StatefulWidget> createState() => _MyAppState(client);
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
    String title = 'Hi Sydney Flutterers';
    return new CupertinoApp(
      title: 'Flutter iOS Demo',
      debugShowCheckedModeBanner: false,
      home: CupertinoPageScaffold(
          child: DecoratedBox(
        decoration: const BoxDecoration(color: backgroundColor),
        child: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text(title),
            ),
            SliverSafeArea(
              top: false,
              sliver: SliverList(
                delegate: SliverChildListDelegate(divideTiles(
                  tiles: locations,
                  color: borderColor,
                )),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class Location extends StatelessWidget {
  final String name;
  final String address;
  final String imageURL;
  Location({
    Key key,
    this.name,
    this.address,
    this.imageURL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      minimum: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                child: Center(child: CupertinoActivityIndicator()),
                width: 100.0,
                height: 100.0,
              ),
              Container(
                child: Center(
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: imageURL,
                    width: 100.0,
                  ),
                ),
                width: 100.0,
                height: 100.0,
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(right: 8.0),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(top: 8.5)),
                DefaultTextStyle(
                  child: Text(name),
                  style: TextStyle(
                    fontSize: titleTextSize,
                    color: titleColor,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 4.0),
                ),
                DefaultTextStyle(
                  child: Text(address),
                  style: TextStyle(
                    fontSize: subtitleTextSize,
                    letterSpacing: -0.2,
                    color: subtitleColor,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 6.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      address: json['address'],
      imageURL: json['image'],
    );
  }
}

class Divider extends StatelessWidget {
  /// Creates a material design divider.
  ///
  /// The height must be positive.
  const Divider({
    Key key,
    this.height = 16.0,
    this.indent = 0.0,
    this.color = const Color(0xFF000000),
  })  : assert(height >= 0.0),
        assert(color != null),
        super(key: key);

  /// The divider's vertical extent.
  ///
  /// The divider itself is always drawn as one device pixel thick horizontal
  /// line that is centered within the height specified by this value.
  ///
  /// A divider with a height of 0.0 is always drawn as a line with a height of
  /// exactly one device pixel, without any padding around it.
  final double height;

  /// The amount of empty space to the left of the divider.
  final double indent;

  /// The color to use when painting the line.
  ///
  /// ## Sample code
  ///
  /// ```dart
  /// Divider(
  ///   color: Colors.deepOrange,
  /// )
  /// ```
  final Color color;

  static BorderSide createBorderSide(BuildContext context,
      {Color color, double width = 0.0}) {
    assert(width != null);
    assert(color != null);
    return BorderSide(
      color: color,
      width: width,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Center(
        child: Container(
          height: 0.0,
          margin: EdgeInsetsDirectional.only(start: indent),
          decoration: BoxDecoration(
            border: Border(
              bottom: createBorderSide(context, color: color),
            ),
          ),
        ),
      ),
    );
  }
}

/// Add a one pixel border in between each tile.
Iterable<Widget> divideTiles({
  @required Iterable<Widget> tiles,
  @required Color color,
}) {
  assert(tiles != null);
  assert(color != null);
  var result = <Widget>[];

  final Iterator<Widget> iterator = tiles.iterator;
  bool first = true;

  while (iterator.moveNext()) {
    if (first) {
      first = false;
    } else {
      result.add(Divider(
        color: color,
        indent: 16.0,
        height: 4.0,
      ));
    }
    result.add(iterator.current);
  }

  return result;
}
