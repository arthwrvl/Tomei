import 'package:flutter/material.dart';
import 'package:tomei/Customs/remedioitem.dart';
import 'package:tomei/adicionar.dart';
import 'package:tomei/data/packages_dao.dart';
import 'package:tomei/home.dart';
import 'package:tomei/model/Remedios.dart';

class Remedios extends StatefulWidget {
  Remedio pacote;

  Remedios({this.pacote});
  @override
  _RemediosState createState() => _RemediosState();
}

class _RemediosState extends State<Remedios> {
  Future<List<Remedio>> remedios;

  @override
  void initState() {
    super.initState();
    remedios = PackagesDao().loadremedios('remedios');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                    context, MaterialPageRoute(builder: (context) => AddMed()))
                .then((value) => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Home())));
          }),
    );
  }

  buildBody() {
    return FutureBuilder<List<Remedio>>(
        future: remedios,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Ocorreu um erro inesperado'),
            );
          }
          if (snapshot.hasData) {
            return buildListView(snapshot.data);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  buildListView(pacotes) {
    return ListView.builder(
      itemCount: pacotes.length,
      itemBuilder: (BuildContext context, int index) {
        return RemedioItem(pacote: pacotes[index]);
      },
    );
  }
}
