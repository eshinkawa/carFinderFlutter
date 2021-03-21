import 'package:cade_meu_carro/controllers/parking.controller.dart';
import 'package:cade_meu_carro/models/history_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/constants.dart';
import '../widgets/button.dart';
import '../widgets/dropItem.dart';
import '../widgets/sign.dart';

class ParkingView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ParkingState();
}

class ParkingState extends State<ParkingView> {
  Future<void> openDialog(
      BuildContext context, ParkingController provider) async {
    final _showDialog = showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar local de estacionamento?'),
          content: Text(
              '${provider.selectedLetter}${provider.selectedNumber} no ${provider.selectedFloor}'),
          actions: <Widget>[
            TextButton(
              child: Text('SALVAR'),
              onPressed: () {
                final historyItem = HistoryItem(
                  description:
                      '${provider.selectedLetter}${provider.selectedNumber} no ${provider.selectedFloor}',
                  date: provider.timeTobeRecorded,
                );
                provider.saveData(
                    provider.selectedLetter,
                    provider.selectedNumber,
                    provider.selectedFloor,
                    provider.timeTobeRecorded);
                provider.addHistoryItem(historyItem);
                provider.setShowSaveButton(false);
                Navigator.pop(context);
              },
            ),
            TextButton(
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
    final provider = Provider.of<ParkingController>(context);
    return Scaffold(
        body: Center(
            child: Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xff372549),
      ),
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
          !provider.isAllInfoFilled()
              ? Container(
                  margin: EdgeInsets.fromLTRB(0, 24, 0, 0),
                  child: Theme(
                    data: ThemeData.dark(),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        DropItem(
                          isEnabled: provider.code == null,
                          dropHint: 'Andar',
                          items: provider.dropdownFloor(),
                          selectedValue: provider.selectedFloor,
                          onChanged: (value) => provider.setFloor(value),
                        ),
                        DropItem(
                          isEnabled: provider.code == null,
                          dropHint: 'Letra',
                          items: provider.dropdownLetter(),
                          selectedValue: provider.selectedLetter,
                          onChanged: (value) => provider.setLetter(value),
                        ),
                        DropItem(
                          isEnabled: provider.code == null,
                          dropHint: 'Número',
                          items: provider.dropdownNumber(),
                          selectedValue: provider.selectedNumber,
                          onChanged: (value) => provider.setNumber(value),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
          Sign(
            isAllInfoFilled: provider.isAllInfoFilled(),
            selectedFloor: provider.selectedFloor,
            selectedLetter: provider.selectedLetter,
            selectedNumber: provider.selectedNumber,
            code: provider.code,
            timeStamp: provider.timeStamp == null
                ? provider.timeTobeRecorded
                : provider.timeStamp,
          ),
          SizedBox(
            height: 24,
          ),
          Button(
              showButton: provider.isAllInfoFilled() && provider.showSaveButton,
              onPressed: () => openDialog(context, provider),
              text: "Salvar",
              color: Color(0xff5c80bc)),
          Button(
              showButton: true,
              onPressed: () => {
                    provider.reset(),
                    provider.removeDataFromStorage(),
                  },
              text: "Redefinir",
              color: Color(0xffb33951)),
        ],
      )),
    )));
  }
}
