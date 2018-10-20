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
import 'package:flutter_study_jam_week_2/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('List todos test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(new MyApp());

    expect(find.text('GDG Flutter Sydney'), findsOneWidget);
    expect(find.text('Prepare content for next meetup'), findsOneWidget);
    expect(find.text('Find venue'), findsOneWidget);
    expect(find.text('Organise food'), findsOneWidget);
    expect(find.text('Draft Meetup event'), findsOneWidget);
  });

  testWidgets('Add a todo item test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(new MyApp());

    expect(find.text('What needs to be done?'), findsOneWidget);
    await tester.enterText(find.byKey(Key("todo_input")), "A test todo");
    await tester.tap(find.byIcon(Icons.add));

    await tester.pumpAndSettle();
    expect(find.text("A test todo"), findsOneWidget);
  });
}
