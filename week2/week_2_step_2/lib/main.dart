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
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GDG Flutter Sydney',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        accentColor: Colors.amberAccent,
      ),
      home: MyHomePage(title: 'GDG Flutter Sydney'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final newTodoController = TextEditingController();

  List<TodoEntity> todos = [
    TodoEntity(todo: "Prepare content for next meetup", done: false),
    TodoEntity(todo: "Find venue", done: false),
    TodoEntity(todo: "Organise food", done: false),
    TodoEntity(todo: "Draft Meetup event", done: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: TextFormField(
                      key: Key("todo_input"),
                      controller: newTodoController,
                      decoration:
                          InputDecoration(labelText: "What needs to be done?"),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      todos.add(TodoEntity(
                          todo: newTodoController.text, done: false));
                    });
                    newTodoController.clear();
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: todos.map((todo) => TodoListItem(todo: todo)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    newTodoController.dispose();
    super.dispose();
  }
}

class TodoListItem extends StatelessWidget {
  final todo;

  const TodoListItem({
    Key key,
    this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, right: 4.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(todo.todo),
        ),
      ),
    );
  }
}

class TodoEntity {
  String todo;
  bool done;

  TodoEntity({
    @required this.todo,
    @required this.done,
  });
}
