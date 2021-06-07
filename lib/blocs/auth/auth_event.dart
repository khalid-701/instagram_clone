part of 'auth_bloc.dart';
//2
@immutable class AuthEvent extends Equatable {
  @override
  // TODO: implement stringify
  bool get stringify => true;

  @override
  List<Object> get props => throw UnimplementedError();
}


class AuthUserChanged extends AuthEvent {}