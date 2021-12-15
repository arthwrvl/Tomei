import 'package:flutter/material.dart';
import 'package:tomei/Customs/conquistaItem.dart';
import 'package:tomei/data/packages_dao.dart';
import 'package:tomei/model/Achievements.dart';

class Conquistas extends StatefulWidget {
  @override
  _ConquistasState createState() => _ConquistasState();
}

class _ConquistasState extends State<Conquistas> {
  Future<List<Achievements>> conquistas;

  @override
  void initState() {
    super.initState();
    conquistas = PackagesDao().loadAchievents('conquistas');
  }

  @override
  Widget build(BuildContext context) {
    return buildConquistBody();
  }

  buildConquistBody() {
    return FutureBuilder<List<Achievements>>(
        future: conquistas,
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
        return ConquistaItem(conquista: pacotes[index]);
      },
    );
  }
}
