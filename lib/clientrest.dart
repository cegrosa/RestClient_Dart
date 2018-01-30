import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RestClient {
  var httpClient;

  //Get object from specific id
  Future<Map> getObject(Uri url) async {
    httpClient = new HttpClient();
    try {
      var request = await httpClient.getUrl(url);
      var response = await request.close();
      var responseBody = await response.transform(UTF8.decoder).join();
      return JSON.decode(responseBody);
    } catch (exception, stackTrace) {
      print(exception);
      print(stackTrace);
    }
  }

  //Get objects List from specific url
  Future<List> getList(Uri url) async {
    httpClient = new HttpClient();
    try {
      var request = await httpClient.getUrl(url);
      var response = await request.close();
      var responseBody = await response.transform(UTF8.decoder).join();
      print("AAA: " + JSON.decode(responseBody).toString());
      return JSON.decode(responseBody);
    } catch (exception, stackTrace) {
      print(exception);
      print(stackTrace);
    }
  }

  //Post object to specific url
  post(Uri url, Map data) async {
    try {
      //Remove field 'id' from Map
      data.remove("id");

      var response = await http.post(url,
          headers: {'content-type': 'application/json'},
          body: JSON.encode(data));
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
    } catch (exception, stackTrace) {
      print(exception);
      print(stackTrace);
    }
  }

  _put(Uri url) async {}

  _delete(Uri url) async {}
}
