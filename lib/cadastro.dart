import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tomei/login.dart';

//Edmilson Henrique Ferreira Barbosa

void main() {
  runApp(MaterialApp(
    home: Cadastro(),
    debugShowCheckedModeBanner: false,
  ));
}

class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController usuariocontroller = TextEditingController();
  TextEditingController nomecontroller = TextEditingController();
  TextEditingController senhacontroller = TextEditingController();
  TextEditingController repetirsenhacontroller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE74C3A),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Já possui conta?",
                style:
                    GoogleFonts.roboto(fontSize: 16, color: Color(0xFFECF0F1))),
            TextButton(
              child: Text("Entre!",
                  style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationThickness: 2,
                      color: Color(0xFFECF0F1))),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
            ),
          ],
        ),
        elevation: 0,
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Align(
                alignment: Alignment.center,
                child: Text("Tomei",
                    style: GoogleFonts.lobster(
                        fontSize: 64, color: Color(0xFFECF0F1)))),
            Align(
              alignment: Alignment.center,
              child: Text("Já que é pra tomar, Tomei",
                  style: GoogleFonts.roboto(
                      fontSize: 16, color: Color(0xFFECF0F1))),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 80, 0, 20),
              child: Align(
                alignment: Alignment.center,
                child: Text("Cadastro",
                    style: GoogleFonts.roboto(
                        fontSize: 36,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFECF0F1))),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                      height: 60,
                      width: 320,
                      child: buildFormFieldTexto(
                        "Usuário",
                        usuariocontroller,
                        (String value) => userValidator(value),
                        TextInputType.text,
                      )),
                  Container(
                    height: 60,
                    width: 320,
                    child: buildFormFieldTexto(
                        "E-mail",
                        emailcontroller,
                        (String value) => emailValidator(value),
                        TextInputType.emailAddress),
                  ),
                  Container(
                    height: 60,
                    width: 320,
                    child: buildFormFieldTexto(
                        "Nome",
                        nomecontroller,
                        (String value) => textValidator(value),
                        TextInputType.text),
                  ),
                  Container(
                    height: 60,
                    width: 320,
                    child: buildFormFieldSenha(
                        "Senha",
                        senhacontroller,
                        (String value) => pwdValidator(value),
                        TextInputType.text),
                  ),
                  Container(
                    height: 60,
                    width: 320,
                    child: buildFormFieldSenha(
                        "Repetir senha",
                        repetirsenhacontroller,
                        (String value) =>
                            pwdmatchValidator(value, senhacontroller.text),
                        TextInputType.text),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: Container(
                        height: 40,
                        width: 310,
                        child: SizedBox.expand(
                          child: OutlineButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                print('validado');
                              }
                            },
                            child: Text("Cadastrar",
                                style: GoogleFonts.roboto(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFFECF0F1))),
                            shape: StadiumBorder(),
                            borderSide: BorderSide(
                                color: Color(0xFFECF0F1),
                                style: BorderStyle.solid,
                                width: 3),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

userValidator(String value) {
  if (value.isEmpty || value == '') {
    return 'Preencha o campo';
  }

  String t = value.substring(0);

  if (!t.contains(RegExp(r'[a-z]')) && !t.contains(RegExp(r'[A-Z]'))) {
    return 'O primeiro caracter do usuário deve ser uma letra';
  }

  return null;
}

pwdValidator(String value) {
  if (value.isEmpty || value == '') {
    return 'Preencha o campo';
  }

  if (value.length < 8) {
    return 'Por favor, componha uma senha a partir de 8 caracteres';
  }

  return null;
}

pwdmatchValidator(String value, controller) {
  if (value != controller) {
    return 'as senhas não correspondem';
  }

  return null;
}

textValidator(String value) {
  if (value == null || value.isEmpty) {
    return 'Preencha o campo';
  }
}

emailValidator(String value) {
  if (value.isEmpty || value == '') {
    return 'Preencha o campo';
  }
  int aux = 0;
  for (int i = 0; i < value.length; i++) {
    if (i == 0 && value[i] == '@' ||
        value[i] == '@' && i == (value.length - 1)) {
      return 'Email inválido';
      //i = email.length;
      //aux = -1;
    } else if (value[i] == '@') {
      aux++;
    }
  }
  if (aux == 1) {
    return null;
  } else
    return 'Email inválido';
}

TextFormField buildFormFieldTexto(
    texto, controller, String Function(String) validator, type) {
  return TextFormField(
    keyboardType: type,
    controller: controller,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: validator,
    style: GoogleFonts.roboto(
      color: Color(0xFFECF0F1),
    ),
    decoration: InputDecoration(
      errorStyle: GoogleFonts.roboto(
        fontSize: 12,
        fontWeight: FontWeight.w300,
        color: Color(0xFFECF0F1),
      ),
      labelText: texto,
      labelStyle: GoogleFonts.roboto(
        color: Color(0xFFECF0F1),
      ),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFECF0F1), width: 2)),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0x99ECF0F1), width: 2)),
    ),
  );
}

TextFormField buildFormFieldSenha(
    senha, controller, String Function(String) validator, type) {
  bool _showPassword = false;
  return TextFormField(
    keyboardType: type,
    controller: controller,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: validator,
    style: GoogleFonts.roboto(
      color: Color(0xFFECF0F1),
    ),
    decoration: InputDecoration(
      errorStyle: GoogleFonts.roboto(
        fontSize: 12,
        fontWeight: FontWeight.w300,
        color: Color(0xFFECF0F1),
      ),
      labelText: senha,
      labelStyle: GoogleFonts.roboto(
        color: Color(0xFFECF0F1),
      ),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFECF0F1), width: 2)),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0x99ECF0F1), width: 2)),
      suffixIcon: GestureDetector(
        child: Icon(
            _showPassword == false ? Icons.visibility_off : Icons.visibility,
            color: Color(0xFFECF0F1)),
        onTap: () {
          print(_showPassword);
          _showPassword = !_showPassword;
        },
      ),
    ),
    obscureText: _showPassword == false ? true : false,
  );
}

void setState(Null Function() param0) {}
