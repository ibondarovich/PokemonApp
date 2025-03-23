import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/googleapis_auth.dart' as auth;
import 'package:googleapis/servicecontrol/v1.dart' as servicecontrol;
import 'package:googleapis_auth/auth_io.dart';

const String projectId =
    'pokemonapp-52074'; // Replace with your Firebase project ID
const String serviceAccountFileName =
    'service_account.json'; // Path to your service account key file

///This file demonstrates the logic of sending push notifications (this should be implemented on the backend)
void main() async {

  // Replace with the actual FCM token
  const userFCMToken =
      "fHT9UzsqTM-dGHte2zwuse:APA91bHpsCOKbi-5Cx-QjwaySfRAGH7Vibt12DZ5YMzI-1DWwMJ1O31zinqjTj0d5SVSSbhi2oKPrg7N4YCj8WstXQd5L-6Jm3tiLAGlUcWLUiTwI3mJsKU";

  await sendPushNotification(userFCMToken);
}

Future<String> getAccessToken() async {
  // Load service account credentials from JSON file
  Directory current = Directory.current;
  String path =
      '${current.path}/lib/service/push_server/$serviceAccountFileName';
  final serviceAccount = File(path).readAsStringSync();
  final Map<String, dynamic> credentials = json.decode(serviceAccount);

  final client = await clientViaServiceAccount(
    auth.ServiceAccountCredentials.fromJson(credentials),
    [
      'https://www.googleapis.com/auth/firebase.messaging'
    ], // Required scope for FCM
  );

  return client.credentials.accessToken.data;
}

Future<void> sendPushNotification(String token) async {
  final String accessToken = await getAccessToken();

  final Uri url = Uri.parse(
    'https://fcm.googleapis.com/v1/projects/$projectId/messages:send',
  );

  final Map<String, dynamic> payload = {
    "message": {
      "token": token,
      "notification": {
        "title": "New Message!",
        "body": "You have a new notification.",
      },
    },
  };

  final response = await http.post(
    url,
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    },
    body: jsonEncode(payload),
  );

  if (response.statusCode == 200) {
    print("Notification sent successfully: ${response.body}");
  } else {
    print("Error sending notification: ${response.body}");
  }
}
