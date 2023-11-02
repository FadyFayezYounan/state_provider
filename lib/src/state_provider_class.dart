typedef LoadingCallback<W> = W Function();
typedef SuccessCallback<W, S> = W Function(S success);
typedef ErrorCallback<W, E> = W Function(E error);

/// Base StateProvider class
///
/// Receives two values  [S] and [E]
/// as [E] is an error and [S] is a success.
sealed class StateProvider<S, E> {
  /// Default constructor.
  const StateProvider();

  /// Build a [StateProvider] that returns a [LoadingState].
  const factory StateProvider.loading() = LoadingState;

  /// Build a [StateProvider] that returns a [ErrorState].
  const factory StateProvider.error(E error) = ErrorState;

  /// Build a [StateProvider] that returns a [SuccessState].
  const factory StateProvider.success([S? success]) = SuccessState;

  /// Returns true if the current state is a [LoadingState].
  bool isLoading();

  /// Returns true if the current state is an [ErrorState].
  bool isError();

  /// Returns true if the current state is a [SuccessState].
  bool isSuccess();

  /// Handle the state when loading, success or error
  ///
  /// if the state is an loading, it will be returned in [whenLoading]
  /// if the state is an error, it will be returned in [whenError]
  /// if it is a success it will be returned in [whenSuccess]
  W when<W>(
    LoadingCallback whenLoading,
    ErrorCallback whenError,
    SuccessCallback whenSuccess,
  );

  /// Execute [whenLoading] if the [StateProvider] is a loading.
  R? whenLoading<R>(
    R Function() whenLoading,
  );

  /// Execute [whenSuccess] if the [StateProvider] is a success.
  R? whenSuccess<R>(
    R Function([S? success]) whenSuccess,
  );

  /// Execute [whenError] if the [StateProvider] is an error.
  R? whenError<R>(
    R Function(E error) whenError,
  );
}

final class LoadingState<S, E> extends StateProvider<S, E> {
  const LoadingState();

  @override
  W when<W>(
    LoadingCallback whenLoading,
    ErrorCallback whenError,
    SuccessCallback whenSuccess,
  ) =>
      whenLoading();

  @override
  bool isError() => false;

  @override
  bool isLoading() => true;

  @override
  bool isSuccess() => false;

  @override
  R? whenError<R>(R Function(E error) whenError) => null;

  @override
  R? whenLoading<R>(R Function() whenLoading) => whenLoading();

  @override
  R? whenSuccess<R>(R Function([S? success]) whenSuccess) => null;
}

final class SuccessState<S, E> extends StateProvider<S, E> {
  const SuccessState([this._success]);

  /// Receives the [S] param as
  /// the successful state.
  final S? _success;

  /// Success value
  S? get success => _success;

  @override
  W when<W>(
    LoadingCallback whenLoading,
    ErrorCallback whenError,
    SuccessCallback whenSuccess,
  ) =>
      whenSuccess(_success);
  @override
  int get hashCode => _success.hashCode;

  @override
  bool operator ==(Object other) =>
      other is SuccessState && other._success == _success;

  @override
  bool isError() => false;

  @override
  bool isLoading() => false;

  @override
  bool isSuccess() => true;

  @override
  R? whenError<R>(R Function(E error) whenError) => null;

  @override
  R? whenLoading<R>(R Function() whenLoading) => null;

  @override
  R? whenSuccess<R>(R Function([S? success]) whenSuccess) =>
      whenSuccess(_success);
}

final class ErrorState<S, E> extends StateProvider<S, E> {
  const ErrorState(this._error);

  /// Receives the [E] param as
  /// the error state.
  final E _error;

  /// Error value
  E get error => _error;

  @override
  W when<W>(
    LoadingCallback whenLoading,
    ErrorCallback whenError,
    SuccessCallback whenSuccess,
  ) =>
      whenError(_error);

  @override
  int get hashCode => _error.hashCode;

  @override
  bool operator ==(Object other) =>
      other is ErrorState && other._error == _error;

  @override
  bool isError() => true;

  @override
  bool isLoading() => false;

  @override
  bool isSuccess() => false;

  @override
  R? whenError<R>(R Function(E error) whenError) => whenError(_error);

  @override
  R? whenLoading<R>(R Function() whenLoading) => null;

  @override
  R? whenSuccess<R>(R Function([S? success]) whenSuccess) => null;
}
