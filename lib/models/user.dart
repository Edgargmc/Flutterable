import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:meta/meta.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

@immutable
class User {
  final String id;
  final String email;
  final String bio;
  final String photoUrl;
  final String name;
  final String phone;
  final String address;
  final String city;
  final String zipCode;
  final String country;
  final DateTime age;
  final String sex;
  final bool isProvider;
  final int likes;
  final int noLikes;
  final GeoFirePoint geoFirePoint;
  final bool confirmGeo;
  final bool isAdmin;
  final bool isApproved;
  final String terms;

  const User({
    this.id,
    this.name,
    this.email,
    this.bio,
    this.photoUrl,
    this.phone,
    this.address,
    this.city,
    this.zipCode,
    this.country,
    this.sex,
    this.age,
    this.likes,
    this.noLikes,
    this.isProvider,
    this.geoFirePoint,
    this.confirmGeo,
    this.isAdmin,
    this.isApproved,
    this.terms,
  });

  User copyWitch({
    final String id,
    final String email,
    final String bio,
    final String photoUrl,
    final String name,
    final String phone,
    final String address,
    final String city,
    final String zipCode,
    final String country,
    final DateTime age,
    final String sex,
    final bool isProvider,
    final int likes,
    final int noLikes,
    final GeoFirePoint geoFirePoint,
    final bool confirmGeo,
    final bool isAdmin,
    final bool isApproved,
    final String terms,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      photoUrl: photoUrl ?? this.photoUrl,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      city: city ?? this.city,
      country: country ?? this.country,
      zipCode: zipCode ?? this.zipCode,
      age: age ?? this.age,
      sex: sex ?? this.sex,
      likes: likes ?? this.likes,
      noLikes: noLikes ?? this.noLikes,
      isProvider: isProvider ?? this.isProvider,
      geoFirePoint: geoFirePoint ?? this.geoFirePoint,
      confirmGeo: confirmGeo ?? this.confirmGeo,
      isAdmin: isAdmin ?? this.isAdmin,
      terms: terms ?? this.terms,
      isApproved: isApproved ?? this.isApproved,
    );
  }

  factory User.fromJson({Map<String, dynamic> json, String id}) {
    getGeo(snapShot) {
      try {
        if (snapShot != null) {
          GeoPoint geoPoint = snapShot["geopoint"];
          GeoFirePoint geoFirePoint = GeoFirePoint(geoPoint.latitude, geoPoint.longitude);

          return geoFirePoint;
        } else {
          return null;
        }
      } catch (error) {
        return null;
      }
    }

    DateTime toUtC(DateTime date) {
      return date.toUtc();
      /*
      return date.toLocal();

      if (date.isUtc) {
        return date.toUtc();
      } else {
        return date.toLocal();
      }

     */
    }

    DateTime toDateTime(date) {
      if (date != null) {
        if (date is DateTime) {
          return toUtC(date);
        } else if (date is String) {
          return toUtC(DateTime.parse(date));
        } else if (date is Timestamp) {
          DateTime _date = date.toDate();
          return toUtC(_date);
        } else {
          return null;
        }
      } else {
        return null;
      }
    }

    User user = new User(
      id: id,
      email: json['email'],
      name: json['name'] ?? json['username'],
      bio: json['bio'] ?? null,
      photoUrl: json['photoUrl'] ?? null,
      age: toDateTime(json['age']),
      sex: json['sex'] ?? null,
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      zipCode: json['zipCode'] ?? '',
      country: json['country'] ?? '',
      likes: json['likes'] != null ? json['likes'].toInt() : 0,
      noLikes: json['noLikes'] != null ? json['noLikes'].toInt() : 0,
      isProvider: json['isProvider'] != null ? json['isProvider'] : false,
      geoFirePoint: getGeo(json["geoFirePoint"]),
      confirmGeo: json["confirmGeo"] ?? false,
      isAdmin: json['isAdmin'] ?? false,
      isApproved: json['isApproved'] ?? false,
      terms: json['terms'] ?? '0',
    );

    return user;
  }

  factory User.fromDocument(DocumentSnapshot document) {
    return User.fromJson(json: document.data, id: document.documentID);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      "id": id,
      "name": name.trim(),
      "bio": bio != null ? bio.trim() : null,
      "age": age != null ? DateTime(age.year, age.month, age.day, age.hour, age.minute).toIso8601String() : null,
      "sex": sex,
      "email": email.trim(),
      "phone": phone != null ? phone.trim() : null,
      "photoUrl": photoUrl ?? null,
      "address": address != null ? address.trim() : null,
      "city": city != null ? city.trim() : null,
      "zipCode": zipCode != null ? zipCode.trim() : null,
      "country": country != null ? country.trim() : null,
      "isProvider": isProvider ?? false,
      //  "geoFirePoint": geoFirePoint != null ? geoFirePoint.data : null,
      "terms": terms ?? '0',
    };
    return json;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          bio == other.bio &&
          photoUrl == other.photoUrl &&
          name == other.name &&
          phone == other.phone &&
          address == other.address &&
          city == other.city &&
          zipCode == other.zipCode &&
          isProvider == other.isProvider &&
          likes == other.likes &&
          noLikes == other.noLikes &&
          geoFirePoint == other.geoFirePoint &&
          confirmGeo == other.confirmGeo &&
          isAdmin == other.isAdmin &&
          isApproved == other.isApproved &&
          terms == other.terms;

  @override
  int get hashCode =>
      id.hashCode ^
      email.hashCode ^
      bio.hashCode ^
      photoUrl.hashCode ^
      name.hashCode ^
      phone.hashCode ^
      address.hashCode ^
      city.hashCode ^
      zipCode.hashCode ^
      isProvider.hashCode ^
      likes.hashCode ^
      noLikes.hashCode ^
      geoFirePoint.hashCode ^
      confirmGeo.hashCode ^
      isAdmin.hashCode ^
      isApproved.hashCode ^
      terms.hashCode;

  @override
  String toString() {
    return 'User{id: $id, email: $email, bio:$bio, photoUrl: $photoUrl, name: $name, phone: $phone, address: $address, city: $city, zipCode: $zipCode, isPrestador: $isProvider, likes: $likes, noLikes: $noLikes, geoFirePoint: $geoFirePoint, confirmGeo: $confirmGeo, isAdmin: $isAdmin, isApproved: $isApproved, terms: $terms}';
  }
}

/* ****************************************** */
/* ****************************************** */
enum UserActionType { add, update, getCurrent, getOther, setCurrent, signOut }

class UserAction {
  // final Function(Result) onResult;
  // final Function(ErrorCallback) onError;
  final UserActionType type;
  User user;
  final String password;

  UserAction({
    // this.onResult,
    // this.onError,
    @required this.type,
    this.user,
    this.password,
  });
}

class UserAcceptTermAction {
  final User user;

  UserAcceptTermAction({
    this.user,
  });
}

class UserSignOutAction {}
/* ****************************************** */
/* ****************************************** */
