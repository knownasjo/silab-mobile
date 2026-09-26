import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silab/core/helpers/event_transformers.dart';
import 'package:silab/features/user_details/domain/entities/user_detail/user_detail_entity.dart';
import 'package:silab/features/user_details/domain/usecases/get_user_details_usecase.dart';

part 'user_details_event.dart';
part 'user_details_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  final GetUserDetailsUseCase _getUserDetailsUseCase;

  UserDetailsBloc(this._getUserDetailsUseCase) : super(UserDetailInitial()) {
    on<GetUserDetails>(onProfilePageOpened);
    on<RefreshUserDetails>(onRefreshUserDetails, transformer: sequential());
  }

  Future<void> onRefreshUserDetails(
    RefreshUserDetails event,
    Emitter<UserDetailsState> emit,
  ) async {
    if (state is! UserDetailLoaded) return;

    final data = await _getUserDetailsUseCase.userRepository.getUserDetails();

    data.fold(
      (_) {},
      (right) => emit(UserDetailLoaded(userDetailEntity: right.data)),
    );
  }

  void onProfilePageOpened(
    UserDetailsEvent event,
    Emitter<UserDetailsState> emit,
  ) async {
    emit(UserDetailLoading());

    final data = await _getUserDetailsUseCase.userRepository.getUserDetails();

    data.fold(
      (left) => emit(UserDetailFailed(message: left.message)),
      (right) => emit(UserDetailLoaded(userDetailEntity: data.right.data)),
    );
  }
}
