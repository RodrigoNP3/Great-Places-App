//_________________________________________________Packages_____________________
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//_________________________________________________Providers____________________
import './providers/great_places.dart';

//_________________________________________________Screens______________________
import './screens/add_place_screen.dart';
import './screens/places_list_screen.dart';
import './screens/place_detail_screen.dart';

//______________________________________________________________________________

void main() => runApp(MyApp());

DateTime horaAgora = DateTime.now();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
              .copyWith(secondary: Colors.amber),
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (ctx) => AddPlaceScreen(),
          PlaceDetailScreen.routeName: (ctx) => PlaceDetailScreen(),
        },
      ),
    );
  }
}
