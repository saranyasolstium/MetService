import 'package:http/http.dart' as http;
import 'dart:convert';

class NotificationSender {
  Future<void> sendNotification(String fcmToken, String title, String body) async {
    // Construct the request body
   

    // Construct the HTTP request headers
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'AIzaSyCcoosOP2EhlqRp0RZWy1hpH2sTgzCwY1Q', 
    };

    // Construct the HTTP request
    var response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: headers,
      body: json.encode({
        'to': fcmToken,
        'notification': {'title': title, 'body': body},
        'priority': 'high',
        'data': {'click_action': 'FLUTTER_NOTIFICATION_CLICK'}
      }),
    );

    // Check if the request was successful
    if (response.statusCode == 200) {
      print('Notification sent successfully.');
    } else {
      print('Failed to send notification: ${response.reasonPhrase}');
    }
  }
}
