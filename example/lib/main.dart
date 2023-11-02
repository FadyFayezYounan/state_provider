import 'package:flutter_state_provider/state_provider.dart';

void main() {
  final StateProvider<String, Exception> currentState = StateProvider.loading();
  _handleStateProviderInSwitch(currentState);
  _handleResultInWhen(currentState);
  _handleStateProviderInSwitchExample2(currentState);
}

void _handleStateProviderInSwitch(StateProvider<String, Exception> state) {
  switch (state) {
    case LoadingState():
      print("loading state...");
    case ErrorState():
      print("error state ${state.error}...");
    case SuccessState():
      print("success state ${state.success}...");
  }
}

void _handleStateProviderInSwitchExample2(
    StateProvider<String, Exception> state) {
  return switch (state) {
    LoadingState() => print("loading state..."),
    ErrorState() => print("error state ${state.error}..."),
    SuccessState() => print("success state ${state.success}..."),
  };
}

void _handleResultInWhen(StateProvider<String, Exception> result) {
  result.when(
    () => print("loading state..."),
    (error) {
      print("success state ${error}...");
    },
    (success) {
      print("success state ${success}...");
    },
  );
}
