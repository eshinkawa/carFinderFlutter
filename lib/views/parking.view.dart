import 'package:cade_meu_carro/controllers/parking.controller.dart';
import 'package:cade_meu_carro/models/history_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../utils/constants.dart';
import '../widgets/button.dart';
import '../widgets/dropItem.dart';
import '../widgets/sign.dart';

class ParkingView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ParkingState();
}

class ParkingState extends State<ParkingView> {
  ParkingController controller = ParkingController();

  @override
  void initState() {
    super.initState();
    controller.getDataFromStorage();
  }

  Future<void> openDialog(BuildContext context) async {
    var _showDialog = showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar local de estacionamento?'),
          content: Text(
              '${controller.selectedLetter}${controller.selectedNumber} no ${controller.selectedFloor}'),
          actions: <Widget>[
            FlatButton(
              child: Text('SALVAR'),
              onPressed: () {
                final historyItem = HistoryItem(
                  description:
                      '${controller.selectedLetter}${controller.selectedNumber} no ${controller.selectedFloor}',
                  date: controller.timeTobeRecorded,
                );
                controller.saveData(
                    controller.selectedLetter,
                    controller.selectedNumber,
                    controller.selectedFloor,
                    controller.timeTobeRecorded);
                controller.addHistoryItem(historyItem);
                controller.setShowSaveButton(false);
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text('CANCELAR'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
    return _showDialog;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Scaffold(
          body: Center(
              child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color(0xff372549),
              Color(0xff372549),
            ])),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              PARKING_TITLE,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  letterSpacing: -1,
                  fontWeight: FontWeight.w300),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 24, 0, 0),
              child: Theme(
                data: ThemeData.dark(),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    DropItem(
                      isEnabled: controller.code == null,
                      dropHint: 'Andar',
                      items: controller.dropdownFloor(),
                      selectedValue: controller.selectedFloor,
                      onChanged: (value) {
                        controller.setFloor(value);
                        if (controller.isAllInfoFilled())
                          controller.setShowSaveButton(true);
                      },
                    ),
                    DropItem(
                      isEnabled: controller.code == null,
                      dropHint: 'Letra',
                      items: controller.dropdownLetter(),
                      selectedValue: controller.selectedLetter,
                      onChanged: (value) {
                        controller.setLetter(value);
                        if (controller.isAllInfoFilled())
                          controller.setShowSaveButton(true);
                      },
                    ),
                    DropItem(
                      isEnabled: controller.code == null,
                      dropHint: 'Número',
                      items: controller.dropdownNumber(),
                      selectedValue: controller.selectedNumber,
                      onChanged: (value) {
                        controller.setNumber(value);
                        if (controller.isAllInfoFilled())
                          controller.setShowSaveButton(true);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Sign(
              isAllInfoFilled: controller.isAllInfoFilled(),
              selectedFloor: controller.selectedFloor,
              selectedLetter: controller.selectedLetter,
              selectedNumber: controller.selectedNumber,
              code: controller.code,
              timeStamp: controller.timeStamp == null
                  ? controller.timeTobeRecorded
                  : controller.timeStamp,
            ),
            Button(
                showButton:
                    controller.isAllInfoFilled() && controller.showSaveButton,
                onPressed: () => openDialog(context),
                text: "Salvar",
                color: Color(0xff5c80bc)),
            Button(
                showButton: true,
                onPressed: () =>
                    {controller.reset(), controller.removeDataFromStorage()},
                text: "Redefinir",
                color: Color(0xffb33951)),
          ],
        )),
      ))),
    );
  }
}
