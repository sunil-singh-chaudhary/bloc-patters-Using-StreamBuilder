import 'dart:async';
import 'dart:convert';

import 'package:bloc_patter_demo_2/Data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DataBloc {
  final _dataController = StreamController<List<Data>>();
  Stream<List<Data>> get data => _dataController.stream;

  Future<void> fetchData() async {
    try {
      final response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
      if (response.statusCode == 200) {
        final data =
            jsonDecode(response.body).map((d) => Data.fromJson(d)).toList();
        _dataController.sink.add(data);
        print(data);
      } else {
        _dataController.sink.addError("Failed to fetch data");
      }
    } catch (e) {
      print(e.toString());
      _dataController.sink.addError(e);
    }
  }

  void dispose() {
    _dataController.close();
  }
}
