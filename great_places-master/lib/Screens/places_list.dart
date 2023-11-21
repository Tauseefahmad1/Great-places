//@dart = 2.9
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:greatplaces/providers/great_places.dart';
import 'add_places.dart';
import 'package:greatplaces/Screens/places_details.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Places You Wanna Visit"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AddPlacesScreen.routeName);
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: FutureBuilder(
          future:
              Provider.of<GreatPlaces>(context, listen: false).fetchAndSet(),
          builder: (context, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<GreatPlaces>(
                  child: Center(
                    child: Text("Got No Places yet, Start adding Some ...."),
                  ),
                  builder: (context, greatPlaces, ch) =>
                      greatPlaces.items.length <= 0
                          ? ch
                          : ListView.builder(
                              itemCount: greatPlaces.items.length,
                              itemBuilder: (context, i) => ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      FileImage(greatPlaces.items[i].image),
                                ),
                                title: Text(greatPlaces.items[i].title),
                                subtitle:
                                    Text(greatPlaces.items[i].location.address),
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      PlaceDetailScreen.routeName,
                                      arguments: greatPlaces.items[i].id);
                                },
                              ),
                            ),
                ),
        ));
  }
}
