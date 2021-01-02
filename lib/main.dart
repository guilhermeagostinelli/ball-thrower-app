import 'package:ball_thrower_app/Notifiers/CommandCenterNotifier.dart';
import 'package:ball_thrower_app/Pages/CommandCenterPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:asuka/asuka.dart' as asuka;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CommandCenterNotifier(),
        ),
      ],
      child: MaterialApp(
        title: 'Ball Thrower',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: CommandCenterPage(),
        builder: asuka.builder,
      ),
    );
  }
}

