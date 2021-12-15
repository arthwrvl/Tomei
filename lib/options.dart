import 'package:flutter/material.dart';
import 'package:tomei/login.dart';

//Vitória de Lira Tenório
void main() {
  runApp(MaterialApp(
    home: Options(),
    debugShowCheckedModeBanner: false,
  ));
}

class Options extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Opções'),
          backgroundColor: Color(0xffE74c4a),
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context)),
        ),
        body: BodyLayout(),
      ),
    );
  }
}

class BodyLayout extends StatefulWidget {
  @override
  _BodyLayoutState createState() => _BodyLayoutState();
}

class _BodyLayoutState extends State<BodyLayout> {
  @override
  Widget build(BuildContext context) {
    return _myListView(context);
  }
}

Widget _myListView(BuildContext context) {
  return ListView(
    children: <Widget>[
      BuildListTile(),
      ToggleNotify(),
    ],
  );
}

class BuildListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text('Olá, Doente!',
            style: TextStyle(
                fontSize: 18,
                color: Color(0xFF828282),
                fontWeight: FontWeight.w500)),
        subtitle: Text('Toque aqui para sair da sua conta.',
            style: TextStyle(
                fontSize: 12,
                color: Color(0xBB828282),
                fontWeight: FontWeight.w500)),
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Login()));
        },
      ),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0x44828282)))),
    );
  }
}

class ToggleNotify extends StatefulWidget {
  @override
  _ToggleNotifyState createState() => _ToggleNotifyState();
}

class _ToggleNotifyState extends State<ToggleNotify> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text('Notificar antes',
            style: TextStyle(
                fontSize: 18,
                color: Color(0xFF828282),
                fontWeight: FontWeight.w500)),
        trailing: Switch(
          value: isSwitched,
          onChanged: (bool value) {
            print(isSwitched);
            setState(() {
              isSwitched = value;
            });
          },
          activeTrackColor: Color(0xAAE74c4a),
          activeColor: Color(0xffE74c4a),
        ),
        subtitle: Text('Notificar minutos antes da hora exata de tomar',
            style: TextStyle(
                fontSize: 12,
                color: Color(0xBB828282),
                fontWeight: FontWeight.w500)),
      ),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0x44828282)))),
    );
  }
}
