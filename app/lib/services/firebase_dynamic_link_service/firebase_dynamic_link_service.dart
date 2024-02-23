import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import '../../features/firebase_dynamic_link_handler/bloc/firebase_dynamic_link_handler_bloc.dart';
import '../../injector/injector.dart';
import '../crashlytics_service/crashlytics_service.dart';

class FirebaseDynamicLinkService {
  Uri? _pendingLink;

  FirebaseDynamicLinkService() {
    init();
  }

  init() async {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      _onNewDynamicDeeplinkDataReceived(dynamicLinkData);
    }).onError((error) {
      Injector.instance<CrashlyticsService>()
          .recordError(error, null, fatal: false);
    });
  }

  _onNewDynamicDeeplinkDataReceived(PendingDynamicLinkData data) {
    Injector.instance<FirebaseDynamicLinkBloc>()
        .add(DynamicLinkReceivedEvent(data.link));
  }

  checkForNewDynamicDeeplink() async {
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (initialLink != null) {
      _onNewDynamicDeeplinkDataReceived(initialLink);
    }
  }

  cachePendingLinkUntilLogin(Uri? invitationLink) {
    _pendingLink = invitationLink;
  }

  removePendingDeepLink() {
    _pendingLink = null;
  }

  initiateAnyPendingDeeplink() {
    if (_pendingLink != null) {
      Injector.instance<FirebaseDynamicLinkBloc>()
          .add(DynamicLinkReceivedEvent(_pendingLink!));
    }
  }
}
