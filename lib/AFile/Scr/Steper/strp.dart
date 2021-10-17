import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uiecom/AFile/Scr/Address/ShowAddress.dart';

class Strper extends StatefulWidget {
  Strper({Key? key}) : super(key: key);

  @override
  _StrperState createState() => _StrperState();
}

class _StrperState extends State<Strper> {
  dynamic adrId;
  int curStep = 0;
  dynamic ordQuan = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stepper(
          type: StepperType.horizontal,
          physics: ScrollPhysics(),
          currentStep: curStep,
          onStepCancel: () {
            curStep == 0 ? null : setState(() => curStep -= 1);
          },
          onStepContinue: () {
            final isLastStep = curStep == 3 - 1;

            if (isLastStep) {
            } else {
              setState(() => curStep += 1);
            }
          },
          onStepTapped: (step) => setState(() => curStep = step),

          // controlsBuilder: (BuildContext context,
          //     {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
          //   return Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       crossAxisAlignment: CrossAxisAlignment.end,
          //       children: <Widget>[
          //         TextButton(
          //           onPressed: onStepContinue,
          //           child: null,
          //         ),
          //         TextButton(
          //           onPressed: onStepCancel,
          //           child: const Text('Cancel', style: TextStyle(fontSize: 25)),
          //         ),
          //       ],
          //     ),
          //   );
          // },
          steps: [
            Step(
              state: curStep > 0 ? StepState.complete : StepState.indexed,
              isActive: curStep >= 0,
              title: const Text('Address'),
              content: Container(
                child: AddressShowScr(),
              ),
            ),
            Step(
              state: curStep > 1 ? StepState.complete : StepState.indexed,
              isActive: curStep >= 1,
              title: const Text('Order'),
              subtitle: const Text('Delivery'),
              content: Container(
                child: Column(
                  children: [
                    Text('Quantity'),
                    // OrderProductPage(
                    //   prodNumber: widget.prodNumber,
                    // ),
                  ],
                ),
              ),
            ),
            Step(
              state: curStep > 2 ? StepState.complete : StepState.indexed,
              isActive: curStep >= 2,
              title: const Text('Payment'),
              content: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text('Content for Step 3')),
            ),
          ]),
    );
  }
}
