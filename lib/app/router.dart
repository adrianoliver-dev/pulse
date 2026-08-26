import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/models/workout_plan.dart';
import '../features/history/history_screen.dart';
import '../features/home/home_screen.dart';
import '../features/library/editor_screen.dart';
import '../features/music/music_library_screen.dart';
import '../features/music/playlist_editor_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/shell/shell_screen.dart';
import '../features/workout/workout_screen.dart';

final _rootKey = GlobalKey<NavigatorState>();

GoRouter createRouter() {
  return GoRouter(
    navigatorKey: _rootKey,
    initialLocation: '/',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            ShellScreen(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/music',
                builder: (context, state) => const MusicLibraryScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/history',
                builder: (context, state) => const HistoryScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: '/editor',
        builder: (context, state) {
          final extra = state.extra;
          return EditorScreen(initial: extra is RoutineSpec ? extra : null);
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: '/workout',
        builder: (context, state) {
          final extra = state.extra;
          if (extra is! RoutineSpec) {
            return const Scaffold(body: Center(child: Text('Missing routine')));
          }
          return WorkoutScreen(spec: extra);
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootKey,
        path: '/playlist/:id',
        builder: (context, state) {
          return PlaylistEditorScreen(playlistId: state.pathParameters['id']!);
        },
      ),
    ],
  );
}
