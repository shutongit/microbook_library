import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:microbook_library/pages/live/page.dart';
import 'package:microbook_library/pages/main.dart';
import 'package:microbook_library/pages/live/video_play.dart';
import 'package:microbook_library/pages/micro/micro_list.dart';

// class RouteConfig {
final GoRouter routes = GoRouter(routes: [
  GoRoute(
      path: '/', name: 'home', builder: (context, state) => const MainPage()),
  GoRoute(
    path: '/live',
    name: 'live',
    builder: (context, state) => const LivePage(),
    routes: [
      GoRoute(
          path: 'videoPlay',
          name: 'videoPlay',
          builder: (context, state) {
            final String extraString =
                GoRouterState.of(context).extra! as String;
            return VideoPlay(videoUrl: extraString);
          })
    ],
  ),
  GoRoute(path: '/micro', builder: (context, state) => Container(), routes: [
    GoRoute(
        path: 'list',
        name: 'microList',
        builder: (BuildContext context, GoRouterState state) {
          String id = state.pathParameters['id'] ?? '';
          return MicroList(id);
        })
  ])
]);
// }
