import 'package:http/http.dart' as http;
import 'package:imagegenerator/MyUrl.dart';
import 'dart:convert' as convert;


class MyHttp {
  static Future<http.Response> put(String endPoint, dynamic data) async {

    var headers = {"Content-type": "application/json"};
    var res = await http.put( Uri.parse(MyUrl.url(endPoint)), body: convert.jsonEncode(data), headers: headers);
    return res;
  }

  static Future<http.Response> patch(String endPoint, dynamic data) async {
    var headers = {"Content-type": "application/json"};

    var res = await http.patch(Uri.parse(MyUrl.url(endPoint)), body: convert.jsonEncode(data), headers: headers);
    return res;
  }

  static Future<http.Response> post(String endPoint, dynamic data) async {

    var headers = {"Content-type": "application/json"};
  print(MyUrl.url(endPoint));
  print(data);
    return await http.post(Uri.parse(MyUrl.url(endPoint)), body: convert.jsonEncode(data), headers: headers);
  }

  static Future<http.Response> delete(String endPoint) async {

    var headers = {"Content-type": "application/json"};

    return await http.delete(Uri.parse(MyUrl.url(endPoint)), headers: headers);
  }

  static Future<http.Response> get(String endPoint) async {


    var headers = {"Content-type": "application/json"};
    var res = await http.get(Uri.parse(MyUrl.url(endPoint)), headers: headers);
    if (res.statusCode == 403) {
      print("TOKEN REMOVED");
    }
    return res;
  }
}
