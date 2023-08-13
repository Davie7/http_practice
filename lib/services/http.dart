import 'dart:convert';

import 'package:http/http.dart' as http;

class HTTPHelper {
  // fetching all items
  Future<List<Map>> fetchItems() async {
    List<Map> items = [];

    // get the data from the API

    http.Response response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    if (response.statusCode == 200) {
      // get the data from the response body
      // String jsonString = response.body
      // then convert to list map
      List data = jsonDecode(response.body);
      items = data.cast<Map>();
    }

    return items;
  }

  // fetch details of one item
  Future<Map> getItem(itemId) async {
    Map item = {};

    // get the item from the API
    http.Response response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/$itemId'),
    );

    if (response.statusCode == 200) {
      // convert to map
      item = jsonDecode(response.body);
    }
    return item;
  }

  // add a new item
  Future<bool> addItem(Map data) async {
    bool status = false;

    // add item to the database, call the API
    http.Response response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      body: jsonEncode(data),
      headers: {'Content-type': 'application/json'},
    );
    if (response.statusCode == 200) {
      status = response.body.isNotEmpty;
    }
    return status;
  }

  // update an item
  Future<bool> updateItem(Map data, String itemId) async {
    bool status = false;

    // update item in the database, call the API
    http.Response response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/$itemId'),
      body: jsonEncode(data),
      headers: {'Content-type': 'application/json'},
    );

    if (response.statusCode == 200) {
      status = response.body.isNotEmpty;
    }
    return status;
  }

  // delete an item
  Future<bool> deleteItem(String itemId) async {
    bool status = false;

    // delete item in the database, call the API
    http.Response response = await http.delete(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/$itemId'),
    );
    if (response.statusCode == 200) {
      status = true;
    }

    return status;
  }
}
