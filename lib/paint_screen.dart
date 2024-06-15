import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class PaintScreen extends StatefulWidget {
  final Map data;
  final String screenFrom;
  const PaintScreen({super.key, required this.screenFrom, required this.data});

  @override
  State<PaintScreen> createState() => _PaintScreenState();
}

class _PaintScreenState extends State<PaintScreen> {
  late IO.Socket _socket;
  String roomDetails = "";
  @override
  void initState() {
    super.initState();
    connect();
  }

//socket io
  void connect() {
    _socket = IO.io(
        'http://192.168.29.33:3000',
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect()
            .build());
    _socket.connect();

    if (widget.screenFrom == 'createRoom') {
      _socket.emit('create-game', widget.data);
    }
    else{
      _socket.emit('join-game',widget.data);
    }
    _socket.onConnect((data) {
      print("connected");
      _socket.on('updateRoom', (roomData) {
        setState(() {
          roomDetails = roomData;
          print(roomDetails);
        });
        if(roomData['isJoin']!=true){
          
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
