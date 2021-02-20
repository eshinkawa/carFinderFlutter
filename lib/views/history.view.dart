import 'package:cade_meu_carro/models/history_item.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Customize extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<HistoryItem>('history').listenable(),
      builder: (context, Box<HistoryItem> box, _) {
        if (box.values.isEmpty)
          return Center(
            child: Text("No contacts"),
          );
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: ListView.builder(
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                HistoryItem currentHistoryItem = box.getAt(index);
                return Container(
                  margin: EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 5),
                      Text(currentHistoryItem.description),
                      SizedBox(height: 5),
                      Text(currentHistoryItem.date),
                      SizedBox(height: 5),
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
