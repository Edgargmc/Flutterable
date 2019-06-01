import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppButtom extends StatelessWidget {
  final BuildContext context;
  final String label;
  final GestureTapCallback customOnTap;
  final Icon icon;
  final Color color;

  AppButtom({
    this.context,
    this.label,
    this.icon,
    this.customOnTap,
    this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: customOnTap,
        child: Container(
          width: MediaQuery.of(context).size.width - 60.0,
          height: 40.0,
          decoration: new BoxDecoration(
            color: Theme.of(context).buttonColor,
            //   border: new Border.all(color: AppTheme.TriadaPrimary2, width: 1.0),
            borderRadius: new BorderRadius.circular(10.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black26,
                offset: Offset(1.0, 2.0),
                blurRadius: 2.0,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              icon != null ? icon : Container(),
              new Center(
                child: new Text(
                  label,
                  //  style: AppTheme.TSButtonLabel,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppButtonProgress extends StatelessWidget {
  final BuildContext context;

  AppButtonProgress({
    this.context,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: MediaQuery.of(context).size.width - 60.0,
        height: 40.0,
        decoration: new BoxDecoration(
          color: Theme.of(context).buttonColor,
          //   border: new Border.all(color: AppTheme.TriadaPrimary2, width: 1.0),
          borderRadius: new BorderRadius.circular(10.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black38,
              offset: Offset(1.0, 2.0),
              blurRadius: 4.0,
            ),
          ],
        ),
        child: SpinKitRipple(color: Colors.white),
      ),
    );
  }
}
