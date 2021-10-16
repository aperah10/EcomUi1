import 'package:flutter/material.dart';
import 'package:uiecom/AFile/Scr/Profile/EditProfile.dart';
import 'package:uiecom/AFile/Scr/Profile/ShowProdile.dart';
import 'package:uiecom/Fortend/Screen/Authr_Scr/HomeScr.dart';
import 'package:uiecom/Fortend/Screen/Authr_Scr/Login.dart';
import 'package:uiecom/Fortend/Screen/Authr_Scr/Register.dart';
import 'package:uiecom/Fortend/Screen/Product_Scr/Cart/Cart.dart';
import 'package:uiecom/Fortend/Screen/Product_Scr/Product/ProdPage.dart';
import 'package:uiecom/Fortend/Screen/Product_Scr/Product/Product_Cat.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScr.routeName: (ctx) => LoginScr(),
  RegisterScr.routeName: (ctx) => RegisterScr(),
  HomeScr.routeName: (ctx) => HomeScr(),
  ProductGridScr.routeName: (ctx) => ProductGridScr(),
  ProductDetailTwoPage.routeName: (ctx) => ProductDetailTwoPage(),
  CartScr.routeName: (ctx) => CartScr(),
  ShowProfileScr.routeName: (ctx) => ShowProfileScr(),
  EditProfileScr.routeName: (ctx) => EditProfileScr(),
};
