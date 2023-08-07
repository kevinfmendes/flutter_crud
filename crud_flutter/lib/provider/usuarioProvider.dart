
import 'package:crud_flutter/data/dummy_user.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/usuario.dart';

class UserProvider with ChangeNotifier{
  final Map<String, User> _items = {...DUMMY_USERS};

  List<User> get all {
    return[..._items.values];
  }

  //quantidade de usuarios 
  int get count{
    return _items.length;
  }

  User byindex(int i){
    return _items.values.elementAt(i);
  }

  void put (User user){
    // ignore: unnecessary_null_comparison
    if (user == null){
      return;
    }

    // ignore: unnecessary_null_comparison
    if (user.id != null &&
        user.id.trim().isNotEmpty &&
        _items.containsKey(user.id)){
        _items.update(user.id, (_) => User(
          id: user.id,
          name: user.name,
          email: user.email,
          avatarUrl: user.avatarUrl,
          cep: user.cep,
          rua: user.rua,
          cidade: user.cidade,
          estado: user.estado
          ));
    } else {
        final id = const Uuid().v4();
        _items.putIfAbsent(id, () => User(
          id: id,
          name: user.name,
          email: user.email,
          avatarUrl: user.avatarUrl,
          cep: user.cep,
          rua: user.rua,
          cidade: user.cidade,
          estado: user.estado
          )
        );
    }
    notifyListeners();
  }

  void remove(User user){
    // ignore: unnecessary_null_comparison
    if (user != null && user.id != null ){
      _items.remove(user.id);
      notifyListeners();
    }
  }

}