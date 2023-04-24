import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../models/UserInfo.dart';
import '../models/place.dart';
import '../helper/db_manager.dart';
import '../helper/location_manager.dart';

class ViewModel with ChangeNotifier {
  List<Place> _placeItems = [];

  UserInfo _userInfoItems = UserInfo(id: '0', name: '', surname: '');

  UserInfo get userInfoItems {
    return _userInfoItems;
  }
  List<Place> get placeItems {
    return [..._placeItems];
  }

  Place findById(String id) {
    return _placeItems.firstWhere((place) => place.id == id);
  }

  void addPlaces(
    String pickedTitle,
    File pickedImage,
    PlaceLocation pickedLocation,
  ) async {
    final address = await LocationHelper.getLocationAddress(
      pickedLocation.longitude,
      pickedLocation.latitude,
    );
    final updatedLocation = PlaceLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: address,
    );
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: updatedLocation,
      
    );

    _placeItems.add(newPlace);
    notifyListeners();
    DBManager.insert(
      'user_places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
        'loc_lat': newPlace.location.latitude,
        'loc_lng': newPlace.location.longitude,
        'address': newPlace.location.address,
      }
    );
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBManager.getData('user_places');
    _placeItems = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlaceLocation(
              latitude: item['loc_lat'],
              longitude: item['loc_lng'],
              address: item['address'],
            ),
          ),
        )
        .toList();
  }

  void addUserInfo(
      String name,
      String surname,
      ) async {
    final newInfo = UserInfo(
        id: "0",
        name: name,
        surname: surname
    );

    _userInfoItems = newInfo;
    notifyListeners();
    DBManager.update('user_info', {
      'id': newInfo.id,
      'name': newInfo.name,
      'surname': newInfo.surname,
    });
  }

  Future<UserInfo> getUserInfo() async {
    final dataList = await DBManager.getData('user_info');
    _userInfoItems = dataList.map((item) => UserInfo(
      id: item['id'],
      name: item['name'],
      surname: item['surname'],
    )) as UserInfo;
    return _userInfoItems;
  }
}
