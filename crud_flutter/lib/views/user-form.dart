// ignore: file_names
import 'package:flutter/material.dart';

class UserForm extends StatelessWidget {

  UserForm({super.key});

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
            )
          ) 
        ),
        body:   Padding(
         padding: EdgeInsets.all(30.0), // Espaçamento em torno do botão
         child: Form(
            key: _form,
            child: Column(
              children:<Widget> [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Nome *'),
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return 'Nome inválido';   
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email *'),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'URL avatar'),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Endereço *'),
                ),
                const SizedBox(height: 20), // Espaçamento entre os campos e o botão
                ElevatedButton(
                  onPressed: () {
                    final isValid = _form.currentState?.validate();
                    
                    if(isValid != null){
                      _form.currentState?.save();
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Cadastrar Novo Usuário'),
                ),
              ],
            )
          ),
      ),
    );
  }
}