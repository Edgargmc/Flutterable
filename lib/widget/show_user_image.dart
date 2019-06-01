import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hack19/models/parametros.dart';
//import 'package:flutter_advanced_networkimage/flutter_advanced_networkimage.dart';

Widget getImage({photoUrl, width, height, imageCrop}) {
  if (imageCrop != null) {
    return Image.file(
      imageCrop,
      fit: BoxFit.cover,
      width: width,
      height: height,
    );
  } else if (photoUrl != null) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: photoUrl,
      fit: BoxFit.cover,
      placeholder: (context, url) => new SpinKitChasingDots(
            size: 20.0,
          ),
      errorWidget: (context, url, error) => new Icon(Icons.error),
    );
    /*
    return new Image(
      width: width,
      height: height,
      fit: BoxFit.cover,
      image: new CachedNetworkImageProvider(photoUrl),
    );

     */
  } else {
    /*
    return Image(
      width: width,
      height: height,
      fit: BoxFit.cover,
      image: new AssetImage("assets/default_small.jpg"),
    );

     */
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: photoUserDefault,
      fit: BoxFit.cover,
      placeholder: (context, url) => new SpinKitChasingDots(
            size: 20.0,
          ),
      errorWidget: (context, url, error) => new Icon(Icons.error),
    );
  }
}

/* *********************************************** */
class ShowProfileImage extends StatelessWidget {
  final String photoUrl;

  final double width;
  final double ratio;
  final File imageCrop;
  const ShowProfileImage({Key key, this.photoUrl, this.width = 50.0, this.imageCrop, this.ratio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = width / (this.ratio ?? 1.0);

    return getImage(photoUrl: photoUrl, imageCrop: imageCrop, width: width, height: height);
  }
}

/* ***************************************************************** */
class ShowUserLargeImage extends StatelessWidget {
  final String photoUrl;
  final Color color;
  final double width;
  final String title;
  final String bio;
  final File imageCrop;

  const ShowUserLargeImage({Key key, this.photoUrl, this.imageCrop, this.color = Colors.white, this.width, this.title = '', this.bio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Stack(children: <Widget>[
      ShowImage(
        //  key: new Key('SubServiceImageKey' + widget.id),
        photoUrl: photoUrl,
        imageCrop: imageCrop,
        width: width,
        ratio: paramImageProfileRatio,
        radius: 0,
        borderColor: Colors.black12,
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            title ?? '',
            textAlign: TextAlign.center,
            // style: AppTheme.TSPerfilName,
          ),
        ),
      ),
      Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 44.0, left: 8.0, right: 8.0),
          child: Text(
            bio ?? '',
            textAlign: TextAlign.center,
            //   style: AppTheme.TSPerfilBio,
          ),
        ),
      ),
    ]);
  }
}

/* ***************************************************************** */

/* ***************************************************************** */
class ShowImage extends StatelessWidget {
  final String photoUrl;
  final double width;
  final File imageCrop;
  final Color borderColor;
  final double ratio;
  final double radius;
  const ShowImage({
    Key key,
    this.photoUrl,
    this.width,
    this.imageCrop,
    this.borderColor,
    this.ratio,
    this.radius = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height = (width) / (ratio ?? paramImageServiceRatio); // paramImageProfileRatio;
    return new Container(
      width: width,
      height: _height,
      padding: EdgeInsets.all(0.0),
      margin: EdgeInsets.all(0.0),
      decoration: new BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(width: borderColor != null ? 1 : 0, color: borderColor ?? Colors.white),
        //   borderRadius: new BorderRadius.only(topLeft: const Radius.circular(40.0), topRight: const Radius.circular(40.0)),
        borderRadius: new BorderRadius.all(Radius.circular(radius)),
        //  color: Colors.red,
      ),
      child: ClipRRect(
          borderRadius: new BorderRadius.circular(radius),
          child: getImage(
            photoUrl: photoUrl,
            imageCrop: imageCrop,
            width: width,
            height: _height,
          )),
    );
  }
}
