import 'package:Px/screens/sport_news.dart';
import 'package:Px/screens/web_view_screen.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/remote_config_cubit.dart';
import 'not_internet_connection_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RemoteConfigCubit(FirebaseRemoteConfig.instance),
      child: const ContentWidget(),
    );
  }
}

class ContentWidget extends StatelessWidget {
  const ContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<RemoteConfigCubit, RemoteConfigState>(
          builder: (context, state) {
            if (state is RemoteConfigLoaded) {
              return WebViewScreen(state.url);
            }
            if (state is RemoteConfigError) {
              return const NotInternetConnectionScreen();
            }
            if (state is RemoteConfigLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is RemoteConfigSportNews) {
              return const SportNews();
            }

            return const Center(
              child: Text('Something went wrong!'),
            );
          },
        ),
      ),
    );
  }
}
