import 'package:flutter/material.dart';

class TransactionType {
  int? id;
  String label;
  IconData icon;
  Color color;
 
  TransactionType(
      { this.id,
      required this.label,
      required this.icon,
      required this.color});
 TransactionType.empty(): id = 1, label = " ",icon = Icons.abc,color=Colors.black;
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'label': label,
      'icon': icon.codePoint,
      'color': color.value
    };
  }

  TransactionType fromMap(Map<String, dynamic> map) {
    final iconCodePoint = map['icon'];
    final iconCodePointHex =iconCodePoint.toRadixString(16);
    final intvalue = int.parse("0x$iconCodePointHex");
     print("en");
     print(intvalue);
    return TransactionType(
        id: map['id'],
        label: map['label'],
        icon:IconData(map['icon'],fontFamily: "MaterialIcons"),
        color: Color(map['color']));
  }
}
