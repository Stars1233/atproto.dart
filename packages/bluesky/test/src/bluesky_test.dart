// Package imports:
import 'package:atproto/atproto.dart';
import 'package:atproto_core/atproto_core.dart' as core;
import 'package:test/test.dart';

// Project imports:
import 'package:bluesky/src/bluesky.dart';
import 'package:bluesky/src/services/codegen/app/bsky/actor_service.dart';
import 'package:bluesky/src/services/codegen/app/bsky/feed_service.dart';
import 'package:bluesky/src/services/codegen/app/bsky/graph_service.dart';
import 'package:bluesky/src/services/codegen/app/bsky/notification_service.dart';
import 'package:bluesky/src/services/codegen/app/bsky/unspecced_service.dart';

void main() {
  group('.session', () {
    test('fromSession', () {
      final session = core.Session(
        did: 'aaaa',
        handle: 'bbbbb',
        accessJwt: 'cccccc',
        refreshJwt: 'ddddddd',
      );

      final atproto = ATProto.fromSession(session);

      expect(atproto.session != null, isTrue);
      expect(atproto.session, session);
    });

    test('anonymous', () {
      final atproto = ATProto.anonymous();

      expect(atproto.session == null, isTrue);
    });
  });

  test('.actor', () {
    final service = Bluesky.fromSession(
      core.Session(
        did: 'aaaa',
        handle: 'shinyakato.dev',
        accessJwt: 'test',
        refreshJwt: 'test',
      ),
    ).actor;

    expect(service, isA<ActorService>());
  });

  test('.feed', () {
    final service = Bluesky.fromSession(
      core.Session(
        did: 'aaaa',
        handle: 'shinyakato.dev',
        accessJwt: 'test',
        refreshJwt: 'test',
      ),
    ).feed;

    expect(service, isA<FeedService>());
  });

  test('.notification', () {
    final service = Bluesky.fromSession(
      core.Session(
        did: 'aaaa',
        handle: 'shinyakato.dev',
        accessJwt: 'test',
        refreshJwt: 'test',
      ),
    ).notification;

    expect(service, isA<NotificationService>());
  });

  test('.graph', () {
    final service = Bluesky.fromSession(
      core.Session(
        did: 'aaaa',
        handle: 'shinyakato.dev',
        accessJwt: 'test',
        refreshJwt: 'test',
      ),
    ).graph;

    expect(service, isA<GraphService>());
  });

  test('.unspecced', () {
    final service = Bluesky.fromSession(
      core.Session(
        did: 'aaaa',
        handle: 'shinyakato.dev',
        accessJwt: 'test',
        refreshJwt: 'test',
      ),
    ).unspecced;

    expect(service, isA<UnspeccedService>());
  });

  group('.service', () {
    test('case1', () {
      final atproto = ATProto.anonymous();

      expect(atproto.service, 'bsky.social');
    });

    test('case2', () {
      final atproto = ATProto.anonymous(service: 'syu.is');

      expect(atproto.service, 'syu.is');
    });
  });

  group('.relayService', () {
    test('case1', () {
      final atproto = ATProto.anonymous();

      expect(atproto.relayService, 'bsky.network');
    });

    test('case2', () {
      final atproto = ATProto.anonymous(relayService: 'bgs.syu.is');

      expect(atproto.relayService, 'bgs.syu.is');
    });
  });
}
