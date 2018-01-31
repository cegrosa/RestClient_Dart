import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RestClient {
  var httpClient = new HttpClient();

  // Get object from specific id
  Future<Map> getObject(String url) async {
    Uri uri = _parseUriStr(url);
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    var responseBody = await response.transform(UTF8.decoder).join();

    return JSON.decode(responseBody);
  }

  // Get objects List from specific url
  Future<List> getList(String url) async {
    Uri uri = _parseUriStr(url);
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    var responseBody = await response.transform(UTF8.decoder).join();

    return JSON.decode(responseBody);
  }

  // Post object to specific url
  post(String url, Map data) async {
    Uri uri = _parseUriStr(url);

    // Remove field 'id' from Map
    data.remove("id");

    var response = await http.post(uri,
        headers: {'content-type': 'application/json'}, body: JSON.encode(data));
    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");
  }

  // Put/Update object to specific url
  // If url pass 'id' (E.g.: 'localhost/kittie/1'),
  //  this method act like post()
  put(String url, Map data) async {
    Uri uri = _parseUriStr(url);

    var response = await http.put(uri,
        headers: {'content-type': 'application/json'}, body: JSON.encode(data));
    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");
  }

  // Delete object from specific url
  delete(String url) async {
    Uri uri = _parseUriStr(url);

    var request = await httpClient.deleteUrl(uri);
    var response = await request.close();
    var responseBody = await response.transform(UTF8.decoder).join();

    return JSON.decode(responseBody);
  }

  // Return parsed Uri
  Uri _parseUriStr(String url){
    return Uri.parse(url);
  }
}
