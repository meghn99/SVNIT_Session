// ignore: import_of_legacy_library_into_null_safe
import 'package:web3dart/credentials.dart';

class UserModel {
  String? id;
  EthereumAddress? address;
  String? email;
  String? name;
  String? password;
  String? type;
  // List<QuizModel>? quizzes;

  UserModel({this.address, this.id,  this.name, this.email, this.type, this.password});

  Map<String?, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["address"] = this.address;
    data["email"] = this.email;
    data["name"] = this.name;
    data["password"] = this.password;
    data["type"] = this.type;
    // data["quizzes"] = this.quizzes;
    return data;
  }

  UserModel.fromJson(Map<String?, dynamic> json) {
    this.id = json["id"];
    this.address = EthereumAddress.fromHex(json["address"]);
    this.email = json["email"];
    this.name = json["name"];
    this.password = json["password"];
    this.type = json["type"];
    // this.quizzes = json["quizzes"];
  }
}
