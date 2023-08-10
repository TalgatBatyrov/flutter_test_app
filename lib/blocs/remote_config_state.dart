part of 'remote_config_cubit.dart';

abstract class RemoteConfigState extends Equatable {
  const RemoteConfigState();

  @override
  List<Object> get props => [];
}

class RemoteConfigLoading extends RemoteConfigState {}

class RemoteConfigSportNews extends RemoteConfigState {}

class RemoteConfigLoaded extends RemoteConfigState {
  final String url;

  const RemoteConfigLoaded({required this.url});

  @override
  List<Object> get props => [url];
}

class RemoteConfigError extends RemoteConfigState {
  final String error;

  const RemoteConfigError({required this.error});

  @override
  List<Object> get props => [error];
}
