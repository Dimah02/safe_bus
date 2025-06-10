import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:safe_bus/core/utils/http_client.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotifications({required String id}) async {
    await _firebaseMessaging.requestPermission();

    final fCMToken = await _firebaseMessaging.getToken();
    await KHTTP.instance.put(
      endpoint: "users/$id/fcm-token",
      body: {"FcmToken": fCMToken},
    );

    print(fCMToken);

    FirebaseMessaging.onBackgroundMessage(handelNotification);
    FirebaseMessaging.onMessage.listen(handelNotification);
  }
}

Future<void> handelNotification(RemoteMessage mdg) async {}
