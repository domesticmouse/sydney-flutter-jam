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

import 'package:cloud_firestore/cloud_firestore.dart';
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

  void _addTodo(TodoEntity entity) {
    Firestore.instance.collection('todos').add(entity.toJSON());
  }

  void _updateTodo(TodoEntity entity) {
    Firestore.instance
        .collection('todos')
        .document(entity.id)
        .updateData(entity.toJSON());
  }

  void _deleteTodo(TodoEntity entity) {
    Firestore.instance.collection('todos').document(entity.id).delete();
  }

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
                    _addTodo(
                        TodoEntity(todo: newTodoController.text, done: false));
                    newTodoController.clear();
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection("todos")
                  .orderBy('done')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }
                List<TodoListItem> todos = snapshot.data.documents
                    .map(
                      (docSnapshot) => TodoEntity(
                          id: docSnapshot.documentID,
                          todo: docSnapshot.data["todo"],
                          done: docSnapshot.data["done"]),
                    )
                    .map((todo) => TodoListItem(
                          todo: todo,
                          callback: (done) {
                            todo.done = done;
                            _updateTodo(todo);
                          },
                          removeCallback: () => _deleteTodo(todo),
                        ))
                    .toList();

                return Expanded(
                  child: ListView(
                    children: todos,
                  ),
                );
              }),
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

typedef TodoChangeCallback = void Function(bool done);
typedef TodoRemoveCallback = void Function();

class TodoListItem extends StatelessWidget {
  final todo;
  final TodoChangeCallback callback;
  final TodoRemoveCallback removeCallback;

  const TodoListItem({
    Key key,
    this.todo,
    this.callback,
    this.removeCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: todo.done ? 0.30 : 1.0,
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0, right: 4.0),
        child: Card(
          child: InkWell(
            onTap: () => this.callback(!todo.done),
            onLongPress: () => this.removeCallback(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                todo.todo,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TodoEntity {
  String id;
  String todo;
  bool done;

  TodoEntity({
    @required this.id,
    @required this.todo,
    @required this.done,
  });

  Map<String, dynamic> toJSON() {
    return {
      "todo": this.todo,
      "done": this.done,
    };
  }
}
