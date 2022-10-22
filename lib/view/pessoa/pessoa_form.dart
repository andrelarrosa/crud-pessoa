import 'package:crud_pessoa/dao/pessoaDAO.dart';
import 'package:crud_pessoa/model/pessoa.dart';
import 'package:flutter/material.dart';

class PessoaForm extends StatelessWidget {
  dynamic id;
  String? nome;
  String? celular;

  PessoaDao dao = PessoaDao();
  @override
  Widget build(BuildContext context) {
    var pessoa;
    var argumento = ModalRoute.of(context)?.settings.arguments;
    if (argumento != null) {
      Map<String, Object?> pessoa = argumento as Map<String, Object?>;
      id = pessoa["id"] as int;
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro Pessoa'),
          actions: [
            IconButton(
                icon: const Icon(Icons.save),
                onPressed: () {
                  dao.salvar(Pessoa(nome: nome!, celular: celular!));
                  Navigator.pop(context, '/');
                }),
          ],
        ),
        body: Form(
          child: Column(children: [
            TextFormField(
              decoration: InputDecoration(label: Text("Nome do Cliente")),
              onChanged: (valorDigitado) => nome = valorDigitado,
              initialValue: nome,
            ),
            TextFormField(
              decoration: InputDecoration(label: Text("Digite o seu celular")),
              onChanged: (valorDigitado) => celular = valorDigitado,
              initialValue: celular,
            ),
          ]),
        ));
  }
}
