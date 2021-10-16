import 'package:flutter/material.dart';
import 'package:uiecom/AFile/Scr/Order/Order.dart';

class ManageAddressesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: ListView(
          children: [AddressPage()],
        ),
      ),
    );
  }
}
