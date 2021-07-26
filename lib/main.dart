import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/blocs/auth/auth_bloc.dart';
import 'package:instagram_clone/blocs/simple_bloc_observer.dart';
import 'package:instagram_clone/repositories/auth/auth_repository.dart';
import 'package:instagram_clone/screens/screens.dart';

import 'config/custom_router.dart';
import 'repositories/post/post_repository.dart';
import 'repositories/storage/storage_repository.dart';
import 'repositories/user/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer == SimpleBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   // AuthRepository().logOut();
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(create: (_) => AuthRepository()),

        RepositoryProvider<UserRepository>(create: (_) => UserRepository()),
        RepositoryProvider<StorageRepository>(create: (_) => StorageRepository()),
        RepositoryProvider<PostRepository>(create: (_) => PostRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(create: (context) => AuthBloc(authRepository: context.read<AuthRepository>()))
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Instagram',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.grey[50],
            appBarTheme: AppBarTheme(brightness: Brightness.light, color: Colors.white),
            iconTheme: const IconThemeData(color: Colors.black),
            textTheme:  const TextTheme(
              headline6: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold
              )
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity
          ),
          onGenerateRoute: CustomRouter.onGenerateRoute,
          initialRoute: SplashScreen.routeName,
        ),
      ),
    );
  }
}

