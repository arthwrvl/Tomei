import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tomei/cadastro.dart';
import 'package:tomei/home.dart';

//Edmilson Henrique Ferreira Barbosa
void main() {
  runApp(MaterialApp(
    home: Login(),
    debugShowCheckedModeBanner: false,
  ));
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usuariocontroller = TextEditingController();
  TextEditingController senhacontroller = TextEditingController();
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
            Text("Não possui conta?",
                style:
                    GoogleFonts.roboto(fontSize: 16, color: Color(0xFFECF0F1))),
            TextButton(
              child: Text("Cadastre-se",
                  style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationThickness: 2,
                      color: Color(0xFFECF0F1))),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Cadastro()),
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
                child: Text("Login",
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
                    child: buildFormFieldTexto("Usuário", usuariocontroller),
                  ),
                  Container(
                    height: 60,
                    width: 320,
                    child: buildFormFieldSenha("Senha", senhacontroller),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
                    child: Container(
                        height: 40,
                        width: 310,
                        child: SizedBox.expand(
                          child: OutlineButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()));
                              }
                            },
                            child: Text("Entrar",
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
                  Container(
                    child: Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        child: Text(
                          "Esqueceu sua senha?",
                          style: GoogleFonts.roboto(
                              fontSize: 16, color: Color(0xFFECF0F1)),
                        ),
                        onPressed: () {},
                      ),
                    ),
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

pwdValidator(String value) {
  if (value.isEmpty || value == '') {
    return 'Preencha o campo';
  }
  if (value != '123') {
    return 'Senha incorreta';
  }
  return null;
}

userValidator(String value) {
  if (value.isEmpty || value == '') {
    return 'Preencha o campo';
  }
  if (value != 'user') {
    return 'usuário incorreto';
  }
  return null;
}

TextFormField buildFormFieldTexto(texto, controller) {
  return TextFormField(
    keyboardType: TextInputType.text,
    controller: controller,
    validator: (String value) => userValidator(value),
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

TextFormField buildFormFieldSenha(senha, controller) {
  bool _showPassword = false;
  return TextFormField(
    keyboardType: TextInputType.text,
    controller: controller,
    validator: (String value) => pwdValidator(value),
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

