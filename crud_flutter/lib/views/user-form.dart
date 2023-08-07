import 'dart:convert';

import 'package:crud_flutter/models/usuario.dart';
import 'package:crud_flutter/provider/usuarioProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();
  final _formData = <String, String>{};
  TextEditingController txtcep = TextEditingController();

  void _loadFormdData(User user) {
    _formData['id'] = user.id;
    _formData['name'] = user.name;
    _formData['email'] = user.email;
    _formData['avatarUrl'] = user.avatarUrl;
    _formData['cep'] = user.cep;
    _formData['rua'] = user.rua;
    _formData['cidade'] = user.cidade;
    _formData['estado'] = user.estado;
  }

  _consultaCep() async {
    String cep = txtcep.text;
    String url = 'https://viacep.com.br/ws/${cep}/json';

    http.Response response;
    response = await http.get(Uri.parse(url));

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      Map<String, dynamic> retorno = jsonDecode(response.body);

      if (retorno.containsKey("logradouro") &&
          retorno.containsKey("localidade") &&
          retorno.containsKey("uf")) {
        String rua = retorno["logradouro"];
        String cidade = retorno["localidade"];
        String estado = retorno["uf"];

        setState(() {
          _formData['rua'] = rua;
          _formData['cidade'] = cidade;
          _formData['estado'] = estado;
        });

      } else {
        print("Resposta inválida do serviço de CEP");
      }
    } else {
      print("Erro na solicitação do serviço de CEP");
    }
  }

  @override
  Widget build(BuildContext context) {
    final User? user = ModalRoute.of(context)?.settings.arguments as User?;

    if (user != null) {
      _loadFormdData(user);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Padding(
          padding: EdgeInsets.only(left: 30.0),
          child: Text(
            'Cadastro de Usuários',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  initialValue: _formData['name'],
                  decoration: const InputDecoration(labelText: 'Nome *'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Este campo é obrigatório';
                    }
                    return null;
                  },
                  onSaved: (value) => _formData['name'] = value!,
                ),
                TextFormField(
                  initialValue: _formData['email'],
                  decoration: const InputDecoration(labelText: 'Email *'),
                  onSaved: (value) => _formData['email'] = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Este campo é obrigatório';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _formData['avatarUrl'],
                  decoration: const InputDecoration(labelText: 'URL avatar'),
                  onSaved: (value) => _formData['avatarUrl'] = value!,
                ),
                TextFormField(
                  controller: txtcep,
                  // initialValue: _formData['cep'],
                  decoration:
                      const InputDecoration(labelText: 'Digite seu CEP:'),
                  onSaved: (value) => _formData['cep'] = value!,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (value.length == 8) {
                      _consultaCep();
                    }
                  },
                ),
                TextFormField(
                  initialValue: _formData['rua'],
                  decoration: const InputDecoration(labelText: 'Rua'),
                  onSaved: (value) => _formData['rua'] = value!,
                ),
                TextFormField(
                  initialValue: _formData['cidade'],
                  decoration: const InputDecoration(labelText: 'Cidade'),
                  onSaved: (value) => _formData['cidade'] = value!,
                ),
                TextFormField(
                  initialValue: _formData['estado'],
                  decoration: const InputDecoration(labelText: 'Estado'),
                  onSaved: (value) => _formData['estado'] = value!,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final isValid = _form.currentState?.validate();

                    if (isValid == true) {
                      _form.currentState?.save();
                      Provider.of<UserProvider>(context, listen: false).put(
                        User(
                          id: _formData['id'] ?? '',
                          name: _formData['name'] ?? '',
                          email: _formData['email'] ?? '',
                          avatarUrl: _formData['avatarUrl'] ?? '',
                          cep: _formData['cep'] ?? '',
                          rua: _formData['rua'] ?? '',
                          cidade: _formData['cidade'] ?? '',
                          estado: _formData['estado'] ?? '',
                        ),
                      );
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Cadastrar Novo Usuário'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
