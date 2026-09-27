import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

EventTransformer<E> coalesced<E>() => (events, mapper) {
      final pending = <E>{};
      final controller = StreamController<E>();
      StreamSubscription<E>? source;
      var running = false;
      var sourceDone = false;
      var cancelled = false;

      Future<void> runPending() async {
        running = true;
        while (pending.isNotEmpty && !cancelled) {
          final event = pending.first;
          pending.remove(event);
          await for (final output in mapper(event)) {
            controller.add(output);
          }
        }
        running = false;
        if (sourceDone) await controller.close();
      }

      controller
        ..onListen = () {
          source = events.listen(
            (event) {
              pending.add(event);
              if (!running) runPending();
            },
            onError: controller.addError,
            onDone: () {
              sourceDone = true;
              if (!running) controller.close();
            },
          );
        }
        ..onCancel = () {
          cancelled = true;
          return source?.cancel();
        };

      return controller.stream;
    };
