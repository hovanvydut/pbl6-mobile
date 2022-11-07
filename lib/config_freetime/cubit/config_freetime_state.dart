
part of 'config_freetime_cubit.dart';

class ConfigFreetimeState extends Equatable {
  const ConfigFreetimeState({
    required this.user,
    required this.freetimes,
    this.saveLoadingStatus = LoadingStatus.initial,
    this.isEditing = false,
  });

  final User user;

  final LoadingStatus saveLoadingStatus;

  final List<Freetime> freetimes;

  final bool isEditing;

  @override
  List<Object> get props => [user, saveLoadingStatus, freetimes, isEditing];

  ConfigFreetimeState copyWith({
    User? user,
    LoadingStatus? saveLoadingStatus,
    List<Freetime>? freetimes,
    bool? isEditing,
  }) {
    return ConfigFreetimeState(
      user: user ?? this.user,
      saveLoadingStatus: saveLoadingStatus ?? this.saveLoadingStatus,
      freetimes: freetimes ?? this.freetimes,
      isEditing: isEditing ?? this.isEditing,
    );
  }
}
