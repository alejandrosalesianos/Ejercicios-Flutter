import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_weather_project/pages/seach_bar.dart';
import 'package:flutter_weather_project/utils/preference_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mapa extends GoogleMapExampleAppPage {
  const Mapa() : super(const Icon(Icons.mouse), 'Map click');

  @override
  Widget build(BuildContext context) {
    return const _MapaClickBody();
  }
}

abstract class GoogleMapExampleAppPage extends StatelessWidget {
  const GoogleMapExampleAppPage(this.leading, this.title);

  final Widget leading;
  final String title;
}

class _MapaClickBody extends StatefulWidget {
  const _MapaClickBody();

  @override
  State<StatefulWidget> createState() => _MapaClickBodyState();
}

class _MapaClickBodyState extends State<_MapaClickBody> {
  GoogleMapController? mapController;
  LatLng _lastTap = LatLng(37.3754865, -6.0250989);
  late LatLng _lastLongPress;

  @override
  void initState() {
    PreferenceUtils.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GoogleMap googleMap = GoogleMap(
      onMapCreated: onMapCreated,
      initialCameraPosition: CameraPosition(
          target: LatLng(PreferenceUtils.getDouble('lat')!,
              PreferenceUtils.getDouble('lng')!),
          zoom: 11.0),
      onTap: (LatLng pos) async {
        setState(() {
          _lastTap = pos;
        });
        PreferenceUtils.setDouble('lat', pos.latitude);
        PreferenceUtils.setDouble('lng', pos.longitude);
      },
      markers: <Marker>{_createMarker()},
      onLongPress: (LatLng pos) {
        setState(() {
          _lastLongPress = pos;
        });
      },
    );

    final List<Widget> columnChildren = <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 50.0),
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 200,
            child: googleMap,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SearchBarWidget(),
      )
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: columnChildren,
    );
  }

  void onMapCreated(GoogleMapController controller) async {
    setState(() {
      mapController = controller;
    });
  }

  Marker _createMarker() {
    return Marker(markerId: MarkerId("marker_1"), position: position());
  }

  LatLng position() {
    if (PreferenceUtils.getDouble('lat') == null) {
      return _lastTap;
    } else {
      return LatLng(
          PreferenceUtils.getDouble('lat')!, PreferenceUtils.getDouble('lng')!);
    }
  }
}
