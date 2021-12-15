import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tomei/data/packages_dao.dart';
import 'package:tomei/model/Remedios.dart';
import 'package:tomei/themes.dart';

//Marilia Eduarda Almeida Santos
void main() => runApp(MaterialApp(
      home: AddMed(),
    ));

class AddMed extends StatefulWidget {
  Remedio pacote;

  AddMed({this.pacote});

  @override
  _AddMedState createState() => _AddMedState();
}

class _AddMedState extends State<AddMed> {
  TextEditingController dosagemcontroller = TextEditingController();
  TextEditingController duracaocontroller = TextEditingController();
  TextEditingController intervalocontroller = TextEditingController();
  TextEditingController nomecontroller = TextEditingController();
  final _text = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String tipo_med = "";
  var _currencies = [
    'Cápsula',
    'Drágea',
    'Comprimido',
    'Granulado',
    'Pó',
    'Pomada',
    'Creme',
    'Solução',
    'Gotas',
    'Xarope',
    'Outro'
  ];
  var _currentItemSelected = 'Comprimido';
  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);

  void _selectTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.pacote != null) {
      nomecontroller.text = widget.pacote.title;
      dosagemcontroller.text =
          widget.pacote.dosage.replaceAll(new RegExp(r'[a-z]'), '');
      intervalocontroller.text = widget.pacote.interval.toString();
      duracaocontroller.text = widget.pacote.duration.toString();
      _currentItemSelected = widget.pacote.type;
      _time = TimeOfDay(
          hour: int.parse(widget.pacote.initial_time.split(':')[0]),
          minute: int.parse(widget.pacote.initial_time.split(':')[1]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context)),

        actions: [
          // ignore: missing_required_param
          IconButton(
            icon: Icon(
              Icons.done,
              color: Colors.white,
            ),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                int hour = _time.hour + int.parse(intervalocontroller.text);
                if (hour >= 24) {
                  hour -= 24;
                }
                Remedio rmd = Remedio(
                    nomecontroller.text,
                    _time.hour.toString() + ":" + _time.minute.toString(),
                    hour.toString() + ":" + _time.minute.toString(),
                    _time.hour.toString() + ":" + _time.minute.toString(),
                    dosagemcontroller.text + "mg",
                    int.parse(intervalocontroller.text),
                    int.parse(duracaocontroller.text),
                    _currentItemSelected);
                if (widget.pacote != null) {
                  PackagesDao().deleteRemedio(widget.pacote.title);
                }
                PackagesDao().addRemedio(rmd);
                Navigator.pop(context);
              }
              //Scaffold.of(context).openDrawer();
            },
          ),
        ],

        // The title text which will be shown on the action bar
        title: Text("Novo medicamento",
            style: TextStyle(
              fontSize: 18,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                textoHoraInicial(),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _selectTime,
                  child: Text('SELECIONAR HORA INICIAL',
                      style: TextStyle(
                        fontSize: 14,
                      )),
                ),
                SizedBox(height: 6),
                Text(
                  'Hora selecionada: ${_time.format(context)}',
                ),
                SizedBox(height: 20),
                //
                buildTextForm('Nome do medicamento', nomecontroller,
                    (String value) => textValidator(value), TextInputType.text),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        height: 56,
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Tipo',
                            labelStyle: GoogleFonts.roboto(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffE74c4a),
                                width: 2,
                              ),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              icon: Icon(Icons.keyboard_arrow_down),
                              iconEnabledColor: Color(0xffE74c4a),
                              isExpanded: true,
                              items:
                                  _currencies.map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(
                                    dropDownStringItem,
                                    style: TextStyle(
                                      color: Color(0xffE74c4a),
                                      fontSize: 18,
                                      fontFamily: 'Roboto',
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String newValueSelected) {
                                setState(() {
                                  this._currentItemSelected = newValueSelected;
                                });
                              },
                              value: _currentItemSelected,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 20,
                    ),
                    Flexible(
                        child: buildTextForm(
                            'Dosagem',
                            dosagemcontroller,
                            (String value) => numeroValidator(value),
                            TextInputType.number))
                  ],
                ),
                //

                //mudar para o botão com seleção
                buildTextForm(
                    'Intervalo (horas)',
                    intervalocontroller,
                    (String value) => numeroValidator(value),
                    TextInputType.number),
                buildTextForm(
                    'Duração (dias)',
                    duracaocontroller,
                    (String value) => numeroValidator(value),
                    TextInputType.number),

                //
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget textoHoraInicial() {
  return Align(
    alignment: Alignment.centerLeft,
    child: Text(
      'Hora inicial',
      style: TextStyle(
        color: Colors.blueGrey[200],
        fontSize: 18,
        fontFamily: 'Roboto',
      ),
    ),
  );
}

textValidator(String value) {
  if (value == null || value.isEmpty) {
    return 'Preencha o campo';
  }
}

numeroValidator(String value) {
  if (value == null || value.isEmpty) {
    return 'Preencha o campo';
  }
  if (int.tryParse(value) == null) {
    return 'Insira apenas números';
  }
  return null;
}

TextFormField buildTextForm(
    campo, controller, String Function(String) validator, type) {
  return TextFormField(
    keyboardType: type,
    controller: controller,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: validator,
    cursorColor: Color(0xffE74c4a),
    style: TextStyle(color: Color(0xffE74c4a)),
    decoration: InputDecoration(
      errorStyle: GoogleFonts.roboto(
        fontSize: 12,
        fontWeight: FontWeight.w300,
        color: Color(0xFFE74c4a),
      ),
      alignLabelWithHint: true,
      labelText: campo,
      labelStyle: TextStyle(
        color: Color(0x55828282),
        fontSize: 18,
        fontFamily: 'Roboto',
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0x55828282)),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xffE74c4a),
          width: 2,
        ),
      ),
    ),
  );
}
