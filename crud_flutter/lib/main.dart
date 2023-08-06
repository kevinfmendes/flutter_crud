import 'package:crud_flutter/provider/usuarioProvider.dart';
import 'package:crud_flutter/routes/app_routes.dart';
import 'package:crud_flutter/views/user-form.dart';
import 'package:crud_flutter/views/user_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider (
      providers: [
        ChangeNotifierProvider(
        create: (context) => UserProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        routes: {
          AppRoutes.HOME: (_) =>  const UserList(),
          AppRoutes.USER_FORM: (_) => UserForm(),
        },
      ),
    );
  }
}