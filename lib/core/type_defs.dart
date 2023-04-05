import 'package:fpdart/fpdart.dart';
import 'core.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureEitherVoid = Future<void>;
// typedef FutureVoid = Future<void>;
