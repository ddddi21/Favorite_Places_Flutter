import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/places.dart';
import 'add_user_info_screen.dart';

class UserInfoScreen extends StatelessWidget {
  static const routeName = '/user-info';

  const UserInfoScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Page"),
        ),
        body: FutureBuilder(
            future:
                Provider.of<ViewModel>(context, listen: false).getUserInfo(),
            builder: (ctx, snapShot) =>
                snapShot.connectionState == ConnectionState.waiting
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Consumer<ViewModel>(
                        child: Center(
                          child: const Text(
                              'Got no user info yet, start adding some!'),
                        ),
                        builder: (ctx, info, ch) => (false)
                            ? ch
                            : Column(
                                children: <Widget>[
                                  // Container(
                                  //   padding: EdgeInsets.all(8.0),
                                  //   margin: EdgeInsets.all(8),
                                  //   height: 250,
                                  //   width: double.infinity,
                                  //   child: Image.file(
                                  //     selectedPlace.image,
                                  //     fit: BoxFit.cover,
                                  //     width: double.infinity,
                                  //   ),
                                  // ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: Text(
                                      'Hello ${info.userInfoItems.name} ${info.userInfoItems.surname}!',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                        textStyle: MaterialStateProperty.all(
                                            TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor)),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.blueGrey[100])),
                                    child: Text('Edit my info'),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          fullscreenDialog: true,
                                          builder: (ctx) => AddUserInfoScreen(
                                            name: info.userInfoItems.name,
                                            surname: info.userInfoItems.surname,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                      )));
  }
}
