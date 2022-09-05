import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kServerAddr = "106.52.6.222";
const kServerPort = "8000";

const kOuterBoxDecoration = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.topRight,
        stops: [0.0, 1.0],
        colors: [Colors.lightBlueAccent, Colors.blueAccent]));

const kInternalBoxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(22.0)),
    boxShadow: [
      BoxShadow(
        color: Colors.grey,
        blurRadius: 12.0,
      )
    ]);
