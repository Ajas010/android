import 'package:flutter/material.dart';

void snackbarwidget(context,data,color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Text(data,style: TextStyle(color: Colors.white),),
    backgroundColor: color,
  ));
}
