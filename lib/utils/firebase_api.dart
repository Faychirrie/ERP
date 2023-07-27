import 'package:crm/controllers/online_crud_operations/crm_online_crud.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/offline_crud_operations/url_crud.dart';
import '../models/common/url_data_model.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotifications(String ipAddress) async {
    ipAddress= await getIpAddress();
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print('token $fcmToken');
    sharedPreferences.setString('fcmToken', fcmToken!);
    var vempCode = sharedPreferences.get("vempCode");
    if (ipAddress == "190.100.254") {
      sharedPreferences.remove("url");
      sharedPreferences.setString("url", "http://$ipAddress.200:7227/pdilApp");
    } else {
      URLCrud urlCRUD = URLCrud();
      Future<List<URLDataModel>> urlListFuture = urlCRUD.getUrlList();
      urlListFuture
          .then((value) {
        sharedPreferences.remove("url");
        sharedPreferences.setString("url", value[0].vurl);});
      }

    if (vempCode != null && ipAddress!="Invalid IP Address") {
      int? id = await getFireBaseToken(vempCode.toString());
      addFirebaseToken(id!);
    }
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<String> getIpAddress() async {
    NetworkInfo networkInfo = NetworkInfo();
    String? ipAddress = "Unknown";
    String? wifiName = "Unknown";
    try {
      wifiName = await networkInfo.getWifiName();
      ipAddress = await networkInfo.getWifiIP();

    } catch (e) {
      print("Error getting IP address: $e");
    }
    print("Ip address==============");
    print(getFirstThreePartsOfIpAddress(ipAddress??""));
    print(wifiName);
    return getFirstThreePartsOfIpAddress(ipAddress??"");
  }
  String getFirstThreePartsOfIpAddress(String ipAddress) {
    List<String> parts = ipAddress.split('.');

    if (parts.length >= 4) {
      // Concatenate the first three parts (octets) of the IP address
      return '${parts[0]}.${parts[1]}.${parts[2]}';
    } else {
      // Handle the case when the IP address is not in the correct format
      return 'Invalid IP Address';
    }
  }
}
