import 'package:flutter/material.dart';
import 'package:bheya_network_example/config/config.dart';
import 'package:bheya_network_example/view/splash_screen.dart';
import 'package:provider/provider.dart';

import 'provider/app_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AppProvider()),
    ],
    child: MaterialApp(
      title: "Henibe network",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        colorSchemeSeed: Palette.primaryColor,
      ),
      home: const SplashScreen(),
    ),
  ));
}
