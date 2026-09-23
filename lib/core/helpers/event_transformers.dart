import 'package:flutter_bloc/flutter_bloc.dart';

EventTransformer<E> sequential<E>() =>
    (events, mapper) => events.asyncExpand(mapper);
