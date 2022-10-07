import 'package:flutter_database/model/account_model.dart';
import 'package:flutter_database/model/user_model.dart';
import 'package:hive/hive.dart';

class HiveDB{
  var box = Hive.box("flutter_db");

  void store(String key, Map<String, dynamic> user) async{
      box.put(key, user);
  }

  User loadUser(String key){
    var user = User.fromJson(box.get(key));
    return user;
  }

  Account loadAccount(String key){
    var account = Account.fromJson(box.get(key));
    return account;
  }

  void remove(String key){
    box.delete(key);
  }
}