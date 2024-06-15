import 'package:flutter/material.dart';
import 'package:skratch/paint_screen.dart';
import 'package:skratch/widgets/custom_text_field.dart';

class CreateRoomScreen extends StatefulWidget {
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roomNameController = TextEditingController();
  late String? _maxRoundsValue;
  late String? _maxPlayersValue;

  void CreateRoom(){
    if(_nameController.text.isNotEmpty && _roomNameController.text.isNotEmpty && _maxRoundsValue!=null && _maxPlayersValue!=null ){
      Map data = {
        "nickname":_nameController.text,
        "roomname":_roomNameController.text,
        "roomsize":_maxPlayersValue,
        "maxrounds":_maxRoundsValue
      };
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PaintScreen(data:data,screenFrom:'createRoom')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text('Create Room'),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.08,
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: CustomTextField(
          controller: _nameController,
          hintText: 'enter name',
        ),
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: CustomTextField(
          controller: _roomNameController,
          hintText: 'enter room name',
        ),
      ),
      DropdownButton(
        hint: const Text('Max players'),
        items: <String>["2", "4"]
            .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem(
                  value: value,
                  child: Text(value),
                ))
            .toList(),
        onChanged: (String? value) {
          setState(() {
            _maxPlayersValue = value;
          });
        },
      ), DropdownButton(
        hint: const Text('Max Rounds'),
        items: <String>["2", "4"]
            .map<DropdownMenuItem<String>>((String value) => DropdownMenuItem(
                  value: value,
                  child: Text(value),
                ))
            .toList(),
        onChanged: (String? value) {
          setState(() {
            _maxRoundsValue = value;
          });
        },
      ),
       ElevatedButton(onPressed: CreateRoom, child: Text("create"))
    ]));
  }
}
