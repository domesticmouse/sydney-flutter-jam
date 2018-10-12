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
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:week_1_step_4/main.dart';
import 'package:week_1_step_4/location.dart';

// Create a MockClient using the Mock class provided by the Mockito package.
class MockClient extends Mock implements http.Client {}

void main() {
  testWidgets('Content display', (tester) async {
    final mockClient = MockClient();
    final locations = <Location>[
      const Location(
        address: 'Aabogade 15\n8200 Aarhus\nDenmark',
        id: 'aarhus',
        image:
            'https://lh3.googleusercontent.com/tpBMFN5os8K-qXIHiAX5SZEmN5fCzIGrj9FdJtbZPUkC91ookSoY520NYn7fK5yqmh1L1m3F2SJA58v6Qps3JusdrxoFSwk6Ajv2K88',
        lat: 56.172249,
        lng: 10.187372,
        name: 'Aarhus',
        phone: '',
        region: 'europe',
      ),
      const Location(
        address: 'Claude Debussylaan 34\n1082 MD, Amsterdam\nNetherlands',
        id: 'amsterdam',
        image:
            'https://lh3.googleusercontent.com/gG1zKXcSmRyYWHwUn2Z0MITpdqwb52RAEp3uthG2J5Xl-4_Wz7_WmoM6T_TBg6Ut3L1eF-8XENO10sxVIFdQHilj8iRG29wROpSoug',
        lat: 52.337801,
        lng: 4.872066,
        name: 'Amsterdam',
        phone: '',
        region: 'europe',
      ),
      const Location(
        address: '48 Pirrama Road\nSydney, NSW 2009\nAustralia ',
        id: 'sydney',
        image:
            'https://lh3.googleusercontent.com/03Hp4ZwQHs_rWLEWQtrOc62hEHzffD_uoZFCbo56eoeLyZ3L89-Fy5Dd8WcmrGFGK31QC_hZqzuU7f9QhxqjckE7BSLo_arwWjCH1w',
        lat: -33.866638,
        lng: 151.195672,
        name: 'Sydney',
        phone: '+61 2 9374 4000',
        region: 'asia-pacific',
      ),
    ];
    final offices = Offices(offices: locations);
    final locationJson = json.encode(offices.toJson());

    // Use Mockito to return a successful response when it calls the
    // provided http.Client
    when(mockClient.get('https://google.com/about/static/data/locations.json'))
        .thenAnswer((_) async => http.Response(locationJson, 200));

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(mockClient));
    // Keep drawing frames until our list of offices has settled.
    await tester.pumpAndSettle();

    // Verify that we are displaying our Aarhus office.
    expect(find.text('Aarhus'), findsOneWidget);
    // Also verify Sydey is on page.
    expect(find.text('Sydney'), findsOneWidget);
  });
}
