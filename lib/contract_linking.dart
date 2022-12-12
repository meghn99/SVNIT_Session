// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:web3dart/credentials.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class ContractLinking extends ChangeNotifier {
  final String _rpcUrl = "http://10.0.2.2:7545";
  final String _wsUrl = "ws://10.0.2.2:7545/";
  String _privateKey = getStringAsync("privateKey");

  Web3Client? _client;
  bool isLoading = true;

  String? _abiCode;

  EthereumAddress? _contractAddress;

  Credentials? _credentials;

  DeployedContract? _contract;

  ContractFunction? _createUser;
  ContractFunction? _getUser;
  ContractFunction? _addPublicKey;
  ContractFunction? _getPublicKeyWithEnroll;

  ContractLinking() {
    initialSetup();
  }

  initialSetup() async {
    print("pKey  :$_privateKey");

    // establish a connection to the ethereum rpc node. The socketConnector
    // property allows more efficient event streams over websocket instead of
    // http-polls. However, the socketConnector property is experimental.
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });

    await getAbi();
    await getCredentials();
    await getDeployedUserContract();
  }

  Future<void> getAbi() async {
    // Reading the contract abi

    String abiStringFile =
        await rootBundle.loadString("src/artifacts/Users.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);

    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
    print("Contract address: ${_contractAddress}");
  }

  Future<void> getCredentials() async {
    _privateKey = await getStringAsync("privateKey");
    _credentials = await _client!.credentialsFromPrivateKey(_privateKey);
  }

  Future<void> getDeployedUserContract() async {
    // Telling Web3dart where our contract is declared.
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "Users"), _contractAddress);
    // Extracting the functions, declared in contract.
    _createUser = _contract!.function("createUser");
    _getUser = _contract!.function("users");
  }

  getUserInfo(EthereumAddress address) async {
    // Getting the current name declared in the smart contract.
    var userInfo = await _client!
        .call(contract: _contract, function: _getUser, params: [address]);
    var deployedName = await userInfo;
    isLoading = false;
    print(deployedName);
    notifyListeners();
    return deployedName;
  }

  
  Future<String> verifyPassword(EthereumAddress enroll) async {
    var deployedName = await getUserInfo(enroll);
    // print("deployed name : ${deployedName[2]}");
    String pw = deployedName[4].toString();
    return pw;
  }

  Future<String> getUsername(EthereumAddress enroll) async {
    var deployedName = await getUserInfo(enroll);
    // print("deployed name : ${deployedName[2]}");
    String name = deployedName[2].toString();
    return name;
  }

  // addressArray() async {
  //   var addressInfo = await _client!
  //       .call(contract: _contract, function: _getData, params: []);
  //   var addressArrays = await addressInfo;
  //   isLoading = false;
  //   // print(addressArrays);
  //   notifyListeners();
  //   return addressArrays;
  // }

  // Future getPublickKeys() async {
  //   var publicArray = await addressArray();
  //   return publicArray;
  // }

  addUser(EthereumAddress address, String id, String name, String email,
      String password) async {
    isLoading = true;
    notifyListeners();
    await _client!.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _createUser,
            parameters: [address, id, name, email, password],
            maxGas: 1000000));

    await getUserInfo(address);
  }
}
