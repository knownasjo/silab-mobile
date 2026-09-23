import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:silab/features/authentication/data/models/login_model.dart';
import 'package:silab/features/authentication/domain/entities/login_data/login_data_entity.dart';
import 'package:silab/features/authentication/domain/usecases/get_session_expiry.dart';
import 'package:silab/features/authentication/domain/usecases/get_user_access_token_usecase.dart';
import 'package:silab/features/authentication/domain/usecases/user_login_usecase.dart';
import 'package:silab/features/authentication/domain/usecases/user_logout_usecase.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserLoginUsecase _userLoginUsecase;
  final GetUserAccessTokenUsecase _getUserAccessTokenUsecase;
  final GetSessionExpiry _getSessionExpiry;
  final UserLogoutUsecase _userLogoutUsecase;

  AuthenticationBloc(
    this._userLoginUsecase,
    this._getUserAccessTokenUsecase,
    this._getSessionExpiry,
    this._userLogoutUsecase,
  ) : super(AuthenticationInitial()) {
    on<UserLogin>(onUserLogin);
    on<AppOpened>(onAppOpened);
    on<CheckSessionExpiry>(onCheckSessionExpiry);
    on<UserLogout>(onUserLogout);
  }

  void onUserLogout(
    AuthenticationEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    await _userLogoutUsecase();
    emit(UserLoggedOut());
  }

  void onUserLogin(
    AuthenticationEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticationLoading());
    final data = await _userLoginUsecase.authenticationRepository
        .userLogin(loginData: event.loginData);

    data.fold(
      (left) => emit(AuthenticationFailed(message: left.message)),
      (right) => emit(AuthenticationSuccess(data: right.data)),
    );
  }

  void onAppOpened(
    AuthenticationEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    final data = _getUserAccessTokenUsecase.authenticationRepository
        .getUserAccessToken();

    data.fold(
      (left) => emit(AuthenticationInitial()),
      (right) => emit(const AuthenticationSuccess()),
    );
  }

  void onCheckSessionExpiry(
    AuthenticationEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    final expiryResult =
        _getSessionExpiry.authenticationRepository.getSessionExpiry();

    expiryResult.fold(
      (left) {
        emit(const AuthenticationFailed(message: 'JWT Expired'));
      },
      (right) {
        final expiryTime = DateTime.fromMillisecondsSinceEpoch(right * 1000);
        if (expiryTime.isBefore(DateTime.now())) {
          emit(SessionExpired());
        } else {
          emit(const AuthenticationSuccess());
        }
      },
    );
  }
}
