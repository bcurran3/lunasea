import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/home.dart';

class HomeSummaryTile extends StatelessWidget {
    final String title;
    final String subtitle;
    final IconData icon;
    final int index;
    final String route;
    final Color color;

    HomeSummaryTile({
        @required this.title,
        @required this.subtitle,
        @required this.icon,
        @required this.index,
        @required this.route,
        @required this.color,
    });

    @override
    Widget build(BuildContext context) => ValueListenableBuilder(
        valueListenable: Database.lunaSeaBox.listenable(keys: [HomeDatabaseValue.MODULES_BRAND_COLOURS.key]),
        builder: (context, box, _) => LSCardTile(
            title: LSTitle(text: title),
            subtitle: LSSubtitle(text: subtitle),
            trailing: LSIconButton(
                icon: icon,
                color: HomeDatabaseValue.MODULES_BRAND_COLOURS.data
                    ? color
                    : LunaColours.list(index),
            ),
            onTap: () async => LunaState.navigatorKey.currentState.pushNamedAndRemoveUntil(route, (Route<dynamic> route) => false),
        ),
    );
}