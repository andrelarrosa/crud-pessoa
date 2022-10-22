import 'package:crud_pessoa/dao/pessoaDAO.dart';
import 'package:crud_pessoa/view/pessoa/pessoa_form.dart';
import 'package:flutter/material.dart';

class ListPessoa extends StatefulWidget {
  const ListPessoa({Key? key}) : super(key: key);

  @override
  State<ListPessoa> createState() => _ListPessoaState();
}

class _ListPessoaState extends State<ListPessoa> {
  PessoaDao pessoaDao = PessoaDao();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(''),
          actions: [
            IconButton(
                icon: const Icon(Icons.add),
                onPressed: () =>
                    Navigator.pushNamed(context, '/pessoaForm').then((value) {
                      setState(() {});
                    }))
          ],
        ),
        body: FutureBuilder(
          future: pessoaDao.listarTodos(),
          builder:
              (context, AsyncSnapshot<List<Map<String, Object?>>> snapshot) {
            if (!snapshot.hasData) return const CircularProgressIndicator();
            var lista = snapshot.data!;
            return ListView.builder(
              itemCount: lista.length,
              itemBuilder: (context, contador) {
                var pessoa = lista[contador];
                return ListTile(
                    title: Text(pessoa['nome'].toString()),
                    subtitle: Text(pessoa['celular'].toString()),
                    trailing: ElevatedButton(
                      child: Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content:
                                    Text("Tem certeza que deseja excluir?"),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        PessoaDao dao = new PessoaDao();
                                        dao.excluir(
                                            int.parse(pessoa['id'].toString()));
                                        Navigator.pushNamed(context, '/');
                                      },
                                      child: Text("Sim")),
                                  ElevatedButton(
                                    child: Text("Não"),
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/');
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                    ));
              },
            );
          },
        ));
  }
}
