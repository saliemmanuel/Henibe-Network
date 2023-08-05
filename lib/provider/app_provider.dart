// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';

import 'package:bheya_network/bheya_network.dart';
import 'package:bheya_network/cellResponse.dart';
import 'package:bheya_network_example/widget/mobile.dart';
import 'package:carrier_info_v3/carrier_info.dart';
import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_internet_speed_test/flutter_internet_speed_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:signal_strength/signal_strength.dart';
import 'package:sim_data/sim_data.dart';
import 'package:phoneinformations/phoneinformations.dart';

import '../api/models/reponse.dart';
import '../api/service.dart';

class AppProvider extends ChangeNotifier {
  SignalStrength? _signalStrengthPlugin;
  int? _wifiStrength;
  List<int>? _cellStrength;
  CellsResponse? _cellsResponse;
  dynamic _simJson;
  bool servicestatus = false;
  bool haspermission = false;
  LocationPermission? _permission;
  Position? _position;
  CarrierData? _carrierInfo;
  String? _long, _lat, _altitude, _date;
  double? _speedMps, _speedAccuracy;
  ResponseData? _responseData;
  final speedTest = FlutterInternetSpeedTest();

  SimData? _simData;
  String? _model;
  String? _andoidVersion;
  String? _serial;
  String? _idPhone;
  String? _androidId;
  String? _manufacturer;
  String? _brand;
  String? _sdkInt;
  String? _simSerialNumber;
  String? _simNumber;
  String? _subscriberID;
  String? _networkCountryISO;
  String? _simCountryISO;
  String? _softwareVersion;
  String? _voiceMailNumber;
  String? _networkType;
  String? _networkGeneration;
  String? _cid;
  String? _lac;
  String? _simOperator;
  String? _mobileNetworkCode;
  String? _mobileCountryCode;

  int? get wifiStrength => _wifiStrength;
  List<int>? get cellStrength => _cellStrength;
  CellsResponse? get cellsResponse => _cellsResponse;
  dynamic get simJson => _simJson;
  LocationPermission? get permission => _permission;
  Position? get position => _position;
  CarrierData? get carrierInfo => _carrierInfo;
  String? get long => _long;
  String? get lat => _lat;
  String? get altitude => _altitude;
  String? get date => _date;
  double? get speedMps => _speedMps;
  double? get speedAccuracy => _speedAccuracy;
  SignalStrength? get signalStrengthPlugin => _signalStrengthPlugin;
  ResponseData? get responseData => _responseData;
  SimData? get simData => _simData;

  String? get model => _model;
  String? get andoidVersion => _andoidVersion;
  String? get serial => _serial;
  String? get idPhone => _idPhone;
  String? get androidId => _androidId;
  String? get manufacturer => _manufacturer;
  String? get brand => _brand;
  String? get sdkInt => _sdkInt;
  String? get simSerialNumber => _simSerialNumber;
  String? get simNumber => _simNumber;
  String? get subscriberID => _subscriberID;
  String? get networkCountryISO => _networkCountryISO;
  String? get simCountryISO => _simCountryISO;
  String? get softwareVersion => _softwareVersion;
  String? get voiceMailNumber => _voiceMailNumber;
  String? get networkType => _networkType;
  String? get networkGeneration => _networkGeneration;
  String? get cid => _cid;
  String? get lac => _lac;
  String? get simOperator => _simOperator;
  String? get mobileNetworkCode => _mobileNetworkCode;
  String? get mobileCountryCode => _mobileCountryCode;

  set setResponseData(ResponseData responseData) {
    _responseData = responseData;
  }

  // Pour la récupération du niveau de barre
  // réseau du wifi ou de la sim
  providerWifiCellularLevelStrength() async {
    _signalStrengthPlugin = SignalStrength();
    _wifiStrength = await _signalStrengthPlugin!.getWifiSignalStrength();
    _cellStrength = await _signalStrengthPlugin!.getCellularSignalStrength();
    notifyListeners();
  }

  // Pour la récupération des permission de l'utilisateur
  // afin d'acceder :
  // `location`
  // `storage`
  // `phone`
  // `locationWhenInUse`
  providerCheckPermission() async {
    await [
      Permission.location,
      Permission.storage,
      Permission.phone,
      Permission.locationWhenInUse,
    ].request();
    notifyListeners();
  }

