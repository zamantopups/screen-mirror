 import 'package:flutter/material.dart';
 import 'package:flutter_webrtc/flutter_webrtc.dart';
 import 'package:socket_io_client/socket_io_client.dart' as IO;
 import 'dart:convert';
 import 'dart:async';

 void main() => runApp(MaterialApp(home: ChildApp()));

 class ChildApp extends StatefulWidget {
   @override
   _ChildAppState createState() => _ChildAppState();
 }

 class _ChildAppState extends State<ChildApp> {
   IO.Socket? socket;
   String status = "Disconnected";

   @override
   void initState() {
     super.initState();
     // Apne server ka address yahan likhein (e.g. Netlify wala server ya LocalTunnel)
     socket = IO.io('http://192.168.1.3:3000', <String, dynamic>{
       'transports': ['websocket'],
       'autoConnect': true,
     });
     socket!.onConnect((_) => setState(() => status = "Connected to Office"));
   }

   Future<void> startStreaming() async {
     final stream = await navigator.mediaDevices.getDisplayMedia({'video': true});
     // Har 1 second baad frame bhejna
     Timer.periodic(Duration(seconds: 1), (timer) {
       socket!.emit('screen-data', "FRAME_DATA_HERE");
       setState(() => status = "Streaming Live...");
     });
   }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(title: Text("Child Monitor")),
       body: Center(child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Text("Status: $status", style: TextStyle(fontSize: 20)),
           ElevatedButton(onPressed: startStreaming, child: Text("Start Sending to Office"))
         ],
       )),
     );
   }
 }
