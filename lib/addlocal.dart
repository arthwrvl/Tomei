import 'package:flutter/material.dart';
import 'package:tomei/data/adress_api.dart';
import 'package:tomei/data/packages_dao.dart';
import 'package:tomei/model/Adress.dart';

class AddLocal extends StatefulWidget {
  final Adress pacote;

  AddLocal({this.pacote});
  @override
  _AddLocalState createState() => _AddLocalState();
}

class _AddLocalState extends State<AddLocal> {
  TextEditingController cepcontroller = TextEditingController();

  TextEditingController citycontroller = TextEditingController();
  TextEditingController ufcontroller = TextEditingController();
  TextEditingController ruacontroller = TextEditingController();
  TextEditingController numerocontroller = TextEditingController();
  TextEditingController bairrocontroller = TextEditingController();

  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    Future<Adress> e = PackagesDao().findAdress();
    cepcontroller.addListener(() async {
      if (cepcontroller.text.length == 8) {
        Adress e = await AdressAPI().loadAdress(cepcontroller.text);
        citycontroller.text = e.cidade;
        ufcontroller.text = e.estado;
        ruacontroller.text = e.rua;
        bairrocontroller.text = e.bairro;
      } else {
        e = null;
        citycontroller.text = "";
        ufcontroller.text = "";
        ruacontroller.text = "";
        bairrocontroller.text = "";
      }
    });
    if (widget.pacote != null) {
      cepcontroller.text = widget.pacote.cep;
      citycontroller.text = widget.pacote.cidade;
      ufcontroller.text = widget.pacote.estado;
      ruacontroller.text = widget.pacote.rua;
      bairrocontroller.text = widget.pacote.bairro;
      numerocontroller.text = widget.pacote.numero.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(pacote: widget.pacote),
      body: buildbody(),
    );
  }

  buildAppbar({Adress pacote}) {
    String title = pacote != null ? 'Editar endereço' : 'Novo endereço';
    return AppBar(
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context, true)),

      actions: [
        // ignore: missing_required_param
        IconButton(
          icon: Icon(
            Icons.done,
            color: Colors.white,
          ),
          onPressed: () {
            Adress newAd = Adress(
              bairro: bairrocontroller.text,
              cep: cepcontroller.text,
              cidade: citycontroller.text,
              estado: ufcontroller.text,
              numero: int.parse(numerocontroller.text),
              rua: ruacontroller.text,
            );
            if (pacote != null) {
              PackagesDao().deleteAddress(pacote.cep);
            }
            PackagesDao().addAddress(newAd);
            Navigator.pop(context);
          },
        ),
      ],

      // The title text which will be shown on the action bar
      title: Text(title,
          style: TextStyle(
            fontSize: 18,
          )),
    );
  }

  buildbody({Adress pacote}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 70,
              child:
                  buildTextForm(cepcontroller, 'CEP', TextInputType.number, 8),
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: buildTextForm(
                      citycontroller, 'Cidade', TextInputType.text, 200),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  flex: 1,
                  child: buildTextForm(
                      ufcontroller, 'Estado', TextInputType.text, 200),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: buildTextForm(
                      ruacontroller, 'Rua', TextInputType.text, 200),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  flex: 1,
                  child: buildTextForm(
                      numerocontroller, 'Número', TextInputType.number, 10),
                ),
              ],
            ),
            SizedBox(
              width: 228,
              child: buildTextForm(
                  bairrocontroller, 'Bairro', TextInputType.text, 200),
            ),
          ],
        ),
      ),
    );
  }

  buildTextForm(controller, label, input, max) {
    return TextFormField(
      controller: controller,
      keyboardType: input,
      maxLength: max,
      style: Theme.of(context).textTheme.headline3,
      decoration: InputDecoration(
        counterText: "",
        labelText: label,
        alignLabelWithHint: true,
        labelStyle: TextStyle(
          color: Color(0x55828282),
          fontSize: 18,
          fontFamily: 'Roboto',
        ),
        border: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0x55828282))),
      ),
    );
  }
}
