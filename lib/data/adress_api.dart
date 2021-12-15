import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tomei/model/Adress.dart';

class AdressAPI {
  loadAdress(String cep) async {
    Adress endereco;
    String url = 'https://viacep.com.br/ws/' + cep + '/json/';

    final response = await http.get(url);

    if (response.statusCode == 200) {
      endereco = Adress.fromJsonApi(json.decode(response.body));
    }
    return endereco;
  }
}
