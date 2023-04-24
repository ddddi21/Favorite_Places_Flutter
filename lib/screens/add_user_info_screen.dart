import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/places.dart';

class AddUserInfoScreen extends StatefulWidget {
  final String name;
  final String surname;

  AddUserInfoScreen({
    this.name,
    this.surname,
  });

  @override
  AddUserInfoScreenState createState() => AddUserInfoScreenState();
}

class AddUserInfoScreenState extends State<AddUserInfoScreen> {
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();

  void _saveInfo() {
    if (_nameController.text.isEmpty || _surnameController.text.isEmpty) {
      return;
    }

    Provider.of<ViewModel>(context, listen: false)
        .addUserInfo(_nameController.text, _surnameController.text);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    _nameController.text = widget.name;
    _surnameController.text = widget.surname;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add info about yourself!'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Name'),
                      controller: _nameController,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Surname'),
                      controller: _surnameController,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 40,
            margin: EdgeInsets.fromLTRB(100, 10, 100, 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            child: ElevatedButton.icon(
              icon: Icon(Icons.add),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                ),
              ),
              label: Text('Add Info'),
              onPressed: _saveInfo,
            ),
          ),
        ],
      ),
    );
  }
}
