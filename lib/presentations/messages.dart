import 'package:cloud_firestore/cloud_firestore.dart';

class IMessageNotiMessage {
  static const WELCOME = 'Welcome';
  static const NEW_MATCH = 'New Match Open';
  static const ADD_PLAYER_TO_GROUP = 'Welcome';
  static const REMOVE_PLAYER_TO_GROUP = 'Bye Bye...';
  static const ADD_PLAYER_TO_MATCH = 'Add to match';
  static const REMOVE_PLAYER_TO_TO_MATCH = 'Remove to match';
  static const MATH_COMPLETE = 'Match Complete';
  static const UPDATE_STATICSTIS = 'Upadte Staticstis';
  static const PRIVATE_CHAT = 'Welcome Private Chat';
}

class IMessageColor {
  static const bcolor5762 = '#d9effa';
  static const scolor5762 = '#2f363e';
  static const bcolor34 = '#5295D0';
  static const scolor34 = '#fafafa';
  static const bcolor1 = '#f43e00';
  static const scolor1 = '#fafafa';
}

class INotificacionType {
  static const notifPlayerRemove1 = 1;
  static const notifPlayerAdd2 = 2;
  static const notifMatchComplete3 = 3;
  static const notifMatchNew4 = 4;
  static const notifMessage5 = 5;
  static const notiAddToGroup6 = 6;
  static const notifMatchUpdateStatistics7 = 7;
  static const notiRemoveToGroup8 = 8;
  static const notifVote9 = 9;
}

class IMessageType {
  static const TEXT = 'T'; // text
  static const LOCATION = 'L'; //  Location
  static const PICTURE = 'P'; // Picture
  static const AUDIO = 'A'; // audio
  static const INFO = 'I'; // info
}

class IAttachmentType {
  static const VIDEO = 'video';
  static const LOCATION = 'location';
  static const PICTURE = 'picture';
}

class ILocation {
  num lat;
  num lng;
  int zoom;
}

/* ******************************************************************************** */
//@immutable
class Message {
  final String groupId;
  final String uid;
  String sId;
  String sName;
  //final String sColor;
  // final String bColor;
  String sPhoto;
  Timestamp createdAt;
  final String content;
  final String type; // T:P:A:L // text, picture, audio, location
  final bool fromCache;
  final bool hasPendingWrites;
  final String equip;
  final int notif;
  final String toUserUid;
  final ILocation location;
  final String imageUrl;
  String sCreateName;
  String sCreateId;

  Message(
      {this.uid,
      this.groupId,
      this.sId,
      this.sName,
      // this.sColor,
      // this.bColor,
      this.sPhoto,
      this.createdAt,
      this.content,
      this.type,
      this.fromCache,
      this.hasPendingWrites,
      this.equip,
      this.notif,
      this.toUserUid,
      this.location,
      this.imageUrl,
      this.sCreateName,
      this.sCreateId});

  static Message fromJson({Map<String, dynamic> json, String uid}) {
    // static Message fromJson(json) {
    return Message(
      uid: uid,
      sId: json["sId"] as String,
      sName: json["sName"] as String,
      // sColor: json["sColor"] as String,
      // bColor: json["bColor"] as String,
      sPhoto: json["sPhoto"] as String,
      createdAt: json["createdAt"] as Timestamp,
      content: json["content"] as String,
      type: json["type"] as String,
      notif: json["notif"] as int,
      toUserUid: json["toUserUid"] as String,
      imageUrl: json["imageUrl"] as String,
      sCreateName: json["sCreateName"] as String,
      sCreateId: json["sCreateId"] as String,
    );
  }

  Map<String, Object> toJson() {
    return {
      "sId": sId,
      "sName": sName,
      // "sColor": sColor,
      // "bColor": bColor,
      "sPhoto": sPhoto,
      "createdAt": createdAt,
      "content": content,
      "type": type,
      // "fromCache": fromCache,
      // "hasPendingWrites": hasPendingWrites,
      //"equip": equip,
      "notif": notif,
      "toUserUid": toUserUid,
      "location": location ?? null,
      "imageUrl": imageUrl ?? null,
      "sCreateName": sCreateName,
      "sCreateId": sCreateId
    };
  }

  @override
  String toString() {
    return 'Message{groupId: $groupId, sId: $sId, sName: $sName, sPhoto: $sPhoto, createdAt: $createdAt,'
        ' content: $content, type: $type, fromCache: $fromCache, hasPendingWrites: $hasPendingWrites, equip: $equip, notif: $notif,'
        ' toUserUid: $toUserUid, location: $location, imageUrl: $imageUrl, sCreateName:$sCreateName}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Message &&
          runtimeType == other.runtimeType &&
          groupId == other.groupId &&
          sId == other.sId &&
          sName == other.sName &&
          //sColor == other.sColor &&
          // bColor == other.bColor &&
          sPhoto == other.sPhoto &&
          createdAt == other.createdAt &&
          content == other.content &&
          type == other.type &&
          fromCache == other.fromCache &&
          hasPendingWrites == other.hasPendingWrites &&
          equip == other.equip &&
          notif == other.notif &&
          toUserUid == other.toUserUid &&
          location == other.location &&
          sCreateName == other.sCreateName &&
          imageUrl == other.imageUrl;

  @override
  int get hashCode =>
      groupId.hashCode ^
      sId.hashCode ^
      sName.hashCode ^
      // sColor.hashCode ^
      // bColor.hashCode ^
      sPhoto.hashCode ^
      createdAt.hashCode ^
      content.hashCode ^
      type.hashCode ^
      fromCache.hashCode ^
      hasPendingWrites.hashCode ^
      equip.hashCode ^
      notif.hashCode ^
      toUserUid.hashCode ^
      location.hashCode ^
      sCreateName.hashCode ^
      imageUrl.hashCode;
}
