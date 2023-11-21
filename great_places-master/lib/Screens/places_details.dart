//@dart=2.9
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:greatplaces/providers/great_places.dart';
import 'package:greatplaces/Screens/map_screen.dart';

class PlaceDetailScreen extends StatefulWidget {
  static const routeName = '/detail_screen';
  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments;
    final selectedPlace = Provider.of<GreatPlaces>(context).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            selectedPlace.location.address,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => MapScreen(
                          initialLocation: selectedPlace.location,
                          isSelecting: false,
                        )));
              },
              child: Text("View On Map"))
        ],
      ),
    );
  }
}
