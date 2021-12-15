import 'package:flutter/material.dart';
import 'package:tomei/model/Achievements.dart';

class ConquistaItem extends StatelessWidget {
  final Achievements conquista;

  ConquistaItem({this.conquista});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Icon(
                Icons.emoji_events_rounded,
                size: 62, /*color: Color(0x99E74C3C)*/
              ),
            ),
            Expanded(
              flex: 4,
              child: _ConqDesc(
                title: conquista.nome,
                desc: conquista.descricao,
                perc: conquista.porcentagem.toString() +
                    '% dos usuários conquistaram',
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0x44828282)))),
      ),
    );
  }
}

class _ConqDesc extends StatelessWidget {
  const _ConqDesc({
    this.title,
    this.desc,
    this.perc,
  });
  final String title;
  final String desc;
  final String perc;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(padding: EdgeInsets.symmetric(vertical: 2)),
          Hero(
              tag: title,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyText1,
              )),
          Padding(padding: EdgeInsets.symmetric(vertical: 0.5)),
          Text(
            desc,
            style: Theme.of(context).textTheme.headline1,
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 1)),
          Text(
            perc,
            style: Theme.of(context).textTheme.headline2,
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 5))
        ],
      ),
    );
  }
}
