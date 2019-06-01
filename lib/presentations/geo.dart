import 'dart:async';
import 'package:Beautix/models/analytics.dart';
import 'package:Beautix/models/processing.dart';
import 'package:Beautix/models/user.dart';
import 'package:Beautix/presentations/messages.dart';
import 'package:Beautix/theme.dart';
import 'package:Beautix/utils/geo_utils.dart';
import 'package:Beautix/utils/get_location_from_ip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Geo extends StatefulWidget {
  final User user;
  final User currentUser;
  final LatLng center;
  final Map<MarkerId, Marker> markers;
  final double zoom;
  final bool isEditable;
  final bool popNavigator;

  final Function({String message}) sendError;

  Geo({
    Key key,
    @required this.center,
    @required this.user,
    @required this.currentUser,
    @required this.markers,
    @required this.zoom,
    @required this.isEditable,
    @required this.sendError,
    @required this.popNavigator,
  })  : assert(user != null),
        assert(markers != null),
        assert(zoom != null),
        super(key: key);

  @override
  _GeoState createState() => _GeoState();
}

class _GeoState extends State<Geo> {
  //bool _processing = false;
  // GeoFirePoint _geoFirePoint = new GeoFirePoint(0.00, 0.00);
  LatLng _center;
  Completer<GoogleMapController> _mapController = Completer();
  bool _isActive = false;
  User user;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  bool _delete = false;
  GeoFirePoint geoFirePoint;
  Processing processing = new Processing(false);

  // List<Marker> _markers = [];
  Future<bool> _onWillPop() async {
    if (user.confirmGeo) {
      if (processing.value == false) {
        Navigator.of(context).pop(true);
        return false;
      } else {
        return false;
      }
    } else {
      showMessage(context: context, message: 'Necesitamos confirme su ubicación..');
      return false;
    }
  }

  void _onTapMap(LatLng value) {
    print("_onTapMap " + value.toString());
    if (widget.isEditable && processing.value == false) {
      if (user != null) {
        geoFirePoint = new GeoFirePoint(value.latitude, value.longitude);

        user = user.copyWitch(geoFirePoint: geoFirePoint);

        final MarkerId markerId = getMarkerId(user.id);
        final Marker marker = Marker(
          markerId: markerId,
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueBlue,
          ),
          position: LatLng(
            user.geoFirePoint.latitude,
            user.geoFirePoint.longitude,
          ),
          infoWindow: InfoWindow(title: user.name, snippet: user.address ?? ''),
          onTap: () {
            // setSelectedMarkerId(user, markerId);
          },
        );
        markers[markerId] = marker;
        _delete = false;
        if (_isActive) {
          setState(() {});
        }
      }
    }
  }

  /*
  void _deleteMarker() {
    if (widget.isEditable && processing.value == false && user != null) {
      GeoFirePoint geoFirePoint = new GeoFirePoint(0.00, 0.00);
      user = user.copyWitch(geoFirePoint: geoFirePoint);
      final MarkerId _markerId = getMarkerId(user.id);
      markers.removeWhere((markerId, marker) => markerId == _markerId);
      _delete = true;
      if (_isActive) {
        setState(() {});
      }
    }
  }


   */

  setNewPoint() {
    _onTapMap(LatLng(_center.latitude, _center.longitude));
    onSave();
  }

/* ********************************************************* */
  getLocation() async {
    try {
      var location = new Location();
      LocationData currentLocation;
      currentLocation = await location.getLocation();
      if (currentLocation != null) {
        _center = LatLng(currentLocation.latitude, currentLocation.longitude);
        //   setNewPoint();
        if (_isActive) {
          setNewPoint();
          setState(() {});
          _goToTheLake();
        }
      }
      print("getLocation: " + currentLocation.toString());
    } catch (error) {
      widget.sendError(message: "geo.dart.getLocation google_maps.getLocation " + error.toString());
      if (error.code == 'PERMISSION_DENIED') {
        showMessageError(context: context, message: 'Upss, trate de marcar su posición aproximada en el mapa... ');
      } else {
        showMessageError(context: context, message: 'error code: ' + error.code + ' error message:' + error.message);
      }
      if (_center == null) {
        widget.sendError(message: "geo.dart.getLocation google_maps.getPositionFromIp  call");
        _center = await getPositionFromIp();
        widget.sendError(message: "geo.dart.getLocation google_maps.getPositionFromIp  return " + _center.latitude.toString() + ' ' + _center.longitude.toString());
      }
      if (_center == null) {
        _center = LatLng(-34.63340184606355, -58.385113812983036); // buenos aires
      }
      setNewPoint();
      if (_isActive) {
        setState(() {});
        _goToTheLake();
      }
    }
  }

/* ********************************************************* */
  /* ********************************************************* */
  Widget loadingLocation(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Text(
                    'Buscando ubicación actual...',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ],
        ));
  }

