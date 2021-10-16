// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:secd_ecom/Backend/Models/Product/New_Product_m.dart';

// /* -------------------------------------------------------------------------- */
// /*           
//               !     SHOW ALL PRODUCT LIST WITH TWO PATTERN :-  
//               ! 1. MAKEING ANOTHER ABSTRACT CLASS :- LIKE THIS PAGE 
//               ! 2. WITHOUT ANY ABSTRACT CLASS :- REGISTER, LOGIN PAGE   
//                                                                                 */
// /* -------------------------------------------------------------------------- */

// // abstract class SearchPRespo {
// //   Future<List<ProductC>> getSearchP(String query);
// // }

// // class SearchPDataRespo extends SearchPRespo {

// class SearchPDataRespo {
//   Future<List<ProductC>> getSearchP(String query) async {
//     // String baseUrl = 'https://djecoms.herokuapp.com/search/?search=$query';
//     String baseUrl =
//         'http://rahulaperah.pythonanywhere.com/search/?search=$query';
//     try {
//       var res = await http.get(Uri.parse(baseUrl));
//       // print('SEARCH RESPO :- ${res.statusCode}');
//       if (res.statusCode == 200) {
//         var datar = jsonDecode(res.body);
//         // print('datatr $datar');
//         MainProduct mpt = MainProduct.fromJson({'productData': datar});
//         // print('SERACH RESPO MPT:- $mpt');
//         // List<ProductM> productData = MainProductM.fromJson({'datar':datar});
//         List<ProductC> productData = mpt.productData;
//         // print('SEARCH RESPO PRODDATA :- $productData');

//         return productData;
//       } else {
//         // server error
//         return Future.error("Server Error !");
//       }
//     } catch (e) {
//       print('Error:- $e');
//       return Future.error("Error Fetching Data !");
//     }
//   }
// }
