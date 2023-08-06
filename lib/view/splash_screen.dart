// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bheya_network_example/provider/app_provider.dart';
import '../widget/widget.dart';
import 'home_network_station.dart';

class SplashScreen extends StatefulWidget {
  final bool? userIsLog;
  final Function? onStart;
  const SplashScreen({Key? key, this.userIsLog, required this.onStart})
      : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
    

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () async {
      await Provider.of<AppProvider>(context, listen: false)
          .providerCheckPermission();
      await pushNewPageRemoveUntil(
          HomeNetworkStation(onStart: widget.onStart), context);
      await Provider.of<AppProvider>(context, listen: false)
          .providerDateTime(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Image.asset("assets/bts.png", height: 120.0),
                const SizedBox(height: 20.0),
                const CustomText("Henibe network", fontSize: 25),
                const SizedBox(height: 70.0),
                const CircularProgressIndicator(),
                const SizedBox(height: 55.0)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
