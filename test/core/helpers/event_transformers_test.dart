import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:silab/core/helpers/event_transformers.dart';

class Refresh extends Equatable {
  final String key;

  const Refresh(this.key);

  @override
  List<Object?> get props => [key];
}

class RefreshBloc extends Bloc<Refresh, int> {
  final List<String> started = [];
  final List<Completer<void>> gates = [];

  RefreshBloc() : super(0) {
    on<Refresh>((event, emit) async {
      started.add(event.key);
      final gate = Completer<void>();
      gates.add(gate);
      await gate.future;
      emit(state + 1);
    }, transformer: coalesced());
  }

  void finishCurrent() => gates.last.complete();
}

Future<void> settle() => Future<void>.delayed(const Duration(milliseconds: 10));

void main() {
  late RefreshBloc bloc;

  setUp(() => bloc = RefreshBloc());

  tearDown(() async {
    for (final gate in bloc.gates) {
      if (!gate.isCompleted) gate.complete();
    }
    await bloc.close();
  });

  test('event sama yang datang selagi berjalan digabung jadi satu susulan',
      () async {
    for (var i = 0; i < 5; i++) {
      bloc.add(const Refresh('kelas'));
    }
    await settle();
    expect(bloc.started, ['kelas']);

    bloc.finishCurrent();
    await settle();
    expect(bloc.started, ['kelas', 'kelas']);

    bloc.finishCurrent();
    await settle();
    expect(bloc.started, ['kelas', 'kelas']);
    expect(bloc.state, 2);
  });

  test('event berbeda tetap dijalankan satu per satu sesuai urutan', () async {
    bloc
      ..add(const Refresh('a'))
      ..add(const Refresh('b'))
      ..add(const Refresh('a'))
      ..add(const Refresh('b'));
    await settle();
    expect(bloc.started, ['a']);

    for (var i = 0; i < 3; i++) {
      bloc.finishCurrent();
      await settle();
    }
    expect(bloc.started, ['a', 'b', 'a']);
  });

  test('setelah selesai, event berikutnya dijalankan lagi', () async {
    bloc.add(const Refresh('a'));
    await settle();
    bloc.finishCurrent();
    await settle();

    bloc.add(const Refresh('a'));
    await settle();
    expect(bloc.started, ['a', 'a']);
  });

  test('bloc ditutup: antrean dibuang tanpa error', () async {
    bloc
      ..add(const Refresh('a'))
      ..add(const Refresh('a'));
    await settle();

    await bloc.close();
    bloc.finishCurrent();
    await settle();

    expect(bloc.started, ['a']);
  });
}
