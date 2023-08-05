// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:bheya_network_example/db/models/data_field.dart';
import 'package:bheya_network_example/db/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:bheya_network/bheya_network.dart';
import 'package:bheya_network/cellResponse.dart';
import 'package:bheya_network_example/widget/mobile.dart';
import 'package:carrier_info_v3/carrier_info.dart';
import 'package:csv/csv.dart';
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
  DataField? dataField;
  List? _listHistorique;
  List? get listHistorique => _listHistorique;

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
    var statut = await providerCheckGps();
    if (statut) {
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
  }

  // Pour le temps
  providerDateTime(var context) {
    Timer.periodic(const Duration(seconds: 3), (timer) async {
      _date = DateTime.now().toString();
      ServiceApi.fetchIPInformation(context);
      if (cellsResponse != null) {
        providerInsertDataField(data: cellsResponse!.primaryCellList![0]);
        providerListHistorique();
      }

      await initSimCardsData();
      await initPhoneInfo();
      await providerWifiCellularLevelStrength();
      await providerCellInfo();
      await providerGetLocation();

      notifyListeners();
    });
  }

  testSpedd() {
    speedTest.startTesting(
      onDone: (download, upload) {},
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

  Future<void> generateCSV(context) async {
    List<List<String>> csvData = [
      // headers
      <String>[
        'year',
        'month',
        'month',
        'day',
        'hour',
        'minutes',
        'manufacturer',
        'brand',
        'device',
        'model',
        'latitude',
        'longitude',
        'altitude',
        'userSpeed',
        'networktype',
        'registrationn',
        'connectionStatus',
        'operator',
        'nci',
        'cid',
        'basestationId',
        'networkId',
        'systemId',
        'mcc',
        'mnc',
        'ci',
        'pci',
        'tac',
        'lac',
        'bandwidth',
        'arfcn',
        'earfcn',
        'uarfcn',
        'level',
        'evdolevel',
        'dBm',
        'cDMADBm',
        'eVDODBm',
        'aSU',
        'rSSNR',
        'rSRP',
        'rSRQ',
        'rSSI',
        'bITERRORRATE',
        'sNR',
        'eVDOSNR',
        'eCNO',
        'rSCP',
        'cQI',
        'cQITABLEINDEX',
        'cSIRSRP',
        'sSSRP',
        'cIRSRQ',
        'sSRSRQ',
        'cSISINR',
        'sSSINR',
        'dataSignalStrength',
        'downlinkSpeed',
        'uplinkSpeed'
      ],
      // data
      for (int i = 0; i < listHistorique!.length; i++)
        [
          "${listHistorique![i]['year']}",
          "${listHistorique![i]['month']}",
          "${listHistorique![i]['month']}",
          "${listHistorique![i]['day']}",
          "${listHistorique![i]['hour']}",
          "${listHistorique![i]['minutes']}",
          "${listHistorique![i]['manufacturer']}",
          "${listHistorique![i]['brand']}",
          "${listHistorique![i]['device']}",
          "${listHistorique![i]['model']}",
          "${listHistorique![i]['latitude']}",
          "${listHistorique![i]['longitude']}",
          "${listHistorique![i]['altitude']}",
          "${listHistorique![i]['userSpeed']}",
          "${listHistorique![i]['networktype']}",
          "${listHistorique![i]['registrationn']}",
          "${listHistorique![i]['connectionStatus']}",
          "${listHistorique![i]['operator']}",
          "${listHistorique![i]['nci']}",
          "${listHistorique![i]['cid']}",
          "${listHistorique![i]['basestationId']}",
          "${listHistorique![i]['networkId']}",
          "${listHistorique![i]['systemId']}",
          "${listHistorique![i]['mcc']}",
          "${listHistorique![i]['mnc']}",
          "${listHistorique![i]['ci']}",
          "${listHistorique![i]['pci']}",
          "${listHistorique![i]['tac']}",
          "${listHistorique![i]['lac']}",
          "${listHistorique![i]['bandwidth']}",
          "${listHistorique![i]['arfcn']}",
          "${listHistorique![i]['earfcn']}",
          "${listHistorique![i]['uarfcn']}",
          "${listHistorique![i]['level']}",
          "${listHistorique![i]['evdolevel']}",
          "${listHistorique![i]['dBm']}",
          "${listHistorique![i]['cDMADBm']}",
          "${listHistorique![i]['eVDODBm']}",
          "${listHistorique![i]['aSU']}",
          "${listHistorique![i]['rSSNR']}",
          "${listHistorique![i]['rSRP']}",
          "${listHistorique![i]['rSRQ']}",
          "${listHistorique![i]['rSSI']}",
          "${listHistorique![i]['bITERRORRATE']}",
          "${listHistorique![i]['sNR']}",
          "${listHistorique![i]['eVDOSNR']}",
          "${listHistorique![i]['eCNO']}",
          "${listHistorique![i]['rSCP']}",
          "${listHistorique![i]['cQI']}",
          "${listHistorique![i]['cQITABLEINDEX']}",
          "${listHistorique![i]['cSIRSRP']}",
          "${listHistorique![i]['sSSRP']}",
          "${listHistorique![i]['cIRSRQ']}",
          "${listHistorique![i]['sSRSRQ']}",
          "${listHistorique![i]['cSISINR']}",
          "${listHistorique![i]['sSSINR']}",
          "${listHistorique![i]['dataSignalStrength']}",
          "${listHistorique![i]['downlinkSpeed']}",
          "${listHistorique![i]['uplinkSpeed']}"
        ]
    ];

    String csv = const ListToCsvConverter().convert(csvData);
    String fileName = "henibenetwork_log${DateTime.now()}.csv";
    saveCSVFile(csv, fileName, context);
  }

  providerInsertDataField({var data}) async {
    int? counter = await getCount();
    if (data.type == "gsm".toUpperCase()) {
      dataField = DataField(
          id: counter! + 1,
          year: DateTime.now().year.toString(),
          day: DateTime.now().day.toString(),
          hour: DateTime.now().hour.toString(),
          minutes: DateTime.now().minute.toString(),
          seconds: DateTime.now().second.toString(),
          month: DateTime.now().month.toString(),
          manufacturer: manufacturer ?? "",
          brand: brand ?? "",
          device: brand ?? "",
          model: model ?? "",
          latitude: lat ?? "",
          longitude: long ?? "",
          altitude: altitude ?? "",
          userSpeed: speedMps.toString(),
          networktype: cellsResponse!.primaryCellList![0].type.toString(),
          registrationn: networkGeneration ?? "",
          connectionStatus: cellsResponse!
              .primaryCellList![0].gsm!.connectionStatus
              .toString(),
          operator: simOperator ?? "",
          nci: mobileCountryCode ?? "",
          cid: cid ?? "",
          networkId: mobileCountryCode ?? "",
          basestationId: mobileCountryCode ?? "",
          systemId: idPhone ?? "",
          mcc: cellsResponse!.primaryCellList![0].gsm!.network!.mcc.toString(),
          mnc: cellsResponse!.primaryCellList![0].gsm!.network!.mnc.toString(),
          ci: "",
          pci: "",
          tac: "",
          lac: "",
          bandwidth: "",
          arfcn:
              cellsResponse!.primaryCellList![0].gsm!.bandGSM!.arfcn.toString(),
          earfcn: "",
          uarfcn: "",
          level: "3",
          evdolevel: "",
          dBm:
              cellsResponse!.primaryCellList![0].gsm!.signalGSM!.dbm.toString(),
          cDMADBm: "",
          eVDODBm: "",
          aSU: cellsResponse!.primaryCellList![0].gsm!.signalGSM!.rssi
              .toString(),
          rSSNR: "",
          rSRP: "",
          rSRQ: "",
          rSSI: "",
          bITERRORRATE: cellsResponse!
              .primaryCellList![0].gsm!.signalGSM!.bitErrorRate
              .toString(),
          sNR: "",
          eVDOSNR: "",
          eCNO: "",
          rSCP: "",
          cIRSRQ: "",
          cQI: "",
          cQITABLEINDEX: "",
          cSIRSRP: "",
          cSISINR: "",
          dataSignalStrength: "",
          downlinkSpeed: "",
          sSRSRQ: "",
          sSSINR: "",
          sSSRP: "",
          uplinkSpeed: "");
    }
    if (data.type == "lte".toUpperCase()) {
      dataField = DataField(
          id: counter! + 1,
          year: DateTime.now().year.toString(),
          day: DateTime.now().day.toString(),
          hour: DateTime.now().hour.toString(),
          minutes: DateTime.now().minute.toString(),
          seconds: DateTime.now().second.toString(),
          month: DateTime.now().month.toString(),
          manufacturer: manufacturer ?? "",
          brand: brand ?? "",
          device: brand ?? "",
          model: model ?? "",
          latitude: lat ?? "",
          longitude: long ?? "",
          altitude: altitude ?? "",
          userSpeed: speedMps.toString(),
          networktype: cellsResponse!.primaryCellList![0].type.toString(),
          registrationn: networkGeneration ?? "",
          connectionStatus: cellsResponse!
              .primaryCellList![0].lte!.connectionStatus
              .toString(),
          operator: simOperator ?? "",
          nci: mobileCountryCode ?? "",
          cid: cid ?? "",
          networkId: mobileCountryCode ?? "",
          basestationId: mobileCountryCode ?? "",
          systemId: idPhone ?? "",
          mcc: cellsResponse!.primaryCellList![0].lte!.network!.mcc.toString(),
          mnc: cellsResponse!.primaryCellList![0].lte!.network!.mnc.toString(),
          ci: "",
          pci: cellsResponse!.primaryCellList![0].lte!.pci.toString(),
          tac: cellsResponse!.primaryCellList![0].lte!.tac.toString(),
          lac:
              cellsResponse!.primaryCellList![0].lte!.signalLTE!.cqi.toString(),
          bandwidth:
              cellsResponse!.primaryCellList![0].lte!.bandwidth.toString(),
          arfcn: "",
          earfcn: cellsResponse!
              .primaryCellList![0].lte!.bandLTE!.downlinkEarfcn
              .toString(),
          uarfcn: "",
          level: "3",
          evdolevel: "",
          dBm:
              cellsResponse!.primaryCellList![0].lte!.signalLTE!.dbm.toString(),
          cDMADBm: "",
          eVDODBm: "",
          aSU: cellsResponse!.primaryCellList![0].lte!.signalLTE!.rssiAsu
              .toString(),
          rSSNR: "",
          rSRP: cellsResponse!.primaryCellList![0].lte!.signalLTE!.rsrp
              .toString(),
          rSRQ: cellsResponse!.primaryCellList![0].lte!.signalLTE!.rsrq
              .toString(),
          rSSI: cellsResponse!.primaryCellList![0].lte!.signalLTE!.rssi
              .toString(),
          bITERRORRATE: cellsResponse!
              .primaryCellList![0].gsm!.signalGSM!.bitErrorRate
              .toString(),
          sNR: "",
          eVDOSNR: "",
          eCNO: "",
          rSCP: "",
          cIRSRQ: "",
          cQI: "",
          cQITABLEINDEX: "",
          cSIRSRP: "",
          cSISINR: "",
          dataSignalStrength: "",
          downlinkSpeed: "",
          sSRSRQ: "",
          sSSINR: "",
          sSSRP: "",
          uplinkSpeed: "");
    }
    if (data.type == "nr".toUpperCase()) {
      dataField = DataField(
          id: counter! + 1,
          year: DateTime.now().year.toString(),
          day: DateTime.now().day.toString(),
          hour: DateTime.now().hour.toString(),
          minutes: DateTime.now().minute.toString(),
          seconds: DateTime.now().second.toString(),
          month: DateTime.now().month.toString(),
          manufacturer: manufacturer ?? "",
          brand: brand ?? "",
          device: brand ?? "",
          model: model ?? "",
          latitude: lat ?? "",
          longitude: long ?? "",
          altitude: altitude ?? "",
          userSpeed: speedMps.toString(),
          networktype: cellsResponse!.primaryCellList![0].type.toString(),
          registrationn: networkGeneration ?? "",
          connectionStatus: cellsResponse!
              .primaryCellList![0].nr!.connectionStatus
              .toString(),
          operator: simOperator ?? "",
          nci: mobileCountryCode ?? "",
          cid: cid ?? "",
          networkId: mobileCountryCode ?? "",
          basestationId: mobileCountryCode ?? "",
          systemId: idPhone ?? "",
          mcc: cellsResponse!.primaryCellList![0].nr!.network!.mcc.toString(),
          mnc: cellsResponse!.primaryCellList![0].nr!.network!.mcc.toString(),
          ci: "",
          pci: cellsResponse!.primaryCellList![0].nr!.pci.toString(),
          tac: cellsResponse!.primaryCellList![0].nr!.tac.toString(),
          lac: "",
          bandwidth: "",
          arfcn: "",
          earfcn: "",
          uarfcn: "",
          level: "3",
          evdolevel: "",
          dBm: cellsResponse!.primaryCellList![0].nr!.signalNR!.dbm.toString(),
          cDMADBm: "",
          eVDODBm: "",
          aSU: cellsResponse!.primaryCellList![0].nr!.signalNR!.csiRsrpAsu
              .toString(),
          rSSNR: "",
          rSRP: "",
          rSRQ: "",
          rSSI: "",
          bITERRORRATE: "",
          sNR: cellsResponse!.primaryCellList![0].nr!.signalNR!.ssSinr
              .toString(),
          eVDOSNR: "",
          eCNO: "",
          rSCP: "",
          cIRSRQ: "",
          cQI: "",
          cQITABLEINDEX: "",
          cSIRSRP: cellsResponse!.primaryCellList![0].nr!.signalNR!.csiRsrp
              .toString(),
          cSISINR: cellsResponse!.primaryCellList![0].nr!.signalNR!.csiSinr
              .toString(),
          dataSignalStrength: "",
          downlinkSpeed: "",
          sSRSRQ: cellsResponse!.primaryCellList![0].nr!.signalNR!.ssRsrp
              .toString(),
          sSSINR: cellsResponse!.primaryCellList![0].nr!.signalNR!.ssSinr
              .toString(),
          sSSRP: cellsResponse!.primaryCellList![0].nr!.signalNR!.ssRsrp
              .toString(),
          uplinkSpeed: "");
    }
    if (data.type == "tdscdma".toUpperCase()) {
      dataField = DataField(
          id: counter! + 1,
          year: DateTime.now().year.toString(),
          day: DateTime.now().day.toString(),
          hour: DateTime.now().hour.toString(),
          minutes: DateTime.now().minute.toString(),
          seconds: DateTime.now().second.toString(),
          month: DateTime.now().month.toString(),
          manufacturer: manufacturer ?? "",
          brand: brand ?? "",
          device: brand ?? "",
          model: model ?? "",
          latitude: lat ?? "",
          longitude: long ?? "",
          altitude: altitude ?? "",
          userSpeed: speedMps.toString(),
          networktype: cellsResponse!.primaryCellList![0].type ?? "",
          registrationn: networkGeneration ?? "",
          connectionStatus: cellsResponse!
              .primaryCellList![0].tdscdma!.connectionStatus
              .toString(),
          operator: simOperator ?? "",
          nci: mobileCountryCode ?? "",
          cid: cid ?? "",
          networkId: mobileCountryCode ?? "",
          basestationId: mobileCountryCode ?? "",
          systemId: idPhone ?? "",
          mcc: cellsResponse!.primaryCellList![0].tdscdma!.network!.mcc
              .toString(),
          mnc: cellsResponse!.primaryCellList![0].tdscdma!.network!.mnc
              .toString(),
          ci: "",
          pci: "",
          tac: "",
          lac: "",
          bandwidth: "",
          arfcn: "",
          earfcn: "",
          uarfcn: "",
          level: "3",
          evdolevel: "",
          dBm: cellsResponse!.primaryCellList![0].tdscdma!.signalTDSCDMA!.dbm
              .toString(),
          cDMADBm: cellsResponse!
              .primaryCellList![0].tdscdma!.signalTDSCDMA!.dbm
              .toString(),
          eVDODBm: "",
          aSU: cellsResponse!
              .primaryCellList![0].tdscdma!.signalTDSCDMA!.rssiAsu
              .toString(),
          rSSNR: "",
          rSRP: "",
          rSRQ: "",
          rSSI: cellsResponse!.primaryCellList![0].tdscdma!.signalTDSCDMA!.rssi
              .toString(),
          bITERRORRATE: cellsResponse!
              .primaryCellList![0].gsm!.signalGSM!.bitErrorRate
              .toString(),
          sNR: "",
          eVDOSNR: "",
          eCNO: "",
          rSCP: cellsResponse!.primaryCellList![0].tdscdma!.signalTDSCDMA!.rscp
              .toString(),
          cIRSRQ: "",
          cQI: "",
          cQITABLEINDEX: "",
          cSIRSRP: "",
          cSISINR: "",
          dataSignalStrength: "",
          downlinkSpeed: "",
          sSRSRQ: "",
          sSSINR: "",
          sSSRP: "",
          uplinkSpeed: "");
    }
    if (data.type == "wcdma".toUpperCase()) {
      dataField = DataField(
          id: counter! + 1,
          year: DateTime.now().year.toString(),
          day: DateTime.now().day.toString(),
          hour: DateTime.now().hour.toString(),
          minutes: DateTime.now().minute.toString(),
          seconds: DateTime.now().second.toString(),
          month: DateTime.now().month.toString(),
          manufacturer: manufacturer ?? "",
          brand: brand ?? "",
          device: brand ?? "",
          model: model ?? "",
          latitude: lat ?? "",
          longitude: long ?? "",
          altitude: altitude ?? "",
          userSpeed: speedMps.toString(),
          networktype: cellsResponse!.primaryCellList![0].type ?? "",
          registrationn: networkGeneration ?? "",
          connectionStatus: cellsResponse!
              .primaryCellList![0].wcdma!.connectionStatus
              .toString(),
          operator: simOperator ?? "",
          nci: mobileCountryCode ?? "",
          cid: cid ?? "",
          networkId: mobileCountryCode ?? "",
          basestationId: mobileCountryCode ?? "",
          systemId: idPhone ?? "",
          mcc:
              cellsResponse!.primaryCellList![0].wcdma!.network!.mcc.toString(),
          mnc:
              cellsResponse!.primaryCellList![0].wcdma!.network!.mnc.toString(),
          ci: "",
          pci: "",
          tac: "",
          lac: "",
          bandwidth: "",
          arfcn: "",
          earfcn: "",
          uarfcn: "",
          level: "3",
          evdolevel: "",
          dBm: cellsResponse!.primaryCellList![0].wcdma!.signalWCDMA!.dbm
              .toString(),
          cDMADBm: "",
          eVDODBm: "",
          aSU: cellsResponse!.primaryCellList![0].wcdma!.signalWCDMA!.rssiAsu
              .toString(),
          rSSNR: "",
          rSRP: "",
          rSRQ: "",
          rSSI: cellsResponse!.primaryCellList![0].wcdma!.signalWCDMA!.rssi
              .toString(),
          bITERRORRATE: cellsResponse!
              .primaryCellList![0].wcdma!.signalWCDMA!.bitErrorRate
              .toString(),
          sNR: "",
          eVDOSNR: "",
          eCNO: "",
          rSCP: cellsResponse!.primaryCellList![0].wcdma!.signalWCDMA!.rscp
              .toString(),
          cIRSRQ: "",
          cQI: "",
          cQITABLEINDEX: "",
          cSIRSRP: "",
          cSISINR: "",
          dataSignalStrength: "",
          downlinkSpeed: cellsResponse!
              .primaryCellList![0].wcdma!.signalWCDMA!.ecno
              .toString(),
          sSRSRQ: "",
          sSSINR: "",
          sSSRP: "",
          uplinkSpeed: "");
    }
    if (data.type == "cdma".toUpperCase()) {
      dataField = DataField(
          id: counter! + 1,
          year: DateTime.now().year.toString(),
          day: DateTime.now().day.toString(),
          hour: DateTime.now().hour.toString(),
          minutes: DateTime.now().minute.toString(),
          seconds: DateTime.now().second.toString(),
          month: DateTime.now().month.toString(),
          manufacturer: manufacturer ?? "",
          brand: brand ?? "",
          device: brand ?? "",
          model: model ?? "",
          latitude: lat ?? "",
          longitude: long ?? "",
          altitude: altitude ?? "",
          userSpeed: speedMps.toString(),
          networktype: cellsResponse!.primaryCellList![0].type ?? "",
          registrationn: networkGeneration ?? "",
          connectionStatus: cellsResponse!
              .primaryCellList![0].cdma!.connectionStatus
              .toString(),
          operator: simOperator ?? "",
          nci: mobileCountryCode ?? "",
          cid: cid ?? "",
          networkId: mobileCountryCode ?? "",
          basestationId: mobileCountryCode ?? "",
          systemId: idPhone ?? "",
          mcc: cellsResponse!.primaryCellList![0].cdma!.network!.mcc.toString(),
          mnc: cellsResponse!.primaryCellList![0].cdma!.network!.mnc.toString(),
          ci: "",
          pci: "",
          tac: "",
          lac: "",
          bandwidth: "",
          arfcn: "",
          earfcn: "",
          uarfcn: "",
          level: "3",
          evdolevel: cellsResponse!
              .primaryCellList![0].cdma!.signalCDMA!.evdoRssi
              .toString(),
          dBm: cellsResponse!.primaryCellList![0].cdma!.signalCDMA!.dbm
              .toString(),
          cDMADBm: "",
          eVDODBm: cellsResponse!.primaryCellList![0].cdma!.signalCDMA!.cdmaRssi
              .toString(),
          aSU: "",
          rSSNR: "",
          rSRP: "",
          rSRQ: "",
          rSSI: "",
          bITERRORRATE: cellsResponse!
              .primaryCellList![0].gsm!.signalGSM!.bitErrorRate
              .toString(),
          sNR: "",
          eVDOSNR: cellsResponse!.primaryCellList![0].cdma!.signalCDMA!.evdoSnr
              .toString(),
          eCNO: "",
          rSCP: "",
          cIRSRQ: "",
          cQI: "",
          cQITABLEINDEX: "",
          cSIRSRP: "",
          cSISINR: "",
          dataSignalStrength: "",
          downlinkSpeed: "",
          sSRSRQ: "",
          sSSINR: "",
          sSSRP: "",
          uplinkSpeed: "");
    }
    insertDataField(dataField: dataField);
  }

  providerListHistorique() async {
    _listHistorique = await getData();
    notifyListeners();
  }
}
