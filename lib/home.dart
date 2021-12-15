import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tomei/addlocal.dart';
import 'package:tomei/conquista.dart';
import 'package:tomei/data/packages_dao.dart';
import 'package:tomei/locais.dart';
import 'package:tomei/model/Achievements.dart';
import 'package:tomei/model/Remedios.dart';
import 'package:tomei/options.dart';
import 'package:tomei/adicionar.dart';
import 'package:tomei/detalhes.dart';
import 'package:tomei/calendario.dart';
import 'package:tomei/Customs/conquistaItem.dart';
import 'package:tomei/Customs/remedioitem.dart';
import 'package:tomei/remedios.dart';

import 'package:tomei/themes.dart';

class Home extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(vsync: this, length: 4);
    _scrollViewController = new ScrollController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: defaultTheme,
      home: DefaultTabController(
        length: 4,
        child: new Scaffold(
          body: NestedScrollView(
            controller: _scrollViewController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                new SliverAppBar(
                  elevation: 10,
                  pinned: true,
                  floating: true,
                  forceElevated: true,
                  actions: [
                    IconButton(
                        icon: Icon(
                          Icons.menu,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Options()));
                        })
                  ],
                  title: Align(
                    child: Text('Tomei',
                        style: GoogleFonts.lobster(
                            fontSize: 28, color: Color(0xFFECF0F1))),
                    alignment: Alignment.centerLeft,
                  ),
                  bottom: new TabBar(
                    isScrollable: true,
                    tabs: [
                      new Tab(
                        child: Text('Remédios'),
                      ),
                      new Tab(
                        child: Text('Conquistas'),
                      ),
                      new Tab(
                        child: Text('Calendário'),
                      ),
                      new Tab(
                        child: Text('Farmácias'),
                      ),
                    ],
                    controller: _tabController,
                  ),
                ),
              ];
            },
            body: new TabBarView(
              children: <Widget>[
                //Suellen Evelyn de Oliveira Silva
                Remedios(),

                //Hylka Karoline Cavalcante Santos Melo
                Conquistas(),

                //João Arthur Oliveira Valério
                Calendario(),

                Locais(),
              ],
              controller: _tabController,
            ),
          ),
        ),
      ),
    );
  }
}
