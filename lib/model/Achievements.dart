import 'dart:convert';

class Achievements {
  String nome;
  String descricao;
  double porcentagem;

  Achievements({this.nome, this.descricao, this.porcentagem});

  Achievements.fromJson(Map<String, dynamic> json) {
    nome = json['title'];
    descricao = json['descricao'];
    porcentagem = json['porcentagem'];
  }
}
