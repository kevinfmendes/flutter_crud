import 'package:crud_flutter/components/userTile.dart';
import 'package:crud_flutter/provider/usuarioProvider.dart';
import 'package:crud_flutter/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    
    final UserProvider users = Provider.of(context);
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(
          child: Text(
            'Lista de Usuários',
            style: TextStyle(
              color: Colors.white,
            ),
          )
        ),
      ),
      body: ListView.builder(
        itemCount: users.count,
        itemBuilder: (ctx, i) => UserTile(users.byindex(i))
        ),
        floatingActionButton: 
        FloatingActionButton(
          onPressed:(){
            Navigator.of(context).pushNamed(
              AppRoutes.USER_FORM
            );
          },
          backgroundColor: Colors.blue, 
          child: const Icon(Icons.add),
          ),
    );
  }
}