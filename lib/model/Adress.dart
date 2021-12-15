class Adress {
  String cep;
  String rua;
  String bairro;
  String cidade;
  String estado;
  int numero;

  Adress(
      {this.cep, this.rua, this.bairro, this.cidade, this.estado, this.numero});

  Adress.fromJsonApi(Map<String, dynamic> json) {
    cep = json['cep'];
    rua = json['logradouro'];
    bairro = json['bairro'];
    cidade = json['localidade'];
    estado = json['uf'];
  }

  Adress.fromJson(Map<String, dynamic> json) {
    cep = json['cep'];
    rua = json['logradouro'];
    bairro = json['bairro'];
    cidade = json['localidade'];
    estado = json['uf'];
    numero = json['numero'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cep'] = this.cep;
    data['logradouro'] = this.rua;
    data['bairro'] = this.bairro;
    data['localidade'] = this.cidade;
    data['uf'] = this.estado;
    data['numero'] = this.numero;

    return data;
  }
}
