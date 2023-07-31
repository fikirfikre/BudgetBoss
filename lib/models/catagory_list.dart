import 'package:flutter/material.dart';

class Category{
   int? id;
   String name;
   IconData icon;
   Color color;
 Category.empty(): id = 1, name = " ",icon = Icons.abc,color=Colors.black;
  Category({ this.id,  required this.name,required this.icon,required this.color});

  Map<String,dynamic> toMap(){
    return {
      'id' : id,
      'name':name,
      'icon': icon.codePoint,
      'color':color.value
    };
  }

  Category fromMap(Map<String,dynamic> map){
    return Category(
      id: map['id'],
      name: map['name'],
      icon:IconData(map['icon'], fontFamily: 'MaterialIcons'),
      color: Color(map['color']));
  }
}