import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;

import 'package:tutorialapp/Models/userModel.dart';
import 'package:tutorialapp/Screens/ShowImageScreen.dart';

class HomeScreen extends StatefulWidget {
  UserModel? user;
  HomeScreen({this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File? _image;
  String cid = "";
  final ImagePicker picker = ImagePicker();
  uploadonIPFS() async {
    var request = http.MultipartRequest(
        "POST", Uri.parse("https://api.nft.storage/upload"));
    request.fields['title'] = "jpg";
    request.headers['Authorization'] =
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJkaWQ6ZXRocjoweDlhRkM3QkRmZjBiZUMwNDVCZEQwMDE3NGJFQzYyYkEzOTlhMjhkREYiLCJpc3MiOiJuZnQtc3RvcmFnZSIsImlhdCI6MTY1OTU0NDcxOTk3NSwibmFtZSI6IlBQTSJ9.NvZLvqC48BrNkgosLoi1Iytt8cFsurvpDHNLtcVVycg";

    var data;
    request.files.add(
      http.MultipartFile(
        'file',
        _image!.readAsBytes().asStream(),
        _image!.lengthSync(),
        filename: "image.jpg",
        contentType: MediaType('image', 'jpg'),
      ),
    );

    var response = await request.send();

    var responseData = await response.stream.toBytes();

    var result = String.fromCharCodes(responseData);

    var jsonData = json.decode(result);

    var _cid = jsonData['value']['cid'];

    setState(() {
      cid = _cid;
    });

    print(" cid is: $_cid");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Name : ${widget.user!.name}",
              style: primaryTextStyle(size: 20)),
          Text("Email : ${widget.user!.email}",
              style: primaryTextStyle(size: 20)),
          Text("Address : ${widget.user!.address}",
              style: primaryTextStyle(size: 20)),
          50.height,
          AppButton(
              text: "Upload",
              onTap: () async {
                await ImagePicker.pickImage(source: ImageSource.gallery)
                    .then((value) => setState(() {
                          _image = value;
                        }));
                await uploadonIPFS();
                toast("Image Uploaded");
              }),
          16.height,
          AppButton(
              text: "Show Image",
              onTap: () {
                ShowImageScreen(
                  cid: cid,
                ).launch(context);
              })
        ],
      ),
    );
  }
}
