import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:openpgp/openpgp.dart';
import 'package:path_provider/path_provider.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:provider/provider.dart';
import 'package:tutorialapp/Screens/HomeScreen.dart';
import 'package:tutorialapp/Screens/LogInScreen.dart';
import 'package:web3dart/web3dart.dart';

import '../Models/userModel.dart';
import '../contract_linking.dart';
import '../utils/common.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _privateKeyController = TextEditingController();

  String pKey = "";

  // Future<String> get _localPath async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   return directory.path;
  // }

  // Future<File> get _localFile async {
  //   final path = await _localPath;
  //   var kFileName = 'xyz.txt';
  //   return File('$path/$kFileName');
  // }

  //Encryption of private keys
  // encrypKey(String _pKey, String pass, bool isGenerated) {
  //   var key = encrypt.Key.fromLength(16);
  //   var iv = encrypt.IV.fromUtf8(pass);
  //   var encrypter = encrypt.Encrypter(encrypt.AES(key, iv));

  //   var encrypted = encrypter.encrypt(_pKey);

  //   _writePrivateKey(encrypted.base16, isGenerated);
  //   key = encrypt.Key.fromLength(16);
  //   iv = encrypt.IV.fromUtf8(pass);
  //   encrypter = encrypt.Encrypter(encrypt.AES(key, iv));

  //   var decrypted = encrypter.decrypt(encrypted);

  //   print("Pass : $decrypted");
  // }

  // void _writePrivateKey(String? pKey) async {
  //   final file = await _localFile;
  //   print(file.path);
  //   print(pKey);
  //   file.writeAsString(pKey!);
  // }

  //Storing encrypted Private keys in local storage
  // void _writePrivateKey(String? pKey, bool isGenerated) async {
  //   final path = await _localPath;
  //   var kFileName = isGenerated ? 'abc.txt' : 'xyz.txt';
  //   final file = File('$path/$kFileName');
  //   print(file.path);
  //   print(pKey);
  //   file.writeAsString(pKey!);
  // }

  UserModel get getData {
    UserModel data = UserModel();
    data.email = _emailController.text;
    data.name = _nameController.text;
    data.password = _passwordController.text;
    data.id = Random().nextInt(1000000).toString();
    print(data.id);
    data.address =
        EthereumAddress.fromHex("0x5459cc2871125295174a7F60cECfc3Ca6cAdA2C2");
    

    return data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<ContractLinking>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              30.height,
              Text("Sign Up", style: boldTextStyle(size: 40)).center(),
              24.height,
              AppTextField(
                textFieldType: TextFieldType.OTHER,
                controller: _nameController,
                decoration: inputDecoration(
                  context,
                  label: "Name",
                ),
              ),
              24.height,
              AppTextField(
                  textFieldType: TextFieldType.EMAIL,
                  controller: _emailController,
                  decoration: inputDecoration(
                    context,
                    label: "Email",
                  )),
              24.height,
              AppTextField(
                  textFieldType: TextFieldType.PASSWORD,
                  controller: _passwordController,
                  decoration: inputDecoration(
                    context,
                    label: "Password",
                  )),
              24.height,
              AppTextField(
                textFieldType: TextFieldType.OTHER,
                controller: _privateKeyController,
                decoration: inputDecoration(
                  context,
                  label: "Private Key",
                ),
              ),
              24.height,
              AppTextField(
                  textFieldType: TextFieldType.OTHER,
                  controller: _addressController,
                  decoration: inputDecoration(
                    context,
                    label: "Address",
                  )),
              24.height,
              AppButton(
                text: "Sign Up",
                onTap: () async {
                  setValue("privateKey",
                      "9ad5278959f1247038fc9cc243fdb8c05d3fc9b8adda75e7d397c071ddc28742");
                  await contractLink.initialSetup();
                  log("hi");
                  await contractLink
                      .addUser(getData.address!, getData.id!, getData.name!,
                          getData.email!, getData.password!)
                      .then((value) {
                    LogInScreen().launch(context);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
