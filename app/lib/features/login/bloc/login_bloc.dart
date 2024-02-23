import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../../core/domain/repositories/auth_repository.dart';
import '../../../injector/injector.dart';
import '../../../services/log_service/log_service.dart';
import '../../device_management/bloc/device_management_bloc.dart';
import '../models/login_form_validation_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(
      {required AuthRepository authenticationRepository,
      required LogService logService})
      : _authenticationRepository = authenticationRepository,
        super(LogInIdleState()) {
    on<LogInRequestEvent>(_onSubmitted);
  }
  final AuthRepository _authenticationRepository;

  void _onSubmitted(
    LogInRequestEvent event,
    Emitter<LoginState> emit,
  ) async {
    final loginRequestModel =
        LoginRequestModel(email: event.email, password: event.password);
    final loginValidationReponseModel = loginRequestModel.validate();
    if (loginValidationReponseModel != null) {
      emit(LogInFormValidationErrorState(loginValidationReponseModel));
      return;
    }

    emit(LoggingInState());
    var response = await _authenticationRepository.loginUser(loginRequestModel);
    response.when(success: (loginResponse) {
      _registerDevice();
      emit(LoggedInState());
    }, error: (error) {
      emit(LoginApiErrorState(error.toMessage()));
    });
  }

  _registerDevice() {
    Injector.instance<DeviceManagementBloc>().add(RegisterDeviceEvent());
  }
}
