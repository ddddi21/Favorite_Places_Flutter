import 'package:favorite_places/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/places.dart';
import './screens/add_place_screen.dart';
import './screens/place_details_screen.dart';
import './screens/places_list_screens.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: ViewModel(),
      child: MaterialApp(
        title: 'Great Places',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          accentColor: Colors.amberAccent,
          fontFamily: 'Lato',
        ),
        home: Scaffold (
          body: SafeArea (
            child:  BasicBottomNavBar(),
          ),
          // bottomNavigationBar: BasicBottomNavBar(),
        ),
        // home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
          PlaceDetailsScreen.routeName: (ctx) => PlaceDetailsScreen(),
        },
      ),
    );
  }
}
