import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_clone/repositories/auth/auth_repository.dart';
import 'package:instagram_clone/screens/login/cubit/login_cubit.dart';
import 'package:instagram_clone/screens/signup/signup_screen.dart';
import 'package:instagram_clone/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static const String routeName = "/login";

  static Route route() {
    return PageRouteBuilder(
        settings: const RouteSettings(name: routeName),
        transitionDuration: const Duration(seconds: 0),
        pageBuilder: (context, _, __) => BlocProvider<LoginCubit>(
            create: (_) =>
                LoginCubit(authRepository: context.read<AuthRepository>()),
            child: LoginScreen()));
  }

  // const LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status == LoginStatus.error) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(content: state.failure.message)
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Instagram",
                              style: TextStyle(
                                  fontSize: 28, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            TextFormField(
                                decoration: InputDecoration(hintText: "Email"),
                                onChanged: (value) => context
                                    .read<LoginCubit>()
                                    .emailChange(value),
                                validator: (value) => !value.contains("@")
                                    ? "Please enter a valid email "
                                    : null),
                            const SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                                obscureText: true,
                                decoration:
                                    InputDecoration(hintText: "Password"),
                                onChanged: (value) => context
                                    .read<LoginCubit>()
                                    .passwordChange(value),
                                validator: (value) => value.length < 6
                                    ? "Must be at least 6 characters"
                                    : null),
                            const SizedBox(
                              height: 28,
                            ),
                            RaisedButton(
                                elevation: 1,
                                color: Theme.of(context).primaryColor,
                                textColor: Colors.white,
                                onPressed: () => _submitForm(
                                      context,
                                      state.status == LoginStatus.submitting,
                                    ),
                                child: Text("Log in")),
                            const SizedBox(
                              height: 12,
                            ),
                            RaisedButton(
                                elevation: 1,
                                color: Colors.grey[200],
                                textColor: Colors.black,
                                onPressed: () => Navigator.of(context)
                                    .pushNamed(SignupScreen.routeName),
                                child: Text("No Account? Sign up"))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _submitForm(BuildContext context, bool isSubmitting) {
    if (_formKey.currentState.validate() && !isSubmitting) {
      context.read<LoginCubit>().loginWithCredential();
    }
  }
}
