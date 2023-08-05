class DataSimInfo {
  List<SimInfoList>? simInfoList;

  DataSimInfo({simInfoList});

  DataSimInfo.fromJson(Map<String, dynamic> json) {
    if (json['simInfoList'] != null) {
      simInfoList = <SimInfoList>[];
      json['simInfoList'].forEach((v) {
        simInfoList!.add(SimInfoList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (simInfoList != null) {
      data['simInfoList'] = simInfoList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SimInfoList {
  String? carrierName;
  String? displayName;
  int? mcc;
  int? mnc;
  String? subscriptionInfoNumber;

  SimInfoList(
      {carrierName,
      displayName,
      mcc,
      mnc,
      subscriptionInfoNumber});

  SimInfoList.fromJson(Map<String, dynamic> json) {
    carrierName = json['carrierName'];
    displayName = json['displayName'];
    mcc = json['mcc'];
    mnc = json['mnc'];
    subscriptionInfoNumber = json['subscriptionInfoNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['carrierName'] = carrierName;
    data['displayName'] = displayName;
    data['mcc'] = mcc;
    data['mnc'] = mnc;
    data['subscriptionInfoNumber'] = subscriptionInfoNumber;
    return data;
  }
}