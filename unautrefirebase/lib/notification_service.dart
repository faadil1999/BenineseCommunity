import 'package:flutter/material.dart';
import 'package:unautrefirebase/notification_plugin.dart';

class NotificationService extends StatefulWidget {
  const NotificationService({Key ? key}) : super(key: key);

  @override
  _NotificationServiceState createState() => _NotificationServiceState();
}

class _NotificationServiceState extends State<NotificationService> {

  @override
  void initState(){
    super.initState();
    notificationPlugin.setListenerForLowerVersions(onNotificationInLowerVersions);
    notificationPlugin.setOnNotificationClick(onNotificationClick);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('local notification'),
      ),
      body: Center(
        child: FlatButton(onPressed: ()async{
             // await notificationPlugin.scheduleNotification();
              onNotificationClick("Test playlooooad");
              //await notificationPlugin.showNotificationWithAttachment();
              //await notificationPlugin.repeatNotification();
              await notificationPlugin.showDailyAtTime();
        }, child:Text("send Notification"),),
      ),
    );
  }

  onNotificationInLowerVersions(ReceivedNotification receivedNotification){

  }

  onNotificationClick(String payload){
    print("Playload $payload");
  }
}
