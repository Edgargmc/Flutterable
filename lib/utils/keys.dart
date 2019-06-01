import 'package:flutter/widgets.dart';
/*
import 'package:qChapp/presentations/post_audio_edit.dart';
import 'package:qChapp/presentations/widget_button_sound.dart';

final GlobalKey<WidgetEditSoundScreenState> keyEditSound = GlobalKey<WidgetEditSoundScreenState>();

final GlobalKey<WidgetButtonSoundState> keySound1 = GlobalKey<WidgetButtonSoundState>();
final GlobalKey<WidgetButtonSoundState> keySound2 = GlobalKey<WidgetButtonSoundState>();
final GlobalKey<WidgetButtonSoundState> keySound3 = GlobalKey<WidgetButtonSoundState>();
final GlobalKey<WidgetButtonSoundState> keySound4 = GlobalKey<WidgetButtonSoundState>();
final GlobalKey<WidgetButtonSoundState> keySound5 = GlobalKey<WidgetButtonSoundState>();
*/

class ArchKeys {
  static final homeScreen = const Key('__homeScreen__');
  static final homeScreenLoadingIndicator = const Key('__homeScreenLoadingIndicator__');
  static final profileLoadingIndicator = const Key('__profileLoadingIndicator__');
  static final profileEditLoadingIndicator = const Key('__profileEditLoadingIndicator__');
  static final postEditLoadingIndicator = const Key('__postEditLoadingIndicatorr__');
  static final renderingKeyHome = new GlobalKey();
  static final homeScaffoldKey = const Key('__homeScaffoldKey__');
}
