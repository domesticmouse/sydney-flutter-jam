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

import 'package:flutter_study_jam_week_2/TodoEntity.dart';
import 'package:flutter_study_jam_week_2/TodoService.dart';
import 'package:rxdart/rxdart.dart';

class TodoBloc {
  final TodoService _service;

  final _todosSubject = BehaviorSubject<List<TodoEntity>>();

  TodoBloc(this._service) {
    this._service.todos.pipe(_todosSubject);
  }

  Stream<List<TodoEntity>> get todos => _todosSubject.stream;

  Future<void> addTodo(TodoEntity todo) => _service.addTodo(todo);

  Future<void> updateTodo(TodoEntity todo) => _service.updateTodo(todo);

  Future<void> deleteTodo(String id) => _service.deleteTodo(id);
}
