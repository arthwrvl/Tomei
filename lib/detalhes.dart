import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tomei/adicionar.dart';
import 'package:tomei/data/packages_dao.dart';
import 'package:tomei/options.dart';
import 'package:tomei/model/Remedios.dart';
import 'package:tomei/themes.dart';

class Details extends StatelessWidget {
  Remedio pacote;
  Details({this.pacote});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: defaultTheme,
      home: Scaffold(
        appBar: new AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                  tag: pacote.title,
                  child: Text(
                    pacote.title,
                    style: Theme.of(context).textTheme.subtitle1,
                  )),
              Text(
                pacote.dosage,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ],
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddMed(
                              pacote: pacote,
                            )))),
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => {
                      PackagesDao().deleteRemedio(pacote.title),
                      Navigator.pop(context),
                    })
          ],
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Info(pacote: pacote),
      ),
    );
  }
}

class Info extends StatefulWidget {
  Remedio pacote;
  Info({this.pacote});
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  int hour;
  int minuto;
  int horaat = DateTime.now().hour;
  int minutoat = DateTime.now().minute;

  @override
  Widget build(BuildContext context) {
    countTime();
    return Timer(
      hora: hour,
      minuto: minuto,
    );
  }

  void countTime() {
    int horaT = int.parse(widget.pacote.time.split(':')[0]);
    int minuT = int.parse(widget.pacote.time.split(':')[1]);

    print(horaat);
    print(horaT);
    print(minutoat);
    print(minuT);

    if (horaat <= horaT) {
      hour = horaT - horaat;
    } else {
      hour = 24 - (horaat - horaT);
    }
    if (minutoat <= minuT) {
      minuto = minuT - minutoat;
    } else {
      minuto = 60 - (minutoat - minuT);
      hour--;
    }

    if (minuto >= 60) {
      minuto -= 60;
    }
  }
}

class Timer extends StatelessWidget {
  const Timer({this.hora, this.minuto});
  final int hora;
  final int minuto;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Color(0x44DDDDDD),
      ),
      child: Center(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.symmetric(vertical: 25.0)),
            Icon(
              Icons.timer,
              size: 74,
              color: Colors.black12,
            ),
            Text(
              'Faltam ' +
                  hora.toString() +
                  ' horas e ' +
                  minuto.toString() +
                  ' minutos ' +
                  'para sua próxima dose!',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}

class Log extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Date(),
            ),
            //Expanded(child: child)*/
          ],
        ),
      ),
    );
  }
}

class Date extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column();
  }
}
