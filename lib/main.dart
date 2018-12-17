import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;


void main() {
//=>

  //var url = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22nome%2C%20ak%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys";
  //http.post(url, body: {"name": "doodle", "color": "blue"})
    //  .then((response) {
  //  print("Response status: ${response.statusCode}");
  //  print("Response body: ${response.body}");
 // });

 // var dd=http.read(url).then(print);

  runApp(MaterialApp(

    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ))
  ;
}




class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{
  TextEditingController controller = TextEditingController();
  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();
  var urlString = "http://alarkan-group.com";

  launchUrl({String url="http://alarkan-group.com"}) {
    setState(() {
      urlString = url;
      flutterWebviewPlugin.reloadUrl(urlString);
    });
  }
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  @override
  void initState() {
    super.initState();

    flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged wvs) {
      print(wvs.type);
    });


      flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
      var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
      var iOS = new IOSInitializationSettings();
      var initSetttings = new InitializationSettings(android, iOS);
      flutterLocalNotificationsPlugin.initialize(initSetttings,
          onSelectNotification: onSelectNotificationX);
    }

    Future onSelectNotificationX(String payload) {
      debugPrint("payload : $payload");
      showDialog(
        context: context,
        builder: (_) => new AlertDialog(
          title: new Text('Notification'),
          content: new Text('$payload'),
        ),
      );
    }



    @override
    void didChangeAppLifecycleState(AppLifecycleState state) {
      super.didChangeAppLifecycleState(state);
      switch(state){
        case AppLifecycleState.paused:
          print('ageeb paused state');
          break;
        case AppLifecycleState.resumed:
          print('ageeb resumed state');
          break;
        case AppLifecycleState.inactive:
          print('ageeb inactive state');
          break;
        case AppLifecycleState.suspending:
          print('ageeb suspending state');
          break;
      }
    }




  @override
  Widget build(BuildContext context) {
    return



      WebviewScaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.home,color: Colors.orange,), onPressed: () => launchUrl()),

        backgroundColor: Colors.indigo,
centerTitle: true,
        title:  new Text("إدارة الأملاك - عجيب سوفت "),
         actions: <Widget>[
IconButton(icon: Icon(Icons.check_circle,color: Colors.green,),onPressed: () => launchUrl(url:"http://alarkan-group.com/Debits/Rec_Ok"),)
        ],
      ),
      url: urlString,
      withZoom: true,
      withJavascript: true,
      scrollBar: true,
    );
  }




showNotification({String title="سداد جديد",var body="متأجر أو مستأجرين سدد مبلغ مالي جديد"}) async {
  var android = new AndroidNotificationDetails(
      'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
      priority: Priority.High,importance: Importance.Max
  );
  var iOS = new IOSNotificationDetails();
  var platform = new NotificationDetails(android, iOS);
  await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platform,
     // payload: 'Nitish Kumar Singh is part time Youtuber'
      );
}
}


