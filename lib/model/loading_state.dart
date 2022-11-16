abstract class LoadingState {
  const LoadingState();
}

class LoadingInProgress extends LoadingState {}

class LoadingSuccess extends LoadingState {}

class LoadingFailure extends LoadingState {}
