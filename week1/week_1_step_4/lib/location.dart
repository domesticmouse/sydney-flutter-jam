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
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/cupertino.dart';
import 'package:transparent_image/transparent_image.dart';
import './configuration.dart';

// See https://medium.com/flutter-io/some-options-for-deserializing-json-with-flutter-7481325a4450
// for detail on how to use json_serializable with Flutter.

part 'location.g.dart';

@JsonSerializable()
class Offices {
  const Offices({
    this.offices,
  });

  factory Offices.fromJson(Map<String, dynamic> json) =>
      _$OfficesFromJson(json);

  final List<Location> offices;

  Map<String, dynamic> toJson() => _$OfficesToJson(this);

  @override
  String toString({DiagnosticLevel minLevel}) => json.encode(toJson());
}

@JsonSerializable()
class Location extends StatelessWidget {
  const Location({
    this.address,
    this.id,
    this.image,
    this.lat,
    this.lng,
    this.name,
    this.phone,
    this.region,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  final String address;
  final String id;
  final String image;
  final double lat;
  final double lng;
  final String name;
  final String phone;
  final String region;

  @override
  Widget build(BuildContext context) => SafeArea(
        top: false,
        bottom: false,
        minimum: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  child: const Center(child: CupertinoActivityIndicator()),
                  width: 100.0,
                  height: 100.0,
                ),
                Container(
                  child: Center(
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: image,
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
                    style: const TextStyle(
                      fontSize: titleTextSize,
                      color: titleColor,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 4.0),
                  ),
                  DefaultTextStyle(
                    child: Text(address),
                    style: const TextStyle(
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

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  @override
  String toString({DiagnosticLevel minLevel}) => json.encode(toJson());
}
