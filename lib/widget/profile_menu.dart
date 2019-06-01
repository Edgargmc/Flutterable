import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:redux/redux.dart'; //final googleSignIn = new GoogleSignIn();
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

enum MenuProfileOption {
  terms,
  signOut,
  contact,
}

class ProfileMenu extends StatelessWidget {
  final Function() getTerms;
  final Function() signOut;
  final Function() getContacto;

  ProfileMenu({this.getTerms, this.signOut, this.getContacto});
  @override
  Widget build(BuildContext context) {
    void showMenuSelections(MenuProfileOption value) {
      if (value == MenuProfileOption.terms) {
        getTerms();
      } else if (value == MenuProfileOption.signOut) {
        signOut();
      } else if (value == MenuProfileOption.contact) {
        getContacto();
      } else {
        // Store _store = StoreProvider.of<AppState>(context);
        // _store.dispatch(actions.UpdateMenuAction(menuOption: value));
        // _store.dispatch(actions.RefreshGroupPlayersAction(menuOption: value));
      }
    }

    return PopupMenuButton<MenuProfileOption>(
        onSelected: showMenuSelections,
        itemBuilder: //widget.activeTab == AppTab.players
            (BuildContext context) => <PopupMenuEntry<MenuProfileOption>>[
                  PopupMenuItem<MenuProfileOption>(value: MenuProfileOption.terms, child: ListTile(leading: Icon(FontAwesomeIcons.fileContract), title: Text('Términos'))),
                  PopupMenuItem<MenuProfileOption>(value: MenuProfileOption.contact, child: ListTile(leading: Icon(FontAwesomeIcons.envelope), title: Text('Feedback'))),
                  PopupMenuItem<MenuProfileOption>(value: MenuProfileOption.signOut, child: ListTile(leading: Icon(FontAwesomeIcons.signOutAlt), title: Text('Cerrar sessión'))),
                ]);
  }
}
