import 'package:flutter/material.dart';
import 'package:tomei/addlocal.dart';
import 'package:tomei/data/adress_api.dart';
import 'package:tomei/data/packages_dao.dart';
import 'package:tomei/home.dart';
import 'package:tomei/model/Adress.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:geocoding/geocoding.dart';

class Locais extends StatefulWidget {
  final Adress pacote;

  Locais({this.pacote});

  @override
  _LocaisState createState() => _LocaisState();
}

class _LocaisState extends State<Locais> {
  Future<Adress> address;
  GoogleMapController mapController;
  List<Marker> _markersOnScreen = [];
  String endereco;
  @override
  void initState() {
    super.initState();
    address = PackagesDao().findAdress();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Adress>(
        future: address,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return buildAddButton();
          }
          if (snapshot.hasData) {
            return buildLocation(pacote: snapshot.data);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  buildAddButton() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () => {
              Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddLocal()))
                  .then((value) => setState(() {
                        address = PackagesDao().findAdress();
                      }))
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Text('Adicionar Localização',
                  style: Theme.of(context).textTheme.subtitle1),
            ),
          ),
        ],
      ),
    );
  }

  buildMap(Adress endereco) async {
    List<Location> locations = await locationFromAddress(endereco.rua +
        " " +
        endereco.numero.toString() +
        ", " +
        endereco.cidade);

    _addMarkers(locations[0].latitude, locations[0].longitude, endereco.rua,
        endereco.numero, endereco.cidade, endereco.estado);
    return GoogleMap(
      initialCameraPosition: CameraPosition(
          target: LatLng(locations[0].latitude, locations[0].longitude),
          zoom: 14.0),
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      mapType: MapType.normal,
      markers: Set.from(_markersOnScreen),
      onMapCreated: onMapCreated,
    );
  }

  void _addMarkers(lat, long, rua, numero, cidade, estado) {
    _markersOnScreen.add(
      Marker(
        markerId: MarkerId("1"),
        position: LatLng(lat, long),
        infoWindow: InfoWindow(
          title: rua + ", " + numero.toString(),
          snippet: cidade + " - " + estado,
        ),
      ),
    );
  }

  buildLocation({Adress pacote}) {
    return Column(
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(padding: const EdgeInsets.only(left: 20)),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: const EdgeInsets.symmetric(vertical: 5)),
                      Text(
                        pacote.rua + ", " + pacote.numero.toString(),
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Text(
                        pacote.bairro +
                            ', ' +
                            pacote.cidade +
                            ' - ' +
                            pacote.estado,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.location_on,
                            color: Color(0xFF828282),
                          ),
                          onPressed: () => navigate(endereco: pacote)),
                      IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Color(0xFF828282),
                          ),
                          onPressed: () => {
                                Navigator.of(context)
                                    .push(
                                      MaterialPageRoute(
                                        builder: (context) => AddLocal(
                                          pacote: pacote,
                                        ),
                                      ),
                                    )
                                    .then((_) => setState(() {
                                          address = PackagesDao().findAdress();
                                        }))
                              }),
                      IconButton(
                          icon: Icon(Icons.delete, color: Color(0xFF828282)),
                          onPressed: () => {
                                PackagesDao().deleteAddress(pacote.cep),
                                setState(() {
                                  address = PackagesDao().findAdress();
                                }),
                              }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0x44828282)))),
        ),
        Container(
          height: 600,
          child: FutureBuilder<dynamic>(
            future: buildMap(pacote),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                return snapshot.data;
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        )
      ],
    );
  }

  navigate({Adress endereco}) async {
    List<Location> locations = await locationFromAddress(endereco.rua +
        " " +
        endereco.numero.toString() +
        ", " +
        endereco.cidade);
    mapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(locations[0].latitude, locations[0].longitude),
        zoom: 20.0)));
    print(locations[0].latitude);
    _markersOnScreen.removeAt(0);
    _addMarkers(locations[0].latitude, locations[0].longitude, endereco.rua,
        endereco.numero, endereco.cidade, endereco.estado);
  }

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }

  void initializeMap(Adress endereco) async {
    List<Location> locations = await locationFromAddress(endereco.rua +
        " " +
        endereco.numero.toString() +
        ", " +
        endereco.cidade);
  }
}
