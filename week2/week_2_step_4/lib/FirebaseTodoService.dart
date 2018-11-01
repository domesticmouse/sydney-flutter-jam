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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_study_jam_week_2/TodoEntity.dart';
import 'package:flutter_study_jam_week_2/TodoService.dart';

class FirebaseTodoService extends TodoService {
  @override
  Stream<List<TodoEntity>> get todos => Firestore.instance
      .collection('todos')
      .orderBy('done')
      .snapshots()
      .map((QuerySnapshot snapshot) => snapshot.documents
          .map(
            (docSnapshot) => TodoEntity(
                id: docSnapshot.documentID,
                todo: docSnapshot.data["todo"],
                done: docSnapshot.data["done"]),
          )
          .toList());

  @override
  Future<void> addTodo(TodoEntity todo) {
    return Firestore.instance.collection('todos').add(todo.toJSON());
  }

  @override
  Future<void> deleteTodo(String id) {
    return Firestore.instance.collection('todos').document(id).delete();
  }

  @override
  Future<void> updateTodo(TodoEntity todo) {
    return Firestore.instance
        .collection('todos')
        .document(todo.id)
        .updateData(todo.toJSON());
  }
}
