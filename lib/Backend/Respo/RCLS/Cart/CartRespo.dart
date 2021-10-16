import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

import 'package:uiecom/Backend/Models/Cart/New_Cartm.dart';

/* -------------------------------------------------------------------------- */
/*           
              !     SHOW ALL PRODUCT LIST WITH TWO PATTERN :-  
              ! 1. MAKEING ANOTHER ABSTRACT CLASS :- LIKE THIS PAGE 
              ! 2. WITHOUT ANY ABSTRACT CLASS :- REGISTER, LOGIN PAGE   
                                                                                */
/* -------------------------------------------------------------------------- */
LocalStorage storage = new LocalStorage('usertoken');
var token = storage.getItem('token');

class CartDataRespo {
  Future<List<NewCart>> getCartData() async {
    String baseUrl = 'https://rahul10apes.pythonanywhere.com/cart/';

    try {
      var res = await http.get(Uri.parse(baseUrl), headers: {
        "Authorization": "token $token",
      });
      // print(res.statusCode);
      if (res.statusCode == 200) {
        var datar = jsonDecode(res.body);

        MainCart mpt = MainCart.fromJson({'cartData': datar});
        List<NewCart> cartData = mpt.cartData;

        return cartData;
      } else {
        // server error
        return Future.error("Server Error !");
      }
    } catch (e) {
      print('Error:- $e');
      return Future.error("Error Fetching Data !");
    }
  }

  /* -------------------------------------------------------------------------- */
  /*                           // ! ADD TO CART Event                          */
  /* -------------------------------------------------------------------------- */

  Future<List<NewCart>> addCartData(
      {required String productId, required int quantity}) async {
    String baseUrl = 'https://rahul10apes.pythonanywhere.com/cart/';
    // var token = storage.getItem('token');
    try {
      var res = await http.post(Uri.parse(baseUrl),
          body: json.encode({
            "quantity": quantity,
            "product": productId,
          }),
          headers: {
            "Content-Type": "application/json; charset=UTF-8",
            'Authorization': "token $token"
          });
      var data = json.decode(res.body) as Map;

      if (res.statusCode == 200) {
        return getCartData();
        // return true;
      }
      return Future.error("Error Fetching Data !");

      // return false;
    } catch (e) {
      print("e addtoCart");
      print(e);
      // return false;
      return Future.error("Error Fetching Data !");
    }
  }

/* -------------------------------------------------------------------------- */
/*                            // ! Update Qunatity                            */
/* -------------------------------------------------------------------------- */

  Future<List<NewCart>> upQuan(
      {required String productId, required int quantity}) async {
    String baseUrl = 'https://rahul10apes.pythonanywhere.com/cart/';

    try {
      var res = await http.put(Uri.parse(baseUrl),
          body: json.encode({
            "quantity": quantity,
            "id": productId,
          }),
          headers: {
            "Content-Type": "application/json; charset=UTF-8",
            'Authorization': "token $token"
          });
      var data = json.decode(res.body) as Map;
      print(data);
      print(res.statusCode);
      if (res.statusCode == 200) {
        return getCartData();
        // return true;
      }
      return Future.error("Error Fetching Data !");

      // return false;
    } catch (e) {
      print("e addtoCart");
      print(e);
      // return false;
      return Future.error("Error Fetching Data !");
    }
  }

  /* -------------------------------------------------------------------------- */
  /*                          // ! CART PRODUCT DELETE                          */
  /* -------------------------------------------------------------------------- */
  Future<List<NewCart>> delCartData({
    required String productId,
  }) async {
    String baseUrl = 'https://rahul10apes.pythonanywhere.com/cartdel/';
    var token = storage.getItem('token');
    try {
      var res = await http.post(Uri.parse(baseUrl),
          body: json.encode({
            "id": productId,
          }),
          headers: {
            "Content-Type": "application/json; charset=UTF-8",
            'Authorization': "token $token"
          });
      var data = json.decode(res.body) as Map;

      if (res.statusCode == 200) {
        return getCartData();
      }
      return Future.error("Error Fetching Data !");
    } catch (e) {
      print("e addtoCart");
      print(e);

      return Future.error("Error Fetching Data !");
    }
  }
}
