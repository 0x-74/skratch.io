
import 'package:flutter/material.dart';
import 'package:skratch/models/my_custom_painter.dart';
import 'package:skratch/models/touch_points.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_dotenv/flutter_dotenv.dart';
class PaintScreen extends StatefulWidget {
  final Map data;
  final String screenFrom;
  const PaintScreen({super.key, required this.screenFrom, required this.data});
  
  @override
  State<PaintScreen> createState() => _PaintScreenState();
}

class _PaintScreenState extends State<PaintScreen> {
  
  late IO.Socket _socket;
  
  Map roomDetails = {};
  List<TouchPoints> points = [];
  StrokeCap strokeType = StrokeCap.round;
  Color selectedcolor = Colors.black;
  double opacity = 1;
  @override
  void initState() {
    super.initState();
    connect();
  }

//socket io
  void connect() {
    _socket = IO.io(
        dotenv.env['ip'],
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
        });
        if(roomData['isJoin']!=true){
          
        }
      });
      _socket.on('points',(point){
            print(point);
        if(point['details']!=null){
          setState(() {
            points.add(TouchPoints(points: Offset(point['details']['dx'].toDouble(), point['details']['dy'].toDouble()),
             paint: Paint()
             ..strokeCap= strokeType 
             ..isAntiAlias = true 
             ..color = selectedcolor.withOpacity(opacity) 
             ..strokeWidth = 2)
            );
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.blue,
      body:  Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: width,
                height: height,
                child: GestureDetector(
                  onPanUpdate: (details) {
                    //print(details);
                    _socket.emit('paint',{
                      'details':{
                        'dx':details.localPosition.dx,
                        'dy':details.localPosition.dy,
                      },
                      'roomName':widget.data['roomname'],
                    });

                  },
                  onPanStart: (details) {
                    //print(details);
                    _socket.emit('paint',{
                      'details':{
                        'dx':details.localPosition.dx,
                        'dy':details.localPosition.dy,
                      },
                      'roomName':widget.data['roomname'],
                    });
                  },
                  onPanEnd: (details) {
                    //print(details);
                        _socket.emit('paint',{
                      'details':null,
                      'roomName':widget.data['roomname'],
                    });
                  },
                  child: SizedBox.expand(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: RepaintBoundary(
                        child: CustomPaint(size: Size.infinite,painter: MyCustomPainter(pointslist:points),),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
