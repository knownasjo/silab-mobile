import 'package:get_it/get_it.dart';
import 'package:silab/core/network/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silab/features/announcement/data/data_sources/announcement_api_service.dart';
import 'package:silab/features/announcement/data/repository/announcement_repository_impl.dart';
import 'package:silab/features/announcement/domain/repository/announcement_repository.dart';
import 'package:silab/features/announcement/domain/usecases/get_all_announcements_usecase.dart';
import 'package:silab/features/announcement/domain/usecases/get_announcement_usecase.dart';
import 'package:silab/features/announcement/presentation/blocs/get_all_announcements/get_all_announcements_bloc.dart';
import 'package:silab/features/announcement/presentation/blocs/get_announcement/get_announcement_bloc.dart';
import 'package:silab/features/authentication/data/data_sources/local/authentication_local_datasource.dart';
import 'package:silab/features/authentication/data/data_sources/remote/authentication_api_service.dart';
import 'package:silab/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:silab/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:silab/features/authentication/domain/usecases/get_session_expiry.dart';
import 'package:silab/features/authentication/domain/usecases/get_user_access_token_usecase.dart';
import 'package:silab/features/authentication/domain/usecases/user_login_usecase.dart';
import 'package:silab/features/authentication/domain/usecases/user_logout_usecase.dart';
import 'package:silab/features/authentication/domain/usecases/watch_session_ended_usecase.dart';
import 'package:silab/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:silab/features/classes/data/data_sources/classes_api_service.dart';
import 'package:silab/features/classes/data/repository/class_repository_impl.dart';
import 'package:silab/features/classes/domain/repository/class_repository.dart';
import 'package:silab/features/classes/domain/usecases/add_user_attendances_usecase.dart';
import 'package:silab/features/classes/domain/usecases/get_classmates_usecase.dart';
import 'package:silab/features/classes/domain/usecases/get_user_meetings_data_usecase.dart';
import 'package:silab/features/classes/domain/usecases/get_user_registered_classes_usecase.dart';
import 'package:silab/features/classes/presentation/bloc/user_attendances/user_attendances_bloc.dart';
import 'package:silab/features/classes/presentation/bloc/classmates/classmates_bloc.dart';
import 'package:silab/features/classes/presentation/bloc/user_meetings/user_meetings_bloc.dart';
import 'package:silab/features/classes/presentation/bloc/user_registered_class/user_registered_class_bloc.dart';
import 'package:silab/features/schedule/data/data_sources/schedule_api_service.dart';
import 'package:silab/features/schedule/data/repository/schedule_repository_impl.dart';
import 'package:silab/features/schedule/domain/repository/schedule_repository.dart';
import 'package:silab/features/schedule/domain/usecases/get_user_schedule_usecase.dart';
import 'package:silab/features/schedule/presentation/bloc/user_schedule_bloc.dart';
import 'package:silab/features/select_subjects/data/data_sources/selected_subject_api_service.dart';
import 'package:silab/features/select_subjects/data/repository/selected_subject_repository_impl.dart';
import 'package:silab/features/select_subjects/domain/repository/selected_subject_repository.dart';
import 'package:silab/features/select_subjects/domain/usecases/add_selected_class_usecase.dart';
import 'package:silab/features/select_subjects/domain/usecases/add_user_selected_subject_usecase.dart';
import 'package:silab/features/select_subjects/domain/usecases/get_user_class_option_by_paid_subject_usecase.dart';
import 'package:silab/features/select_subjects/domain/usecases/get_user_selected_subject_usecase.dart';
import 'package:silab/features/select_subjects/presentation/bloc/add_selected_class/add_selected_class_bloc.dart';
import 'package:silab/features/select_subjects/presentation/bloc/add_selected_subject/add_selected_subject_bloc.dart';
import 'package:silab/features/select_subjects/presentation/bloc/selected_subject_by_nim/selected_subject_by_nim_bloc.dart';
import 'package:silab/features/select_subjects/presentation/bloc/user_class_option_by_paid_subject/user_class_option_by_paid_subject_bloc.dart';
import 'package:silab/features/subjects/data/data_sources/subject_api_service.dart';
import 'package:silab/features/subjects/data/repository/subject_repository_impl.dart';
import 'package:silab/features/subjects/domain/repository/subject_repository.dart';
import 'package:silab/features/subjects/domain/usecases/get_subject_details_usecase.dart';
import 'package:silab/features/subjects/domain/usecases/get_subject_list_usecase.dart';
import 'package:silab/features/subjects/presentation/bloc/subject_details/subject_details_bloc.dart';
import 'package:silab/features/subjects/presentation/bloc/subject_list/subject_list_bloc.dart';
import 'package:silab/features/user_details/data/data_sources/user_api_service.dart';
import 'package:silab/features/user_details/data/repositories/user_repository_impl.dart';
import 'package:silab/features/user_details/domain/repositories/user_repository.dart';
import 'package:silab/features/user_details/domain/usecases/get_user_details_usecase.dart';
import 'package:silab/features/user_details/presentation/bloc/user_details_bloc.dart';
import 'package:silab/features/realtime/data/data_sources/realtime_api_service.dart';
import 'package:silab/features/realtime/data/repository/realtime_repository_impl.dart';
import 'package:silab/features/realtime/domain/repository/realtime_repository.dart';
import 'package:silab/features/realtime/domain/usecases/watch_realtime_events_usecase.dart';
import 'package:silab/features/realtime/presentation/bloc/realtime_bloc.dart';
import 'package:silab/features/registration/data/data_sources/registration_api_service.dart';
import 'package:silab/features/registration/data/repository/registration_repository_impl.dart';
import 'package:silab/features/registration/domain/repository/registration_repository.dart';
import 'package:silab/features/registration/domain/usecases/register_usecase.dart';
import 'package:silab/features/registration/domain/usecases/resend_registration_code_usecase.dart';
import 'package:silab/features/registration/domain/usecases/verify_registration_usecase.dart';
import 'package:silab/features/registration/presentation/bloc/registration/registration_bloc.dart';
import 'package:silab/features/registration/presentation/bloc/registration_verification/registration_verification_bloc.dart';
import 'package:silab/features/user_details/domain/usecases/get_assisted_classes_usecase.dart';
import 'package:silab/features/user_details/presentation/bloc/assisted_classes/assisted_classes_bloc.dart';
import 'package:silab/features/password_reset/data/data_sources/password_reset_api_service.dart';
import 'package:silab/features/password_reset/data/repository/password_reset_repository_impl.dart';
import 'package:silab/features/password_reset/domain/repository/password_reset_repository.dart';
import 'package:silab/features/password_reset/domain/usecases/request_password_reset_code_usecase.dart';
import 'package:silab/features/password_reset/domain/usecases/reset_password_usecase.dart';
import 'package:silab/features/password_reset/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:silab/features/password_reset/presentation/bloc/reset_password/reset_password_bloc.dart';
import 'package:http/http.dart' as http;

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  injector.registerSingleton<http.Client>(http.Client());

  injector.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());

  injector.registerSingleton<ApiClient>(ApiClient(injector(), injector()));

  injector.registerSingleton<AuthenticationApiService>(
      AuthenticationApiService(injector()));
  injector.registerSingleton<AuthenticationLocalDataSource>(
      AuthenticationLocalDataSource(injector()));
  injector.registerSingleton<UserApiService>(UserApiService(injector()));
  injector.registerSingleton<SelectedSubjectApiService>(
      SelectedSubjectApiService(injector()));
  injector.registerSingleton<ClassesApiService>(ClassesApiService(injector()));
  injector.registerSingleton<SubjectApiService>(SubjectApiService(injector()));
  injector.registerSingleton<AnnouncementApiService>(
      AnnouncementApiService(injector()));
  injector
      .registerSingleton<ScheduleApiService>(ScheduleApiService(injector()));
  injector
      .registerSingleton<RealtimeApiService>(RealtimeApiService(injector()));
  injector.registerSingleton<RegistrationApiService>(
      RegistrationApiService(injector()));
  injector.registerSingleton<PasswordResetApiService>(
      PasswordResetApiService(injector()));

  injector.registerSingleton<AuthenticationRepository>(
      AuthenticationRepositoryImpl(injector(), injector()));
  injector.registerSingleton<UserRepository>(UserRepositoryImpl(injector()));
  injector.registerSingleton<SelectedSubjectRepository>(
      SelectedSubjectRepositoryImpl(injector()));
  injector.registerSingleton<ClassRepository>(ClassRepositoryImpl(injector()));
  injector
      .registerSingleton<SubjectRepository>(SubjectRepositoryImpl(injector()));
  injector.registerSingleton<AnnouncementRepository>(
      AnnouncementRepositoryImpl(injector()));
  injector.registerSingleton<ScheduleRepository>(
      ScheduleRepositoryImpl(injector()));
  injector.registerSingleton<RealtimeRepository>(
      RealtimeRepositoryImpl(injector()));
  injector.registerSingleton<RegistrationRepository>(
      RegistrationRepositoryImpl(injector(), injector()));
  injector.registerSingleton<PasswordResetRepository>(
      PasswordResetRepositoryImpl(injector()));

  injector.registerSingleton<UserLoginUsecase>(UserLoginUsecase(injector()));
  injector.registerSingleton<GetUserAccessTokenUsecase>(
      GetUserAccessTokenUsecase(injector()));
  injector.registerSingleton<GetSessionExpiry>(GetSessionExpiry(injector()));
  injector.registerSingleton<UserLogoutUsecase>(UserLogoutUsecase(injector()));
  injector.registerSingleton<WatchSessionEndedUsecase>(
      WatchSessionEndedUsecase(injector()));
  injector.registerSingleton<GetUserDetailsUseCase>(
      GetUserDetailsUseCase(injector()));
  injector.registerSingleton<GetAssistedClassesUsecase>(
      GetAssistedClassesUsecase(injector()));
  injector.registerSingleton<GetSelectedSubjectByNimUsecase>(
      GetSelectedSubjectByNimUsecase(injector()));
  injector.registerSingleton<GetSubjectDetailsUseCase>(
      GetSubjectDetailsUseCase(injector()));
  injector.registerSingleton<GetSubjectListUseCase>(
      GetSubjectListUseCase(injector()));
  injector.registerSingleton<AddSelectedSubjectUseCase>(
      AddSelectedSubjectUseCase(injector()));
  injector.registerSingleton<GetAllAnnouncementsUseCase>(
      GetAllAnnouncementsUseCase(injector()));
  injector.registerSingleton<GetAnnouncementUseCase>(
      GetAnnouncementUseCase(injector()));
  injector.registerSingleton<AddSelectedClassUseCase>(
      AddSelectedClassUseCase(injector()));
  injector.registerSingleton<GetUserRegisteredClassesUseCase>(
      GetUserRegisteredClassesUseCase(injector()));
  injector.registerSingleton<GetUserClassOptionByPaidSubjectUsecase>(
      GetUserClassOptionByPaidSubjectUsecase(injector()));
  injector.registerSingleton<GetUserMeetingsDataUsecase>(
      GetUserMeetingsDataUsecase(injector()));
  injector.registerSingleton<GetClassmatesUsecase>(
      GetClassmatesUsecase(injector()));
  injector.registerSingleton<AddUserAttendancesUsecase>(
      AddUserAttendancesUsecase(injector()));
  injector.registerSingleton<GetUserScheduleUsecase>(
      GetUserScheduleUsecase(injector()));
  injector.registerSingleton<WatchRealtimeEventsUsecase>(
      WatchRealtimeEventsUsecase(injector()));
  injector.registerSingleton<RegisterUsecase>(RegisterUsecase(injector()));
  injector.registerSingleton<VerifyRegistrationUsecase>(
      VerifyRegistrationUsecase(injector()));
  injector.registerSingleton<ResendRegistrationCodeUsecase>(
      ResendRegistrationCodeUsecase(injector()));
  injector.registerSingleton<RequestPasswordResetCodeUsecase>(
      RequestPasswordResetCodeUsecase(injector()));
  injector.registerSingleton<ResetPasswordUsecase>(
      ResetPasswordUsecase(injector()));

  injector.registerFactory<AuthenticationBloc>(() => AuthenticationBloc(
      injector(), injector(), injector(), injector(), injector()));
  injector.registerFactory<UserDetailsBloc>(
      () => UserDetailsBloc(injector(), injector()));
  injector.registerFactory<AssistedClassesBloc>(
      () => AssistedClassesBloc(injector()));
  injector.registerFactory<SelectedSubjectByNimBloc>(
      () => SelectedSubjectByNimBloc(injector()));
  injector.registerFactory<SubjectDetailsBloc>(
      () => SubjectDetailsBloc(injector()));
  injector.registerFactory<SubjectListBloc>(() => SubjectListBloc(injector()));
  injector.registerFactory<AddSelectedSubjectBloc>(
      () => AddSelectedSubjectBloc(injector()));
  injector.registerFactory<GetAnnouncementBloc>(
      () => GetAnnouncementBloc(injector()));
  injector.registerFactory<GetAllAnnouncementsBloc>(
      () => GetAllAnnouncementsBloc(injector()));
  injector.registerFactory<AddSelectedClassBloc>(
      () => AddSelectedClassBloc(injector()));
  injector.registerFactory<UserRegisteredClassBloc>(
      () => UserRegisteredClassBloc(injector()));
  injector.registerFactory<UserClassOptionByPaidSubjectBloc>(
      () => UserClassOptionByPaidSubjectBloc(injector()));
  injector
      .registerFactory<UserMeetingsBloc>(() => UserMeetingsBloc(injector()));
  injector.registerFactory<ClassmatesBloc>(() => ClassmatesBloc(injector()));
  injector.registerFactory<UserAttendancesBloc>(
      () => UserAttendancesBloc(injector()));
  injector
      .registerFactory<UserScheduleBloc>(() => UserScheduleBloc(injector()));
  injector.registerFactory<RealtimeBloc>(() => RealtimeBloc(injector()));
  injector
      .registerFactory<RegistrationBloc>(() => RegistrationBloc(injector()));
  injector.registerFactory<RegistrationVerificationBloc>(
      () => RegistrationVerificationBloc(injector(), injector()));
  injector.registerFactory<ForgotPasswordBloc>(
      () => ForgotPasswordBloc(injector()));
  injector.registerFactory<ResetPasswordBloc>(
      () => ResetPasswordBloc(injector(), injector()));
}
