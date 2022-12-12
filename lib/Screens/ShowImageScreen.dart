import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nb_utils/nb_utils.dart';

class ShowImageScreen extends StatefulWidget {
  String? cid;
  ShowImageScreen({this.cid});

  @override
  State<ShowImageScreen> createState() => _ShowImageScreenState();
}

class _ShowImageScreenState extends State<ShowImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Image.network(
          "https://ipfs.io/ipfs/${widget.cid}/image.jpg",
          fit: BoxFit.cover,
        ).center(),
      ),
    );
  }
}
