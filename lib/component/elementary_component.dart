import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customButton(String text, Color color, VoidCallback buttonClicked){
  return  GestureDetector(
    onTap: (){
     buttonClicked();
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: Center(child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),),
      )),
    ),
  );
}