  // Recupération information des :
  // Cellule à côté du téléphone
  // La cellule principale où est connecté le téléphone en temps réel
  Future<void> providerCellInfo() async {
    CellsResponse? cellsResponse;
    try {
      String data = await BheyaNetwork.getCellInfo ?? "";
      final body = jsonDecode(data);
      cellsResponse = CellsResponse.fromJson(body);
      String simInfo = await BheyaNetwork.getSIMInfo ?? "";
      _simJson = jsonDecode(simInfo);
      notifyListeners();
    } on PlatformException {
      _cellsResponse = null;
    }
    _cellsResponse = cellsResponse;
    notifyListeners();
  }

  // Vérification si le GPS est actif ou pas
  providerCheckGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      _permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        _permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
        } else if (permission == LocationPermission.deniedForever) {
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }
    } else {
      haspermission = false;
    }
    notifyListeners();
    return haspermission;
  }

  // Récupération des informations de localisation de l'utilisateur
  providerGetLocation() async {
    _position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    _long = position?.longitude.toString();
    _lat = position?.latitude.toString();
    Geolocator.getPositionStream().listen((positions) {
      _speedMps = positions.speed;
      _altitude = positions.heading.toString();
      _speedAccuracy = positions.accuracy;
    });
    notifyListeners();
  }

  // Pour le temps
  providerDateTime(var context) {
    Timer.periodic(const Duration(seconds: 3), (timer) {
      _date = DateTime.now().toString();
      ServiceApi.fetchIPInformation(context);
      initSimCardsData();
      initPhoneInfo();
      providerWifiCellularLevelStrength();
      providerCellInfo();
      providerGetLocation();
      notifyListeners();
    });
  }

  testSpedd() {
    speedTest.startTesting(
      onDone: (download, upload) {
      },
      onProgress: (percent, data) {},
      onError: (errorMessage, speedTestError) {},
    );
  }

  Future<void> initSimCardsData() async {
    try {
      var status = await Permission.phone.status;
      if (!status.isGranted) {
        bool isGranted = await Permission.phone.request().isGranted;
        if (!isGranted) return;
      }
      _simData = await SimDataPlugin.getSimData();
    } catch (e) {
      debugPrint(e.toString());
      _simData = null;
    }
  }

  Future<void> initPhoneInfo() async {
    PhoneInfo phoneInfos;
    try {
      phoneInfos = await Phoneinformations.getPhoneInformation();
      _model = phoneInfos.model;
      _andoidVersion = phoneInfos.andoidVersion;
      _serial = phoneInfos.serial;
      _idPhone = phoneInfos.id;
      _androidId = phoneInfos.androidId;
      _manufacturer = phoneInfos.manufacturer;
      _sdkInt = phoneInfos.sdkInt;
      _simSerialNumber = phoneInfos.simSerialNumber;
      _simNumber = phoneInfos.simNumber;
      _subscriberID = phoneInfos.subscriberID;
      _networkCountryISO = phoneInfos.networkCountryISO;
      _simCountryISO = phoneInfos.simCountryISO;
      _mobileNetworkCode = phoneInfos.mobileNetworkCode;
      _mobileCountryCode = phoneInfos.mobileCountryCode;
      _softwareVersion = phoneInfos.softwareVersion;
      _voiceMailNumber = phoneInfos.voiceMailNumber;
      _networkType = phoneInfos.networkType;
      _networkGeneration = phoneInfos.networkGeneration;
      _cid = phoneInfos.cid;
      _lac = phoneInfos.lac;
      _simOperator = phoneInfos.simOperator;
      _brand = phoneInfos.brand;
    } catch (e) {
      print("Failed to get phone infos, error : $e");
    }
  }

  void exportToExcel(var context) async {
    final excel = Excel.createExcel();
    final Sheet sheet = excel[excel.getDefaultSheet()!];
    for (var row = 0; row < 100; row++) {
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
          .value = 'FLUTTER';

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row))
          .value = 'is';

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: row))
          .value = "Google's";

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: row))
          .value = "UI";

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: row))
          .value = "toolkit";
    }
 
    var fileBytes = excel.save();
    var fileName = "henibenetwork_log${DateTime.now()}.csv";
    saveFile(fileBytes!, fileName, context);
  }
}
