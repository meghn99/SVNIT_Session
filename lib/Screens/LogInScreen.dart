import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:tutorialapp/Models/userModel.dart';
import 'package:tutorialapp/Screens/HomeScreen.dart';
import 'package:tutorialapp/contract_linking.dart';
import 'package:web3dart/web3dart.dart';

import '../utils/common.dart';
import 'SignUpScreen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController _addressController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  getData(var _client) {
    UserModel data = UserModel();
    data.email = _client[3];
    data.name = _client[2];
    data.password = _passwordController.text;
    data.id = _client[1];
    data.address = _client[0];
    data.type = _client[4];

    return data;
  }

  @override
  Widget build(BuildContext context) {
    var contractLink = Provider.of<ContractLinking>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              60.height,
              Text(
                "Sign In",
                style: boldTextStyle(size: 32),
              ),
              16.height,
              AppTextField(
                decoration: inputDecoration(
                  context,
                  label: "Address",
                ),
                textFieldType: TextFieldType.NAME,
                controller: _addressController,
              ),
              16.height,
              AppTextField(
                  decoration: inputDecoration(
                    context,
                    label: "Password",
                  ),
                  controller: _passwordController,
                  textFieldType: TextFieldType.PASSWORD),
              32.height,
              AppButton(
                text: "Sign in",
                onTap: () async {
                  var _address = EthereumAddress.fromHex(
                      "0x5459cc2871125295174a7F60cECfc3Ca6cAdA2C2");
                  var client = await contractLink.getUserInfo(_address);
                  if (client[4] == _passwordController.text) {
                    UserModel data = getData(client);
                    HomeScreen(user: data).launch(context);
                  }

                  print("data : ${client[4]}");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
