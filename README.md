# state_provider

Flutter package designed to simplify API request management by offering seamless handling of loading, success, and error states. Integrated with Provider, it efficiently manages and notifies the application of the various states during API requests, enhancing the development experience for Flutter developers.

## How To Use `StateProvider`

Import the following package in your dart file

```dart
import 'package:state_provider/state_provider.dart';
```

## Usage with when

```dart
state = StateProvider.loading();

state.when(
    // When the state is loading
    () => CircularProgressIndicator(),
    (error) {
     return ErrorWidget(error);
    },
     (success) {
        return SuccessWidget(success);
    },
  ),
```

## Usage with switch

```dart
state = StateProvider.loading();

  switch (state) {
    case LoadingState():
      return CircularProgressIndicator();
    case ErrorState():
     return ErrorWidget(state.error);
    case SuccessState():
      return SuccessWidget(state.success);
  }
``

// OR
 return switch (state) {
     LoadingState()=>
       CircularProgressIndicator(),
     ErrorState()=> ErrorWidget(state.error),
     SuccessState()=> SuccessWidget(state.success),
  };
```
