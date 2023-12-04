import 'package:flutter/material.dart';

import '../models/usuario_model.dart';

class Usuarios extends StatefulWidget {
  @override
  State<Usuarios> createState() {
    return UsuariosState();
  }
}

class UsuariosState extends State<Usuarios> {
  /// Lista de objetos da classe Usuario
  List<Usuario> _lista = [];

  @override
  void initState() {
    super.initState();
    _lista.add(Usuario(
        nome: "Jair da Silva",
        email: "jairmessias@gmail.com",
        urlFoto:
            "https://2.bp.blogspot.com/-wUD2SGHiBCg/XGVk3D2_6FI/AAAAAAACkqc/LWNsgSdN5YwQNqy7IsRj95GrjqauK5ZzACLcBGAs/s1600/thispersondoesnotexist-2.jpg"));
    _lista.add(Usuario(
        nome: "Gabi",
        email: "gabrielamessias@gmail.com",
        urlFoto:
            "https://varbai.com/wp-content/uploads/2019/02/thispersondoesnotexis.jpg"));
    _lista.add(Usuario(
        nome: "Felipe Neto",
        urlFoto:
            "https://live.staticflickr.com/65535/50630706993_00b8c57751_w.jpg",
        email: "felipeneto@hotmail.com"));
    _lista.add(Usuario(
        nome: "Fernando Burrão",
        urlFoto: "https://i.postimg.cc/Z5Fm5PTT/thispersondoesnotexist-com.jpg",
        email: "fernandoburrao@yahoo.com"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Usuários"), backgroundColor: Color(0xff7422ad)),
        body: ListView.builder(
            itemCount: _lista.length, // Tamanho da lista
            // context: contexto da aplicação (tela atual)
            // index: índice de cada item, iterado de 0 até n-1 (n = tamanho da lista)
            itemBuilder: (context, index) {
              return ListTile(
                  leading: ClipOval(
                    child: Image.network(_lista[index].urlFoto),
                  ),
                  title: Text(_lista[index].nome),
                  subtitle: Text(_lista[index].email));
            }));
  }
}
