import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';
import '../models/place.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  LocationInput(this.onSelectPlace);
  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  void _showPreview(double lat, double lng) {
    final staticMapImageUrl = LocationHelper.GenerateLocationPreviewImage(
      longitude: lng,
      latitude: lat,
    );
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location()
        .getLocation(); // essa linha de código retorna a localização com: latitude, longitude etc.
    _showPreview(locData.latitude, locData.longitude);
    widget.onSelectPlace(
      locData.latitude,
      locData.longitude,
    );
  }

  Future<void> _selectOnMap() async {
    final locData = await Location().getLocation();

    final selecteLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => MapScreen(
          isSelecting: true,
          initialLocation: PlaceLocation(
            latitude: locData.latitude,
            longitude: locData.longitude,
          ),
        ),
      ),
    );
    if (selecteLocation == null) {
      return;
    }

    _showPreview(selecteLocation.latitude, selecteLocation.longitude);

    widget.onSelectPlace(
      selecteLocation.latitude,
      selecteLocation.longitude,
    );

    //...
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _previewImageUrl == null
              ? Text(
                  'No location chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              icon: Icon(Icons.location_on),
              label: Text('Current Location'),
              style:
                  TextButton.styleFrom(primary: Theme.of(context).primaryColor),
              onPressed: _getCurrentUserLocation,
            ),
            TextButton.icon(
              icon: Icon(Icons.map),
              label: Text('Select On Map'),
              style:
                  TextButton.styleFrom(primary: Theme.of(context).primaryColor),
              onPressed: _selectOnMap,
            ),
          ],
        ),
      ],
    );
  }
}
