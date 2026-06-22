import 'dart:convert';

import '../services/webservice.dart';
import '../utils/constants.dart';

class ParkingItem {
  String? name;
  String? address;
  bool? isSelected;

  ParkingItem();

  ParkingItem.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        address = json['address'] as String?,
        isSelected = json['isSelected'] as bool?;

  Map<String, dynamic> toJson() => {
        'name': name,
        'address': address,
        'isSelected': isSelected,
      };

  static Resource<List<ParkingItem>> get all {
    return Resource(
      url: API_SERVICE_URL,
      parse: (response) {
        final result = json.decode(response.body);
        final Iterable list = result as Iterable;
        return list
            .map((model) => ParkingItem.fromJson(model as Map<String, dynamic>))
            .toList();
      },
    );
  }
}
