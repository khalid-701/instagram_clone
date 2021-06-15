import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/blocs/blocs.dart';
import 'package:instagram_clone/screens/login/login_screen.dart';
import 'package:instagram_clone/screens/nav/nav_scree.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/splash';

  static Route route(){
    return MaterialPageRoute(settings: const RouteSettings(name: routeName),
    builder: (_) => SplashScreen());
  }
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (prevState, state) => prevState.status != state.status,
        listener: (context, state){
          if(state.status == AuthStatus.unauthenticated){
            //Pergi ke Login
            Navigator.of(context).pushNamed(LoginScreen.routeName);
          } else if (state.status == AuthStatus.authenticated){
            // pergi ke NAv screen

            Navigator.of(context).pushNamed(NavScreen.routeName);
          }
          print(state);
        },
        child: const Scaffold(
          body: Center(
            child: CircularProgressIndicator(
            ),
          ),
        ),
      ),
    );
  }
}
