import 'package:google_maps_flutter/google_maps_flutter.dart';

MarkerId getMarkerId(String uid) {
  final String markerIdVal = 'marker_id_$uid';
  final MarkerId _markerId = MarkerId(markerIdVal);
  return _markerId;
}
