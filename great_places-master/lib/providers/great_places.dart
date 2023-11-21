//@dart = 2.9
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:greatplaces/models/places.dart';
import 'package:greatplaces/helper/DBhelper.dart';
import 'package:greatplaces/helper/Location_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  void addPlace(String pickedTitle, File pickedImage,
      PlaceLocation pickedLocation) async {
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);
    final updatedLocation = PlaceLocation(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        address: address);

    final place = Place(
        id: DateTime.now().toString(),
        image: pickedImage,
        title: pickedTitle,
        location: updatedLocation);
    _items.add(place);
    notifyListeners();

    DBHelper.Insert('user_places', {
      'id': place.id,
      'title': place.title,
      'image': place.image.path,
      'loc_lat': place.location.latitude,
      'loc_lng': place.location.longitude,
      'address': place.location.address
    });
  }

  Future<void> fetchAndSet() async {
    final dataList = await DBHelper.getData('user_places');

    _items = dataList
        .map((item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlaceLocation(
              latitude: item['loc_lat'],
              longitude: item['loc_lng'],
              address: item['address'],
            )))
        .toList();
    notifyListeners();
  }
}
