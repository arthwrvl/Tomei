import 'package:flutter/material.dart';
import 'package:tomei/data/packages_dao.dart';
import 'package:tomei/home.dart';
import 'package:tomei/model/Remedios.dart';

import '../detalhes.dart';

class RemedioItem extends StatefulWidget {
  final Remedio pacote;

  RemedioItem({this.pacote});

  @override
  _RemedioItemState createState() => _RemedioItemState();
}

class _RemedioItemState extends State<RemedioItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: _IconDesc(
                  dosage: widget.pacote.dosage,
                  icon: Icons.medical_services_outlined,
                ),
              ),
              Expanded(
                flex: 5,
                child: _RemedioDesc(
                  next: widget.pacote.next,
                  time: widget.pacote.time,
                  title: widget.pacote.title,
                ),
              ),
              Expanded(
                flex: 1,
                child: _LateMed(
                  lat: widget.pacote.lat,
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  alignment: Alignment.centerRight,
                  icon: Icon(Icons.keyboard_arrow_down),
                  onPressed: () => {},
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
            color: widget.pacote.lat ? Color(0x11E74C4C) : Color(0xFFECF0F1),
            border: Border(bottom: BorderSide(color: Color(0x44828282)))),
      ),
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Details(
              pacote: widget.pacote,
            ),
          ),
        ).then((value) => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home())))
      },
    );
  }
}

class _LateMed extends StatelessWidget {
  _LateMed({this.lat});
  final bool lat;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(padding: EdgeInsets.symmetric(vertical: 8)),
          Icon(
            Icons.warning,
            size: 24,
            color: lat ? Color(0xFFE74C4C) : Color(0x0000000),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 0.5)),
          Text(
            lat ? 'Atrasado' : '',
            style: Theme.of(context).textTheme.headline3,
          ),
        ],
      ),
    );
  }
}

class _IconDesc extends StatelessWidget {
  const _IconDesc({
    this.dosage,
    this.icon,
  });
  final String dosage;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(padding: EdgeInsets.symmetric(vertical: 4)),
          Icon(
            icon,
            size: 32,
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 0.5)),
          Text(
            dosage,
            style: Theme.of(context).textTheme.headline1,
          ),
        ],
      ),
    );
  }
}

class _RemedioDesc extends StatelessWidget {
  const _RemedioDesc({
    this.title,
    this.time,
    this.next,
  });
  final String title;
  final String time;
  final String next;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(padding: EdgeInsets.symmetric(vertical: 5)),
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 0.5)),
          Text(
            time,
            style: Theme.of(context).textTheme.headline1,
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 1)),
          Text(
            next,
            style: Theme.of(context).textTheme.headline2,
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 5))
        ],
      ),
    );
  }
}
