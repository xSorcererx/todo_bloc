import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:todo_bloc/data/models/todo_model.dart';

/*
    To do repo class defined in order to deal with the APIs.

    ALl of the CRUD operation related to the to do API have been done here.
*/
class TodosRepo {
  // READ method
  static Future<List<TodoModel>> fetchTodos() async {
    var client = http.Client();
    // instantiating a list to store To do model fetched from the API
    List<TodoModel> todos = [];
    try {
      var response = await client.get(
        Uri.parse('http://10.0.2.2:8000/todo_api/'),
      );
      if (response.statusCode == 200) {
        List<dynamic> result = jsonDecode(response.body);

        for (int i = 0; i < result.length; i++) {
          // converting json data into To do model using the fromJson() function.
          TodoModel todo =
              TodoModel.fromJson(result[i] as Map<String, dynamic>);
          todos.add(todo);
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
        return [];
      }
      return todos;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  /* 
      CREATE method acccepting a TodoModel as a parameter
  */
  static Future<bool> addTodos(TodoModel todo) async {
    var client = http.Client();
    try {
      var response = await client.post(
        Uri.parse('http://10.0.2.2:8000/todo_api/'),
        /*
            Converting the model into Json data to send it to the API,
            using toJson() function 
        */
        body: todo.toJson(), 
      );

      if (response.statusCode >= 200 && response.statusCode <= 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  /* 
      DELETE method acccepting the id of To do instance as a parameter
  */
  static Future<bool> deleteTodos(int docId) async {
    var client = http.Client();
    try {
      var response = await client.delete(
        Uri.parse('http://10.0.2.2:8000/todo_api/'),
        // sending the ID to API to delete the corresponding to do.
        body: {
          'id': docId.toString(),
        },
      );

      if (response.statusCode >= 200 && response.statusCode <= 300) {
        print('deleted');
        return true;
      } else {
        print('not deleted');
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
