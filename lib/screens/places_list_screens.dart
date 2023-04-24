
import 'package:favorite_places/screens/place_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/places.dart';
import 'add_place_screen.dart';


class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('Your Places'),
        // actions: <Widget>[

        // ],
      ),
      body: FutureBuilder(
        future: Provider.of<ViewModel>(context, listen: false).fetchAndSetPlaces(),
        builder: (ctx, snapShot) => snapShot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<ViewModel>(
                child: Center(
                  child: const Text('Got no places yet, start adding some!'),
                ),
                builder: (ctx, places, ch) => places.placeItems.isEmpty
                    ? ch
                    : ListView.builder(
                        itemCount: places.placeItems.length,
                        itemBuilder: (ctx, i) => Container(
                          margin: const EdgeInsets.all(6.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 40,
                              backgroundImage: FileImage(
                                places.placeItems[i].image,
                              ),
                            ),
                            title: Text(
                              places.placeItems[i].title,
                              style: TextStyle(
                                fontSize: 21,
                              ),
                            ),
                            subtitle: Text(
                              places.placeItems[i].location.address,
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                PlaceDetailsScreen.routeName,
                                arguments: places.placeItems[i].id,
                              );
                            },
                          ),
                        ),
                      ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: IconButton(
          icon: Icon(
            Icons.add,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
          },
          color: Colors.black,
        ),
      ),
    );
  }
}
