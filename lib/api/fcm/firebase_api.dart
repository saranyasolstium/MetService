import 'package:eagle_pixels/api/fcm/notification_sender.dart';
import 'package:eagle_pixels/reuse/shared_preference_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi{

  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async{
    await _firebaseMessaging.requestPermission();
    final fCMToken=await _firebaseMessaging.getToken();
    print('Token: $fCMToken');
    SharedPreferencesHelper.setFCMToken(fCMToken!);
    final notificationSender = NotificationSender();
  await notificationSender.sendNotification(
      fCMToken, 'Test Title', 'Test Body');
  }

}