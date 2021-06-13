import 'package:flutter/material.dart';
import 'package:swipeable/myHomePage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

Future main() async {
  await DotEnv.load(fileName: "lib/.env");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
