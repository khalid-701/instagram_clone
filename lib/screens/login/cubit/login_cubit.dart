import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram_clone/models/failure_models.dart';
import 'package:instagram_clone/repositories/auth/auth_repository.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit({@required AuthRepository authRepository})
      : _authRepository= authRepository,
        super(LoginState.initial());

  void emailChange(String value) {
    emit(state.copyWith(email: value, status: LoginStatus.initial));
  }

  void passwordChange(String value) {
    emit(state.copyWith(password: value, status: LoginStatus.initial));
  }

  void loginWithCredential() async {
    if (!state.isFormValid ||
        state.status == LoginStatus.submitting) return;
    emit(state.copyWith(status: LoginStatus.submitting));
    try {
      //_authRepository.loginWithEmailnPasswrod
      await _authRepository.loginWithEmailAndPassword(
          email: state.email, password: state.password);

      emit(state.copyWith(status: LoginStatus.success));
    } on Failure catch (err) {
      emit(state.copyWith(failure: err, status: LoginStatus.error));
    }
  }
}
