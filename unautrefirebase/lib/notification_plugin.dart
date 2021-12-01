import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show File , Platform ;
class NotificationPlugin{

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

 late var initializationSettings;

  final BehaviorSubject<ReceivedNotification> didReceivedLocalNotificationSubject = BehaviorSubject<ReceivedNotification>();
  NotificationPlugin._(){
    init();
  }

  init()async{
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if(Platform.isIOS){
      _requestIOSPermission();

    }
    initializePlatformSpecifics();

  }

  initializePlatformSpecifics(){
    var inittializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: false,
        onDidReceiveLocalNotification:(id ,title , body , payload)async{
            ReceivedNotification receivedNotification = ReceivedNotification(id: id, title: title, body: body, payload: payload);
            didReceivedLocalNotificationSubject.add(receivedNotification);
        }

    );

    initializationSettings =InitializationSettings( inittializationSettingsAndroid, initializationSettingsIOS);

  }



  _requestIOSPermission(){
    flutterLocalNotificationsPlugin.
    resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        .requestPermissions(
      alert: false,
      badge: false,
      sound: true,
    );
  }

  setListenerForLowerVersions(Function onNotificationInLowerVersions) {
    didReceivedLocalNotificationSubject.listen((receivedNotification) {
      onNotificationInLowerVersions(receivedNotification);
    });
  }


  setOnNotificationClick(Function onNotificationClick) async {
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
          onNotificationClick(payload);
        });
  }
  Future<void> showNotification() async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      "CHANNEL_DESCRIPTION",
      importance: Importance.Max,
      priority: Priority.High,
      playSound: true,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics =
    NotificationDetails(androidChannelSpecifics, iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Test Title',
      'Test Body', //null
      platformChannelSpecifics,
      payload: 'New Payload',
    );
  }

  Future<void> showDailyAtTime() async {
    var time =Time(18,03,0);
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      "CHANNEL_DESCRIPTION",
      importance: Importance.Max,
      priority: Priority.High,
      playSound: true,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics =
    NotificationDetails(androidChannelSpecifics, iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
      0,
      'Test Title Euutt',
      'Test Body', //null
      time,
      platformChannelSpecifics,
      payload: 'New Payload',
    );
  }

  Future<void> scheduleNotification() async {
    var scheduleNotificationDateTime = DateTime.now().add(Duration(seconds: 5));
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID 1',
      'CHANNEL_NAME 1',
      "CHANNEL_DESCRIPTION 1",
      icon: '@mipmap/ic_launcher',
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      enableLights: true,
      color: const Color.fromARGB(255, 255, 0, 0),
      ledColor: const Color.fromARGB(255, 255, 0, 0),
      ledOnMs: 1000,
      ledOffMs: 500,
      importance: Importance.Max,
      priority: Priority.High,
      playSound: true,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );
    var iosChannelSpecifics = IOSNotificationDetails(
      sound: 'my_sound.aiff'
    );
    var platformChannelSpecifics =
    NotificationDetails(androidChannelSpecifics, iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.schedule(
      0,
      'Test Title',
      'Test Body',
      scheduleNotificationDateTime,//null
      platformChannelSpecifics,
      payload: 'New Payload',
    );
  }

  Future<void> repeatNotification() async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      "CHANNEL_DESCRIPTION",
      importance: Importance.Max,
      priority: Priority.High,
      playSound: true,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics =
    NotificationDetails(androidChannelSpecifics, iosChannelSpecifics);
    await flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      'Test Title',
      'Test Body', //null
      RepeatInterval.EveryMinute,
      platformChannelSpecifics,
      payload: 'New Payload',
    );
  }

   Future<void>showNotificationWithAttachment()async{
     var attachmentPicture = await _downloadAndSaveFile("https://via.placeholder.com/800x200", 'attachement_img.jpg');
     var iOSPlateformSpecifics = IOSNotificationDetails(
       attachments: [IOSNotificationAttachment(attachmentPicture)],

     );


     var bigPictureStyleInformation = BigPictureStyleInformation(
       FilePathAndroidBitmap(attachmentPicture),
       contentTitle: '<b>Attached Image</b>',
       htmlFormatContentTitle: true,
       summaryText: 'Test Image',
       htmlFormatSummaryText: true,

     );

     var androidChannelSpecifics = AndroidNotificationDetails("channelId", "channelName", "channelDescription",
     importance: Importance.High,
       priority: Priority.High,
       styleInformation: bigPictureStyleInformation
     );

     var notificationDetails = NotificationDetails(androidChannelSpecifics, iOSPlateformSpecifics);
      await flutterLocalNotificationsPlugin.show(0, "sadf", "Llevraiff", notificationDetails);

  }

  _downloadAndSaveFile(String url , String fileName) async{
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/$fileName';
    var reponse = await http.get(url);
    var file =  File(filePath);
    await file.writeAsBytes(reponse.bodyBytes);
    return filePath;
  }

}

NotificationPlugin notificationPlugin = NotificationPlugin._();

class ReceivedNotification{
  final int id;
  final String title;
  final String body;
  final String payload;

  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
});
}