/* ********************************************************* */
  onSave({bool confirmGeo = false}) async {
    return await Firestore.instance.collection('users').document(user.id).setData({'geoFirePoint': geoFirePoint.data, 'confirmGeo': confirmGeo}, merge: true);
  }

  /* ********************************************************* */

  Widget btnSave(BuildContext context) {
    return Container(
      height: 44.0,
      width: MediaQuery.of(context).size.width,
      decoration: AppTheme.buttonDecoration,
      //padding: EdgeInsets.only(left: 8.0, right: 8.0), // EdgeInsets.only(bottom: 4.0, top: MediaQuery.of(context).size.height - 100.0),
      child: new RaisedButton(
        elevation: 4.0,
        color: AppTheme.Buttom,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              FontAwesomeIcons.mapMarkedAlt,
              color: Colors.white,
            ),
            Padding(
              padding: EdgeInsets.only(left: 14.0, right: 4.0),
              child: Text(
                "Confirmar mi ubicación",
                style: AppTheme.TSButtonLabel,
              ),
            ),
          ],
        ),
        onPressed: () async {
          if (processing.value == false) {
            if (widget.isEditable) {
              if (geoFirePoint != null) {
                processing.value = true;
                await onSave(confirmGeo: true);
                processing.value = false;
                if (widget.popNavigator) {
                  Navigator.of(context).pop(true);
                }
              }
            }

            // widget.onSaveCallback(onResult: onResult, onError: onError, geoFirePoint: user.geoFirePoint);
          }
        },
      ),
    );
  }

/* ********************************************************* */
  /*
  Widget btnCancel(BuildContext context) {
    return Container(
      height: 44.0,
      width: MediaQuery.of(context).size.width / 2 - 10.0,
      padding: EdgeInsets.all(4.0), // EdgeInsets.only(bottom: 4.0, top: MediaQuery.of(context).size.height - 100.0),
      child: new MaterialButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Icon(FontAwesomeIcons.trash),
            Center(
              child: Text(
                "Deseleccionar",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        ),
        onPressed: () {
          if (processing.value == false) {
            _deleteMarker();
          }
        },
        elevation: 4.0,
        minWidth: double.infinity,
        height: 48.0,
        color: AppTheme.Buttom,
      ),
    );
  }


   */
/* ********************************************************* */
/* ********************************************************* */
  Future<void> _goToTheLake() async {
    CameraPosition _kLake = CameraPosition(bearing: 192.8334901395799, target: _center, tilt: 59.440717697143555, zoom: widget.zoom);
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

/* ********************************************************* */
  @override
  void initState() {
    super.initState();
    //  getPositionFromIp();
    _isActive = true;
    if (widget.user != null) {
      user = widget.user;
      markers = widget.markers;
    }

    if (widget.center == null) {
      getLocation();
    } else {
      _center = widget.center;
      geoFirePoint = GeoFirePoint(_center.latitude, _center.longitude);
    }
    Analytics().setCurrentScreen('Geo');
  }

  @override
  void dispose() {
    _isActive = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    try {
      //  return loadingLocation(context);
      //    return Container(width: 100,height: 200, color: Colors.red,)
      return new WillPopScope(
        onWillPop: _onWillPop,
        child: SafeArea(
          bottom: true,
          child: new Scaffold(
            key: Key('ScaffoldGeoKey' + widget.user.id),
            appBar: new PreferredSize(
              preferredSize: new Size(null, 50.0),
              child: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: AppTheme.logoAppSolo,
                leading: IconButton(
                  //icon: const Icon(FontAwesomeIcons.chevronLeft),
                  icon: AppTheme.iconBack,
                  onPressed: () {
                    _onWillPop();
                  },
                ),
              ),
            ),
            body: _center == null
                ? loadingLocation(context)
                : Stack(
                    children: <Widget>[
                      new Column(
                        children: [
                          new Flexible(
                            key: Key('FlutterMapKey' + user.id ?? 'none'),
                            child: GoogleMap(
                              mapType: MapType.normal,
                              initialCameraPosition: CameraPosition(
                                target: _center,
                                zoom: widget.zoom ?? 11.0,
                              ),
                              gestureRecognizers:
                                  // TODO(iskakaushik): Remove this when collection literals makes it to stable.
                                  // https://github.com/flutter/flutter/issues/28312
                                  // ignore: prefer_collection_literals
                                  <Factory<OneSequenceGestureRecognizer>>[
                                Factory<OneSequenceGestureRecognizer>(
                                  () => EagerGestureRecognizer(),
                                ),
                              ].toSet(),
                              markers: Set<Marker>.of(markers.values),
                              onMapCreated: (GoogleMapController controller) {
                                _mapController.complete(controller);
                                _goToTheLake();
                              },
                              compassEnabled: true,
                              myLocationEnabled: true,
                              myLocationButtonEnabled: true,
                              onTap: (LatLng value) {
                                _onTapMap(value);
                                // print(value.toString());
                              },
                            ),
                          ),
                          Padding(
                            padding: new EdgeInsets.only(top: 4.0, bottom: 4.0, left: 4.0, right: 4.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Es esta es tu ubicación?',
                                    style: Theme.of(context).textTheme.title,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      user.isProvider ?? false
                                          ? 'Necesitamos tu ubicación para que los clientes te encuentren. Presioná sobre el mapa para seleccionarla.'
                                          : 'Necesitamos tu ubicación para mostrarte los servicios de belleza más cercanos. Presioná sobre el mapa para seleccionarla.',
                                      style: Theme.of(context).textTheme.body1,
                                    ),
                                  ),
                                  btnSave(context),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      );
    } catch (error) {
      widget.sendError(message: "geo.dart.build catch " + error.toString() + ' _center:' + _center.toString() + ' widget.zoom: ' + widget.zoom.toString());
    }
  }
}
