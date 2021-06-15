import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/models/failure_models.dart';
import 'package:instagram_clone/repositories/auth/auth_repository.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthRepository _authRepository;

  SignupCubit({@required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(SignupState.initial());

  void usernameChange(String value) {
    emit(state.copyWith(username: value, status: SignupStatus.initial));
  }

  void emailChange(String value) {
    emit(state.copyWith(email: value, status: SignupStatus.initial));
  }

  void passwordChange(String value) {
    emit(state.copyWith(password: value, status: SignupStatus.initial));
  }

  void signUpWithCredential() async {
    if (!state.isFormValid || state.status == SignupStatus.submitting) return;
    emit(state.copyWith(status: SignupStatus.submitting));
    try {
      //_authRepository.SignupWithEmailnPasswrod
      await _authRepository.signUpWithEmailAndPassword(
          email: state.email, password: state.password, username: state.username);

      emit(state.copyWith(status: SignupStatus.success));
    } on Failure catch (err) {
      emit(state.copyWith(failure: err, status: SignupStatus.error));
    }
  }
}
