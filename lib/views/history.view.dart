import 'package:cade_meu_carro/controllers/parking.controller.dart';
import 'package:cade_meu_carro/models/history_item.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class HistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ParkingController>(context);
    return ValueListenableBuilder(
      valueListenable: Hive.box<HistoryItem>('history').listenable(),
      builder: (context, Box<HistoryItem> box, _) {
        if (box.values.isEmpty)
          return Container(
            decoration: BoxDecoration(
              color: Color(0xff372549),
            ),
            child: Center(
              child: Text(
                "Histórico vazio",
                style: TextStyle(color: Colors.white, fontSize: 28),
              ),
            ),
          );
        return Scaffold(
          body: Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Color(0xff372549),
            ),
            child: ListView.builder(
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                HistoryItem currentHistoryItem = box.getAt(index);
                return Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF5b305a),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.all(6.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '🅿️ ${currentHistoryItem.description}',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          SizedBox(height: 6),
                          Text(
                            '⏱️ ${currentHistoryItem.date}',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => provider.deleteHistoryItem(index),
                        color: Colors.white,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
