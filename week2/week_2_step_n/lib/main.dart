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
  final String title = 'Todo App';
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: title,
        theme: ThemeData(primarySwatch: Colors.orange),
        home: Scaffold(
          appBar: AppBar(title: Text(title)),
          body: const TodoListWidget(),
        ),
      );
}

class TodoListWidget extends StatefulWidget {
  const TodoListWidget({Key key}) : super(key: key);

  @override
  _TodoListWidgetState createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<TodoListWidget> {
  final List<TodoWidget> _todoWidgets = [
    const TodoWidget(description: 'Get a haircut'),
    const TodoWidget(description: 'Get a real job'),
  ];
  final TextEditingController todoController = TextEditingController();

  void _addTodoItem() {
    setState(() {
      _todoWidgets.add(TodoWidget(description: todoController.text));
      todoController.clear();
      print(_todoWidgets);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 16.0),
                    child: TextField(
                      controller: todoController,
                      decoration: InputDecoration(
                        labelText: 'What would you like to do?',
                        hintText: 'Run away to the circus...',
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _addTodoItem,
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todoWidgets.length,
              itemBuilder: (context, index) => _todoWidgets[index],
            ),
          ),
        ],
      ),
    );
  }
}

class TodoWidget extends StatelessWidget {
  const TodoWidget({Key key, this.description, this.done}) : super(key: key);
  final String description;
  final bool done;

  @override
  Widget build(BuildContext context) => ListTile(title: Text(description));

  @override
  String toString({DiagnosticLevel minLevel}) => description;
}
