import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_pessoa/dao/pessoaDAO.dart';
import 'package:crud_pessoa/model/pessoa.dart';
import 'package:flutter/material.dart';

class PessoaDaoFirestore implements PessoaDao {
  late CollectionReference pessoaCollection;

  PessoaDaoFirestore() {
    pessoaCollection = Firestore.instance.collection("pessoa");
  }

  @override
  Future<Pessoa> consultar(int id) async {}

  @override
  Future<bool> excluir(int id) {
    // TODO: implement excluir
    throw UnimplementedError();
  }

  @override
  listarTodos() async {
    var result = await pessoaCollection.getDocuments();
    return result.documents.map(
        (e) => Pessoa(id: e['id'], nome: e['nome'], celular: e['celular']));
  }

  @override
  Future<bool> salvar(Pessoa pessoa) {
    // TODO: implement salvar
    throw UnimplementedError();
  }
}
