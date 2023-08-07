import 'package:crud_flutter/models/usuario.dart';
import 'package:crud_flutter/provider/usuarioProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserForm extends StatelessWidget {
  UserForm({super.key});

  final _form = GlobalKey<FormState>();

  final _formData = <String, String>{};

  void _loadFormdData(User user) {
    _formData['id'] = user.id;
    _formData['name'] = user.name;
    _formData['email'] = user.email;
    _formData['avatarUrl'] = user.avatarUrl;
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
              ))),
      body: Padding(
        padding: const EdgeInsets.all(30.0), // Espaçamento em torno do botão
        child: Form(
            key: _form,
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

                // TextFormField(
                //   decoration: const InputDecoration(labelText: 'Endereço *'),
                // ),
                const SizedBox(
                    height: 20), // Espaçamento entre os campos e o botão
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
                        ),
                      );
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Cadastrar Novo Usuário'),
                ),
              ],
            )),
      ),
    );
  }
}
