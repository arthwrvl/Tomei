import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tomei/home.dart';

//João Arthur Oliveira Valério
//Hylka Karoline Cavalcante Santos Melo
//Suellen Evelyn de Oliveira Silva

void main() {
  initializeDateFormatting().then((_) => runApp(MaterialApp(
        home: Home(),
        debugShowCheckedModeBanner: false,
      )));
}
