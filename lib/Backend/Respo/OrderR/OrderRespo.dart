import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:uiecom/Backend/Models/Order/Orderm.dart';

LocalStorage storage = new LocalStorage('usertoken');
var token = storage.getItem('token');

class OrderDataRespo {
  Future<List<Order>> orderData({
    required String address,
    required String product,
    int? quantity,
  }) async {
    String baseUrl = 'http://rahul10apes.pythonanywhere.com/order/';

    try {
      var res = await http.post(Uri.parse(baseUrl),
          body: json.encode({
            "address": address,
            "product": product,
            "quantity": quantity,
          }),
          headers: {
            "Content-Type": "application/json; charset=UTF-8",
            'Authorization': "token $token"
          });
      var data = json.decode(res.body) as Map;
      print(
          '----------------------------------------------------------------------');
      print('this is data $data');
      print(res.body);
      print(' Statuc Code  :-  ${res.statusCode}');

      if (res.statusCode == 200) {
        return [];
        // return true;
      }
      return Future.error("Error Fetching Data !");

      // return false;
    } catch (e) {
      print("e ADDRESS");
      print(e);
      // return false;
      return Future.error("Error Fetching Data !");
    }
  }
}
