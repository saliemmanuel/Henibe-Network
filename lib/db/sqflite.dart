import 'package:bheya_network_example/db/models/data_field.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Database? db;
Future<void> initDatabase({String? dbName}) async {
  var path = await getDatabasePath('$dbName.db');
  db = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
    var data = """
        CREATE TABLE data(
        id INTEGER PRIMARY KEY ,
        year VARCHAR(250)  ,
        month VARCHAR(250)  ,
        day VARCHAR(250)  ,
        hour VARCHAR(250)  ,
        minutes VARCHAR(50)  ,
        seconds VARCHAR(50)  ,
        manufacturer VARCHAR(50)  ,
        operator VARCHAR(50)  ,
        brand VARCHAR(50)  ,
        device VARCHAR(50)  ,
        model VARCHAR(50)  ,
        latitude VARCHAR(50)  ,
        longitude VARCHAR(50)  ,
        altitude VARCHAR(50)  ,
        userSpeed VARCHAR(50)  ,
        networktype VARCHAR(50)  ,
        registrationn VARCHAR(50)  ,
        connectionStatus VARCHAR(50)  ,
        nci VARCHAR(50)  ,
        cid VARCHAR(50)  ,
        basestationId VARCHAR(50)  ,
        networkId VARCHAR(50)  ,
        systemId VARCHAR(50)  ,
        mcc VARCHAR(50)  ,
        mnc VARCHAR(50)  ,
        ci VARCHAR(50)  ,
        pci VARCHAR(50)  ,
        tac VARCHAR(50)  ,
        lac VARCHAR(50)  ,
        bandwidth VARCHAR(50)  ,
        arfcn VARCHAR(50)  ,
        earfcn VARCHAR(50)  ,
        uarfcn VARCHAR(50)  ,
        level VARCHAR(50)  ,
        evdolevel VARCHAR(50)  ,
        dBm VARCHAR(50)  ,
        cDMADBm VARCHAR(50)  ,
        eVDODBm VARCHAR(50)  ,
        eVDOSNR VARCHAR(50)  ,
        aSU VARCHAR(50)  ,
        rSSNR VARCHAR(50)  ,
        rSRP VARCHAR(50)  ,
        rSRQ VARCHAR(50)  ,
        rSSI VARCHAR(50)  ,
        bITERRORRATE VARCHAR(50)  ,
        sNR VARCHAR(50)  ,
        eCNO VARCHAR(50)  ,
        rSCP VARCHAR(50)  ,
        cQI VARCHAR(50)  ,
        cQITABLEINDEX VARCHAR(50)  ,
        cSIRSRP VARCHAR(50)  ,
        sSSRP VARCHAR(50)  ,
        cIRSRQ VARCHAR(50)  ,
        sSRSRQ VARCHAR(50)  ,
        cSISINR VARCHAR(50)  ,
        sSSINR VARCHAR(50)  ,
        dataSignalStrength VARCHAR(50)  ,
        downlinkSpeed VARCHAR(50)  ,
        uplinkSpeed VARCHAR(50))
        """;
    await db.execute(data);
  });
}

Future<String> getDatabasePath(String dbName) async {
  var dataPath = await getDatabasesPath();
  var path = join(dataPath, dbName);
  return path;
}

Future<int?> insertDataField({DataField? dataField}) async {
  int res = await db!.insert(
    "data",
    dataField!.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  return res;
}

update(DataField? dataField) async {
  var result = await db!.update("data", dataField!.toMap(),
      where: "id = ?", whereArgs: [dataField.id]);
  return result;
}

deleteUserAccount(String? id) async {
  var result = await db!.delete("data", where: "id = $id");
  return result;
}

// Suppression complet*
Future<int> deleteAccount() async {
  print("deconnexio");
  return await db!.delete("data");
}

// Comptage
Future<int?> getCount() async {
  return Sqflite.firstIntValue(await db!.rawQuery("SELECT COUNT(*) FROM data"));
}

Future<List?>? getData() async {
  var result = await db!.rawQuery("SELECT * FROM data");
  return result.toList();
}

Future<List<Map>> findAll({String? tableName}) async {
  return await db!.query(tableName!);
}

Stream<List<DataField>> streamGetData() {
  return Stream.fromFuture(db!.query("data"))
      .map(
        (List<Map<String, dynamic>> list) =>
            list.map((m) => DataField.fromMap(m)).toList(),
      )
      .take(1);
}
