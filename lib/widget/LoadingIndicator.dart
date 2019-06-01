import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatelessWidget {
  Color color;
  double size;
  LoadingIndicator({Key key, this.color, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      //  child: CircularProgressIndicator(backgroundColor: AppTheme.TriadaPrimary),
      child: SpinKitDoubleBounce(
        // color: color ?? AppTheme.TriadaPrimary,
        size: size ?? 20.0,
      ),
    );
  }
}

class LoadingIndicatorMini extends StatelessWidget {
  Color color;
  LoadingIndicatorMini({Key key, Color color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SpinKitPumpingHeart(),
    );
  }
}
/*
class LoadingIndicatorMini extends StatelessWidget {
  LoadingIndicatorMini({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SpinKitWave(size: 20.0, color: AppTheme.TriadaPrimary, type: SpinKitWaveType.center),
    );
  }
}
*/

class LoadingIndicatorLinear extends LinearProgressIndicator implements PreferredSizeWidget {
  LoadingIndicatorLinear({
    Key key,
    double value,
  }) : super(
          key: key,
          value: value,
          //   backgroundColor: AppTheme.TriadaPrimaryLight,
          // valueColor: AlwaysStoppedAnimation<Color>(AppTheme.TriadaPrimary),
        ) {
    preferredSize = Size(double.infinity, 3.0);
  }

  @override
  Size preferredSize;
}
