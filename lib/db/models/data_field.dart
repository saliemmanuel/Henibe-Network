import 'dart:convert';

class DataField {
  final int id;
  final String year;
  final String month;
  final String day;
  final String hour;
  final String minutes;
  final String seconds;
  final String manufacturer;
  final String brand;
  final String device;
  final String model;
  final String latitude;
  final String longitude;
  final String altitude;
  final String userSpeed;
  final String networktype;
  final String registrationn;
  final String connectionStatus;
  final String operator;
  final String nci;
  final String cid;
  final String basestationId;
  final String networkId;
  final String systemId;
  final String mcc;
  final String mnc;
  final String ci;
  final String pci;
  final String tac;
  final String lac;
  final String bandwidth;
  final String arfcn;
  final String earfcn;
  final String uarfcn;
  final String level;
  final String evdolevel;
  final String dBm;
  final String cDMADBm;
  final String eVDODBm;
  final String aSU;
  final String rSSNR;
  final String rSRP;
  final String rSRQ;
  final String rSSI;
  final String bITERRORRATE;
  final String sNR;
  final String eVDOSNR;
  final String eCNO;
  final String rSCP;
  final String cQI;
  final String cQITABLEINDEX;
  final String cSIRSRP;
  final String sSSRP;
  final String cIRSRQ;
  final String sSRSRQ;
  final String cSISINR;
  final String sSSINR;
  final String dataSignalStrength;
  final String downlinkSpeed;
  final String uplinkSpeed;

  
  DataField({
    required this.id,
    required this.year,
    required this.month,
    required this.day,
    required this.hour,
    required this.minutes,
    required this.seconds,
    required this.manufacturer,
    required this.brand,
    required this.device,
    required this.model,
    required this.latitude,
    required this.longitude,
    required this.altitude,
    required this.userSpeed,
    required this.networktype,
    required this.registrationn,
    required this.connectionStatus,
    required this.operator,
    required this.nci,
    required this.cid,
    required this.basestationId,
    required this.networkId,
    required this.systemId,
    required this.mcc,
    required this.mnc,
    required this.ci,
    required this.pci,
    required this.tac,
    required this.lac,
    required this.bandwidth,
    required this.arfcn,
    required this.earfcn,
    required this.uarfcn,
    required this.level,
    required this.evdolevel,
    required this.dBm,
    required this.cDMADBm,
    required this.eVDODBm,
    required this.aSU,
    required this.rSSNR,
    required this.rSRP,
    required this.rSRQ,
    required this.rSSI,
    required this.bITERRORRATE,
    required this.sNR,
    required this.eVDOSNR,
    required this.eCNO,
    required this.rSCP,
    required this.cQI,
    required this.cQITABLEINDEX,
    required this.cSIRSRP,
    required this.sSSRP,
    required this.cIRSRQ,
    required this.sSRSRQ,
    required this.cSISINR,
    required this.sSSINR,
    required this.dataSignalStrength,
    required this.downlinkSpeed,
    required this.uplinkSpeed,
  });

