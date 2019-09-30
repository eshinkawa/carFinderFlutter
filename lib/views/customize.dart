import 'package:flutter/material.dart';

import '../services/webservice.dart';
import '../models/parkingItem.dart';

class Customize extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CustomizeState();
  }
}

class CustomizeState extends State<Customize> {
  List<ParkingItem> _parkingItem = List<ParkingItem>();

  @override
  void initState() {
    super.initState();
    _populateList();
  }

  void _populateList() {
    Webservice().load(ParkingItem.all).then((parkingItem) => {
          setState(() => {_parkingItem = parkingItem})
        });
    print(_parkingItem);
  }

  Padding _buildItemsForListView(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 2.0),
      child: Container(
          child: ListTile(
            onTap: () => {
              setState(() => {_parkingItem[index].isSelected = !_parkingItem[index].isSelected})
            },
            leading: Icon(Icons.local_parking, color: Colors.white38,),
            title:
                Text(_parkingItem[index].name, style: TextStyle(fontSize: 22, color: Colors.white)),
            subtitle: Text(_parkingItem[index].address,
                style: TextStyle(fontSize: 12, color: Colors.white70)),
            trailing: _parkingItem[index].isSelected ? Icon(Icons.check, color: Colors.white38,) : null,
          ),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white24)))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Seus estacionamentos'),
          backgroundColor: Colors.red,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.local_parking,
                color: Colors.white,
              ),
              onPressed: () => {},
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Color(0xff2980b9), Color(0xff2c3e50)])),
          child: ListView.builder(
            itemCount: _parkingItem.length,
            itemBuilder: _buildItemsForListView,
          ),
        ));
  }
}
