import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:silab/core/helpers/event_transformers.dart';
import 'package:silab/features/announcement/domain/entities/announcement/announcement_entity.dart';
import 'package:silab/features/announcement/domain/usecases/get_announcement_usecase.dart';

part 'get_announcement_event.dart';
part 'get_announcement_state.dart';

class GetAnnouncementBloc
    extends Bloc<GetAnnouncementEvent, GetAnnouncementState> {
  final GetAnnouncementUseCase _getAnnouncementUseCase;

  String? _requestedId;

  GetAnnouncementBloc(this._getAnnouncementUseCase)
    : super(GetAnnouncementInitial()) {
    on<GetAnnouncement>(onGetAnnouncement);
    on<RefreshAnnouncement>(onRefreshAnnouncement, transformer: coalesced());
    on<RetryAnnouncement>(onRetryAnnouncement, transformer: coalesced());
  }

  void onGetAnnouncement(
    GetAnnouncementEvent event,
    Emitter<GetAnnouncementState> emit,
  ) async {
    if (event.id != null) {
      _requestedId = event.id;
      emit(GetAnnouncementLoading());

      final data = await _getAnnouncementUseCase.announcementRepository
          .getAnnouncement(id: event.id!);

      if (_requestedId != event.id) return;

      data.fold(
        (left) => emit(GetAnnouncementFailed(message: left.message)),
        (right) => emit(GetAnnouncementLoaded(announcement: right)),
      );
    } else {
      emit(const GetAnnouncementFailed(message: 'An Error Occured'));
    }
  }

  Future<void> onRefreshAnnouncement(
    RefreshAnnouncement event,
    Emitter<GetAnnouncementState> emit,
  ) async {
    final current = state;
    if (current is! GetAnnouncementLoaded ||
        current.announcement?.id != event.id) {
      return;
    }

    if (event.isDeleted) {
      emit(
        const GetAnnouncementDeleted(message: 'Pengumuman ini sudah dihapus.'),
      );
      return;
    }

    final data = await _getAnnouncementUseCase.announcementRepository
        .getAnnouncement(id: event.id!);

    if (state != current) return;

    data.fold(
      (left) => null,
      (right) => emit(GetAnnouncementLoaded(announcement: right)),
    );
  }

  Future<void> onRetryAnnouncement(
    RetryAnnouncement event,
    Emitter<GetAnnouncementState> emit,
  ) async {
    final current = state;
    final id = _requestedId;
    if (current is! GetAnnouncementFailed || id == null) return;

    final data = await _getAnnouncementUseCase.announcementRepository
        .getAnnouncement(id: id);

    if (state != current || _requestedId != id) return;

    data.fold(
      (left) => null,
      (right) => emit(GetAnnouncementLoaded(announcement: right)),
    );
  }
}
