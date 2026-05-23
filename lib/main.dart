 import 'package:flutter/material.dart';
 import 'package:flutter_webrtc/flutter_webrtc.dart';
 import 'package:permission_handler/permission_handler.dart';

 void main() => runApp(MaterialApp(home: ChildApp()));

 class ChildApp extends StatefulWidget {
   @override
   _ChildAppState createState() => _ChildAppState();
 }

 class _ChildAppState extends State<ChildApp> {
   String _status = "Ready";
   String _peerId = "Waiting for ID...";
   MediaStream? _screenStream;

   @override
   void initState() {
     super.initState();
     _initId();
   }

   void _initId() {
     // Is prototype mein hum ek simple ID rakh rahe hain
     // Aap ise badal bhi sakte hain
     setState(() { _peerId = "child-mobile-786"; });
   }

   Future<void> _startSharing() async {
     try {
       // 1. Request Permissions
       await [Permission.microphone, Permission.camera, Permission.storage].request();

       // 2. Start Screen Capture
       final Map<String, dynamic> constraints = {'audio': false, 'video': true};
       _screenStream = await navigator.mediaDevices.getDisplayMedia(constraints);

       setState(() { _status = "Screen Sharing Active!"; });

       // Note: Asli streaming ke liye background service chahiye hoti hai
       // Lekin testing ke liye app ko open rakhna hoga.
     } catch (e) {
       setState(() { _status = "Error: $e"; });
       print(e);
     }
   }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(title: Text("Parental Monitor (Child)")),
       body: Container(
         padding: EdgeInsets.all(20),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Icon(Icons.security, size: 80, color: Colors.green),
             SizedBox(height: 20),
             Text("Child ID: $_peerId", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color:
      Colors.blue)),
             SizedBox(height: 10),
             Text("Status: $_status", style: TextStyle(fontSize: 16)),
             SizedBox(height: 40),
             ElevatedButton(
               onPressed: _startSharing,
               child: Text("Start Live Stream", style: TextStyle(fontSize: 18)),
               style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
             ),
             SizedBox(height: 20),
             Text("Tip: Office se dekhne ke liye yahi ID parent web par likhein.", textAlign: TextAlign.center,
      style: TextStyle(color: Colors.grey)),
           ],
         ),
       ),
     );
   }
 }
