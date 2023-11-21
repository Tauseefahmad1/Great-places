//@dart = 2.9
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:greatplaces/helper/Location_helper.dart';
import 'package:greatplaces/Screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  LocationInput(this.onSelectPlace);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  void _showPreview(double lat, double lng) {
    final staticMapImageURL = LocationHelper.genrateLocationPreviewImage(
        latitude: lat, longnitude: lng);
    setState(() {
      _previewImageUrl = staticMapImageURL;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final localData = await Location().getLocation();
      _showPreview(localData.latitude, localData.longitude);

      widget.onSelectPlace(localData.latitude, localData.longitude);
    } catch (error) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedLocation =
        await Navigator.of(context).push(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => MapScreen(
                  isSelecting: true,
                )));
    if (selectedLocation == null) {
      return;
    }
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget.onSelectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _previewImageUrl == null
              ? Text(
                  "No Location Chosen",
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
                onPressed: _getCurrentUserLocation,
                icon: Icon(Icons.location_on_outlined),
                label: Text("Current Location")),
            SizedBox(
              width: 5,
            ),
            ElevatedButton.icon(
                onPressed: _selectOnMap,
                icon: Icon(Icons.map),
                label: Text("Select On Map"))
          ],
        )
      ],
    );
  }
}
