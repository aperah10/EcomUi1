import 'package:flutter/material.dart';

class FBtn extends StatelessWidget {
  String btnName;
  dynamic submitMethod;
  FBtn(this.btnName, {Key? key, this.submitMethod}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
            onTap: submitMethod,
            child: Container(
                height: 60,
                width: 80,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.redAccent, Colors.red],
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                    ),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Center(
                    child: Text(btnName,
                        style: TextStyle(color: Colors.white, fontSize: 20))))),
      ),
    );
  }
}
