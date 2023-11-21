import 'package:greatplaces/Screens/places_details.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'providers/great_places.dart';
import 'package:greatplaces/Screens/places_list.dart';
import 'package:greatplaces/Screens/add_places.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GreatPlaces(),
      child: MaterialApp(
        title: 'Flutter Demo',
        home: PlacesListScreen(),
        routes: {
          AddPlacesScreen.routeName: (context) => AddPlacesScreen(),
          PlaceDetailScreen.routeName: (context) => PlaceDetailScreen(),
        },
      ),
    );
  }
}
