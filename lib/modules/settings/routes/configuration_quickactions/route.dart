import 'package:flutter/material.dart';
import 'package:lunasea/core.dart';
import 'package:lunasea/modules/settings.dart';
import 'package:lunasea/system/quick_actions/quick_actions.dart';

class SettingsConfigurationQuickActionsRouter extends SettingsPageRouter {
  SettingsConfigurationQuickActionsRouter()
      : super('/settings/configuration/quickactions');

  @override
  Widget widget() => _Widget();

  @override
  void defineRoute(FluroRouter router) {
    super.noParameterRouteDefinition(router);
  }
}

class _Widget extends StatefulWidget {
  @override
  State<_Widget> createState() => _State();
}

class _State extends State<_Widget> with LunaScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return LunaScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar() as PreferredSizeWidget?,
      body: _body(),
    );
  }

  Widget _appBar() {
    return LunaAppBar(
      scrollControllers: [scrollController],
      title: 'settings.QuickActions'.tr(),
    );
  }

  Widget _body() {
    return LunaListView(
      controller: scrollController,
      children: [
        SettingsBanners.QUICK_ACTIONS_SUPPORT.banner(),
        _actionTile(
          LunaModule.LIDARR.name,
          LunaSeaDatabase.QUICK_ACTIONS_LIDARR,
        ),
        _actionTile(
          LunaModule.NZBGET.name,
          LunaSeaDatabase.QUICK_ACTIONS_NZBGET,
        ),
        if (LunaModule.OVERSEERR.featureFlag)
          _actionTile(
            LunaModule.OVERSEERR.name,
            LunaSeaDatabase.QUICK_ACTIONS_OVERSEERR,
          ),
        _actionTile(
          LunaModule.RADARR.name,
          LunaSeaDatabase.QUICK_ACTIONS_RADARR,
        ),
        _actionTile(
          LunaModule.SABNZBD.name,
          LunaSeaDatabase.QUICK_ACTIONS_SABNZBD,
        ),
        _actionTile(
          LunaModule.SEARCH.name,
          LunaSeaDatabase.QUICK_ACTIONS_SEARCH,
        ),
        _actionTile(
          LunaModule.SONARR.name,
          LunaSeaDatabase.QUICK_ACTIONS_SONARR,
        ),
        _actionTile(
          LunaModule.TAUTULLI.name,
          LunaSeaDatabase.QUICK_ACTIONS_TAUTULLI,
        ),
      ],
    );
  }

  Widget _actionTile(String title, LunaSeaDatabase action) {
    return LunaBlock(
      title: title,
      trailing: ValueListenableBuilder(
        valueListenable: LunaBox.lunasea.box.listenable(keys: [action.key]),
        builder: (context, dynamic _, __) => LunaSwitch(
            value: action.read(),
            onChanged: (value) {
              action.update(value);
              if (LunaQuickActions.isSupported)
                LunaQuickActions().setActionItems();
            }),
      ),
    );
  }
}
