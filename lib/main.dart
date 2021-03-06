import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart' as hydratedBloc;
import 'package:flutter_bloc/flutter_bloc.dart' as bloc;
import 'package:meem/bloc/simple_bloc_observer.dart';
import 'package:meem/cubits/cubits.dart';
import 'package:meem/uis/intro/intro_screen.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  hydratedBloc.HydratedBloc.storage = await hydratedBloc.HydratedStorage.build(
    storageDirectory: kIsWeb
        ? hydratedBloc.HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  bloc.Bloc.observer = SimpleBlocObserver();
  runApp(
    bloc.MultiBlocProvider(
      providers: [
        bloc.BlocProvider<TabCubit>(create: (context) => TabCubit(0)),
        bloc.BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(
            ThemeData.light(),
          ),
        ),
      ],
      child: MeemApp(),
    ),
  );
}

class MeemApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: context.watch<ThemeCubit>().state,
      home: IntroScreen(),
    );
  }
}
