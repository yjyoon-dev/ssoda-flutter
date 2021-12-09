import 'package:fluro/fluro.dart';
import 'package:hashchecker_web/screens/event_join/event_join_screen.dart';
import 'package:hashchecker_web/screens/store_event/store_event_screen.dart';

class FRouter {
  static FluroRouter router = FluroRouter();

  static void setupRouter() {
    router.define('/:storeId',
        handler: Handler(
            handlerFunc: (context, params) =>
                StoreEventScreen(storeId: params['storeId']![0])),
        transitionType: TransitionType.fadeIn);
    router.define('/:storeId/:eventId',
        handler: Handler(
            handlerFunc: (context, params) => EventJoinScreen(
                storeId: params['storeId']![0],
                eventId: params['eventId']![0])),
        transitionType: TransitionType.fadeIn);
  }
}
