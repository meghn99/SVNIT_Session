import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:tutorialapp/Screens/LogInScreen.dart';
import 'package:tutorialapp/Screens/SignUpScreen.dart';

import 'contract_linking.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContractLinking>(
      create: (_) => ContractLinking(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Tutorial App",
        home: SignUpScreen(),
      ),
    );
  }
}
