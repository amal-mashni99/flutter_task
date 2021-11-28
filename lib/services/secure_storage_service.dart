import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MySecureStorage {
  static FlutterSecureStorage storage=FlutterSecureStorage() ;
  MySecureStorage() {
    storage = FlutterSecureStorage();
  }

  static var data = {"uid": "", "email": ""};

  static Future writeSecureData(String uid, String email) async {
    storage = FlutterSecureStorage();
    var writeData = await storage.write(key: "uid", value: uid);
    writeData = await storage.write(key: "email", value: email);
    print(readSecureData("uid").toString());
    return writeData;
  }

  static Future readSecureData(String key) async {
    storage = FlutterSecureStorage();
    data[key] = (await storage.read(key: key))!;
    return data[key];
  }

  static Future deleteSecureData(String key) async {
    var deletedData = await storage.delete(key: key);
    return deletedData;
  }

  Future deleteAllSecureData() async {
    var deletedData = await storage.deleteAll();
    return deletedData;
  }
}
