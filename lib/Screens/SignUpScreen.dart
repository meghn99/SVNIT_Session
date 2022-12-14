import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
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

  UserModel get getData {
    UserModel data = UserModel();
    data.email = _emailController.text;
    data.name = _nameController.text;
    data.password = _passwordController.text;
    data.id = Random().nextInt(1000000).toString();
    print(data.id);
    data.address =
        EthereumAddress.fromHex("0x74cBDf9650f0dB0786003140ad20b9A952Ffe6Ab");
    
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
                      "7c34d8ef8d329f5c42c3dfee7fce76a7331f404f3c61e4436481dbd59713ffc0");
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