  DataField copyWith({
    int? id,
    String? year,
    String? month,
    String? day,
    String? hour,
    String? minutes,
    String? seconds,
    String? manufacturer,
    String? brand,
    String? device,
    String? model,
    String? latitude,
    String? longitude,
    String? altitude,
    String? userSpeed,
    String? networktype,
    String? registrationn,
    String? connectionStatus,
    String? operator,
    String? nci,
    String? cid,
    String? basestationId,
    String? networkId,
    String? systemId,
    String? mcc,
    String? mnc,
    String? ci,
    String? pci,
    String? tac,
    String? lac,
    String? bandwidth,
    String? arfcn,
    String? earfcn,
    String? uarfcn,
    String? level,
    String? evdolevel,
    String? dBm,
    String? cDMADBm,
    String? eVDODBm,
    String? aSU,
    String? rSSNR,
    String? rSRP,
    String? rSRQ,
    String? rSSI,
    String? bITERRORRATE,
    String? sNR,
    String? eVDOSNR,
    String? eCNO,
    String? rSCP,
    String? cQI,
    String? cQITABLEINDEX,
    String? cSIRSRP,
    String? sSSRP,
    String? cIRSRQ,
    String? sSRSRQ,
    String? cSISINR,
    String? sSSINR,
    String? dataSignalStrength,
    String? downlinkSpeed,
    String? uplinkSpeed,
  }) {
    return DataField(
      id: id ?? this.id,
      year: year ?? this.year,
      month: month ?? this.month,
      day: day ?? this.day,
      hour: hour ?? this.hour,
      minutes: minutes ?? this.minutes,
      seconds: seconds ?? this.seconds,
      manufacturer: manufacturer ?? this.manufacturer,
      brand: brand ?? this.brand,
      device: device ?? this.device,
      model: model ?? this.model,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      altitude: altitude ?? this.altitude,
      userSpeed: userSpeed ?? this.userSpeed,
      networktype: networktype ?? this.networktype,
      registrationn: registrationn ?? this.registrationn,
      connectionStatus: connectionStatus ?? this.connectionStatus,
      operator: operator ?? this.operator,
      nci: nci ?? this.nci,
      cid: cid ?? this.cid,
      basestationId: basestationId ?? this.basestationId,
      networkId: networkId ?? this.networkId,
      systemId: systemId ?? this.systemId,
      mcc: mcc ?? this.mcc,
      mnc: mnc ?? this.mnc,
      ci: ci ?? this.ci,
      pci: pci ?? this.pci,
      tac: tac ?? this.tac,
      lac: lac ?? this.lac,
      bandwidth: bandwidth ?? this.bandwidth,
      arfcn: arfcn ?? this.arfcn,
      earfcn: earfcn ?? this.earfcn,
      uarfcn: uarfcn ?? this.uarfcn,
      level: level ?? this.level,
      evdolevel: evdolevel ?? this.evdolevel,
      dBm: dBm ?? this.dBm,
      cDMADBm: cDMADBm ?? this.cDMADBm,
      eVDODBm: eVDODBm ?? this.eVDODBm,
      aSU: aSU ?? this.aSU,
      rSSNR: rSSNR ?? this.rSSNR,
      rSRP: rSRP ?? this.rSRP,
      rSRQ: rSRQ ?? this.rSRQ,
      rSSI: rSSI ?? this.rSSI,
      bITERRORRATE: bITERRORRATE ?? this.bITERRORRATE,
      sNR: sNR ?? this.sNR,
      eVDOSNR: eVDOSNR ?? this.eVDOSNR,
      eCNO: eCNO ?? this.eCNO,
      rSCP: rSCP ?? this.rSCP,
      cQI: cQI ?? this.cQI,
      cQITABLEINDEX: cQITABLEINDEX ?? this.cQITABLEINDEX,
      cSIRSRP: cSIRSRP ?? this.cSIRSRP,
      sSSRP: sSSRP ?? this.sSSRP,
      cIRSRQ: cIRSRQ ?? this.cIRSRQ,
      sSRSRQ: sSRSRQ ?? this.sSRSRQ,
      cSISINR: cSISINR ?? this.cSISINR,
      sSSINR: sSSINR ?? this.sSSINR,
      dataSignalStrength: dataSignalStrength ?? this.dataSignalStrength,
      downlinkSpeed: downlinkSpeed ?? this.downlinkSpeed,
      uplinkSpeed: uplinkSpeed ?? this.uplinkSpeed,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'year': year,
      'month': month,
      'day': day,
      'hour': hour,
      'minutes': minutes,
      'seconds': seconds,
      'manufacturer': manufacturer,
      'brand': brand,
      'device': device,
      'model': model,
      'latitude': latitude,
      'longitude': longitude,
      'altitude': altitude,
      'userSpeed': userSpeed,
      'networktype': networktype,
      'registrationn': registrationn,
      'connectionStatus': connectionStatus,
      'operator': operator,
      'nci': nci,
      'cid': cid,
      'basestationId': basestationId,
      'networkId': networkId,
      'systemId': systemId,
      'mcc': mcc,
      'mnc': mnc,
      'ci': ci,
      'pci': pci,
      'tac': tac,
      'lac': lac,
      'bandwidth': bandwidth,
      'arfcn': arfcn,
      'earfcn': earfcn,
      'uarfcn': uarfcn,
      'level': level,
      'evdolevel': evdolevel,
      'dBm': dBm,
      'cDMADBm': cDMADBm,
      'eVDODBm': eVDODBm,
      'aSU': aSU,
      'rSSNR': rSSNR,
      'rSRP': rSRP,
      'rSRQ': rSRQ,
      'rSSI': rSSI,
      'bITERRORRATE': bITERRORRATE,
      'sNR': sNR,
      'eVDOSNR': eVDOSNR,
      'eCNO': eCNO,
      'rSCP': rSCP,
      'cQI': cQI,
      'cQITABLEINDEX': cQITABLEINDEX,
      'cSIRSRP': cSIRSRP,
      'sSSRP': sSSRP,
      'cIRSRQ': cIRSRQ,
      'sSRSRQ': sSRSRQ,
      'cSISINR': cSISINR,
      'sSSINR': sSSINR,
      'dataSignalStrength': dataSignalStrength,
      'downlinkSpeed': downlinkSpeed,
      'uplinkSpeed': uplinkSpeed,
    };
  }

