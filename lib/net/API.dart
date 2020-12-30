import 'dart:async';
import 'package:http/http.dart' as http;

// const baseUrl = "https://jsonplaceholder.typicode.com";
const baseUrl =
    "https://search.torre.co/opportunities/_search/?offset=10&size=10&page=5";

class API {
  static Future getJobs() {
    var url = baseUrl;
    // var url = baseUrl + "/users";
    return http.post(url);
  }
}