  factory DataField.fromMap(Map<String, dynamic> map) {
    return DataField(
      id: map['id'] as int,
      year: map['year'] as String,
      month: map['month'] as String,
      day: map['day'] as String,
      hour: map['hour'] as String,
      minutes: map['minutes'] as String,
      seconds: map['seconds'] as String,
      manufacturer: map['manufacturer'] as String,
      brand: map['brand'] as String,
      device: map['device'] as String,
      model: map['model'] as String,
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
      altitude: map['altitude'] as String,
      userSpeed: map['userSpeed'] as String,
      networktype: map['networktype'] as String,
      registrationn: map['registrationn'] as String,
      connectionStatus: map['connectionStatus'] as String,
      operator: map['operator'] as String,
      nci: map['nci'] as String,
      cid: map['cid'] as String,
      basestationId: map['basestationId'] as String,
      networkId: map['networkId'] as String,
      systemId: map['systemId'] as String,
      mcc: map['mcc'] as String,
      mnc: map['mnc'] as String,
      ci: map['ci'] as String,
      pci: map['pci'] as String,
      tac: map['tac'] as String,
      lac: map['lac'] as String,
      bandwidth: map['bandwidth'] as String,
      arfcn: map['arfcn'] as String,
      earfcn: map['earfcn'] as String,
      uarfcn: map['uarfcn'] as String,
      level: map['level'] as String,
      evdolevel: map['evdolevel'] as String,
      dBm: map['dBm'] as String,
      cDMADBm: map['cDMADBm'] as String,
      eVDODBm: map['eVDODBm'] as String,
      aSU: map['aSU'] as String,
      rSSNR: map['rSSNR'] as String,
      rSRP: map['rSRP'] as String,
      rSRQ: map['rSRQ'] as String,
      rSSI: map['rSSI'] as String,
      bITERRORRATE: map['bITERRORRATE'] as String,
      sNR: map['sNR'] as String,
      eVDOSNR: map['eVDOSNR'] as String,
      eCNO: map['eCNO'] as String,
      rSCP: map['rSCP'] as String,
      cQI: map['cQI'] as String,
      cQITABLEINDEX: map['cQITABLEINDEX'] as String,
      cSIRSRP: map['cSIRSRP'] as String,
      sSSRP: map['sSSRP'] as String,
      cIRSRQ: map['cIRSRQ'] as String,
      sSRSRQ: map['sSRSRQ'] as String,
      cSISINR: map['cSISINR'] as String,
      sSSINR: map['sSSINR'] as String,
      dataSignalStrength: map['dataSignalStrength'] as String,
      downlinkSpeed: map['downlinkSpeed'] as String,
      uplinkSpeed: map['uplinkSpeed'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DataField.fromJson(String source) =>
      DataField.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DataField(id: $id, year: $year, month: $month, day: $day, hour: $hour, minutes: $minutes, seconds: $seconds, manufacturer: $manufacturer, brand: $brand, device: $device, model: $model, latitude: $latitude, longitude: $longitude, altitude: $altitude, userSpeed: $userSpeed, networktype: $networktype, registrationn: $registrationn, connectionStatus: $connectionStatus, operator: $operator, nci: $nci, cid: $cid, basestationId: $basestationId, networkId: $networkId, systemId: $systemId, mcc: $mcc, mnc: $mnc, ci: $ci, pci: $pci, tac: $tac, lac: $lac, bandwidth: $bandwidth, arfcn: $arfcn, earfcn: $earfcn, uarfcn: $uarfcn, level: $level, evdolevel: $evdolevel, dBm: $dBm, cDMADBm: $cDMADBm, eVDODBm: $eVDODBm, aSU: $aSU, rSSNR: $rSSNR, rSRP: $rSRP, rSRQ: $rSRQ, rSSI: $rSSI, bITERRORRATE: $bITERRORRATE, sNR: $sNR, eVDOSNR: $eVDOSNR, eCNO: $eCNO, rSCP: $rSCP, cQI: $cQI, cQITABLEINDEX: $cQITABLEINDEX, cSIRSRP: $cSIRSRP, sSSRP: $sSSRP, cIRSRQ: $cIRSRQ, sSRSRQ: $sSRSRQ, cSISINR: $cSISINR, sSSINR: $sSSINR, dataSignalStrength: $dataSignalStrength, downlinkSpeed: $downlinkSpeed, uplinkSpeed: $uplinkSpeed)';
  }

  @override
  bool operator ==(covariant DataField other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.year == year &&
        other.month == month &&
        other.day == day &&
        other.hour == hour &&
        other.minutes == minutes &&
        other.seconds == seconds &&
        other.manufacturer == manufacturer &&
        other.brand == brand &&
        other.device == device &&
        other.model == model &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.altitude == altitude &&
        other.userSpeed == userSpeed &&
        other.networktype == networktype &&
        other.registrationn == registrationn &&
        other.connectionStatus == connectionStatus &&
        other.operator == operator &&
        other.nci == nci &&
        other.cid == cid &&
        other.basestationId == basestationId &&
        other.networkId == networkId &&
        other.systemId == systemId &&
        other.mcc == mcc &&
        other.mnc == mnc &&
        other.ci == ci &&
        other.pci == pci &&
        other.tac == tac &&
        other.lac == lac &&
        other.bandwidth == bandwidth &&
        other.arfcn == arfcn &&
        other.earfcn == earfcn &&
        other.uarfcn == uarfcn &&
        other.level == level &&
        other.evdolevel == evdolevel &&
        other.dBm == dBm &&
        other.cDMADBm == cDMADBm &&
        other.eVDODBm == eVDODBm &&
        other.aSU == aSU &&
        other.rSSNR == rSSNR &&
        other.rSRP == rSRP &&
        other.rSRQ == rSRQ &&
        other.rSSI == rSSI &&
        other.bITERRORRATE == bITERRORRATE &&
        other.sNR == sNR &&
        other.eVDOSNR == eVDOSNR &&
        other.eCNO == eCNO &&
        other.rSCP == rSCP &&
        other.cQI == cQI &&
        other.cQITABLEINDEX == cQITABLEINDEX &&
        other.cSIRSRP == cSIRSRP &&
        other.sSSRP == sSSRP &&
        other.cIRSRQ == cIRSRQ &&
        other.sSRSRQ == sSRSRQ &&
        other.cSISINR == cSISINR &&
        other.sSSINR == sSSINR &&
        other.dataSignalStrength == dataSignalStrength &&
        other.downlinkSpeed == downlinkSpeed &&
        other.uplinkSpeed == uplinkSpeed;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        year.hashCode ^
        month.hashCode ^
        day.hashCode ^
        hour.hashCode ^
        minutes.hashCode ^
        seconds.hashCode ^
        manufacturer.hashCode ^
        brand.hashCode ^
        device.hashCode ^
        model.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        altitude.hashCode ^
        userSpeed.hashCode ^
        networktype.hashCode ^
        registrationn.hashCode ^
        connectionStatus.hashCode ^
        operator.hashCode ^
        nci.hashCode ^
        cid.hashCode ^
        basestationId.hashCode ^
        networkId.hashCode ^
        systemId.hashCode ^
        mcc.hashCode ^
        mnc.hashCode ^
        ci.hashCode ^
        pci.hashCode ^
        tac.hashCode ^
        lac.hashCode ^
        bandwidth.hashCode ^
        arfcn.hashCode ^
        earfcn.hashCode ^
        uarfcn.hashCode ^
        level.hashCode ^
        evdolevel.hashCode ^
        dBm.hashCode ^
        cDMADBm.hashCode ^
        eVDODBm.hashCode ^
        aSU.hashCode ^
        rSSNR.hashCode ^
        rSRP.hashCode ^
        rSRQ.hashCode ^
        rSSI.hashCode ^
        bITERRORRATE.hashCode ^
        sNR.hashCode ^
        eVDOSNR.hashCode ^
        eCNO.hashCode ^
        rSCP.hashCode ^
        cQI.hashCode ^
        cQITABLEINDEX.hashCode ^
        cSIRSRP.hashCode ^
        sSSRP.hashCode ^
        cIRSRQ.hashCode ^
        sSRSRQ.hashCode ^
        cSISINR.hashCode ^
        sSSINR.hashCode ^
        dataSignalStrength.hashCode ^
        downlinkSpeed.hashCode ^
        uplinkSpeed.hashCode;
  }
}
