part of 'create_booking_bloc.dart';

class CreateBookingState extends Equatable {
  const CreateBookingState({
    this.currentStep = 0,
    required this.post,
    this.tempSelectedTime = const [],
    this.freetimes = const [],
    this.selectedTime = const [],
    this.phoneNumber = const PhoneNumber.pure(),
    this.formzStatus = FormzStatus.pure,
    this.pageLoadingStatus = LoadingStatus.initial,
  });

  final int currentStep;
  final Post post;
  final List<AppointmentInfo> freetimes;
  final PhoneNumber phoneNumber;
  final List<AppointmentInfo> tempSelectedTime;
  final List<AppointmentInfo> selectedTime;
  final FormzStatus formzStatus;
  final LoadingStatus pageLoadingStatus;

  @override
  List<Object?> get props {
    return [
      currentStep,
      post,
      freetimes,
      phoneNumber,
      tempSelectedTime,
      selectedTime,
      formzStatus,
      pageLoadingStatus,
    ];
  }

  CreateBookingState copyWith({
    int? currentStep,
    Post? post,
    List<AppointmentInfo>? freetimes,
    PhoneNumber? phoneNumber,
    List<AppointmentInfo>? tempSelectedTime,
    List<AppointmentInfo>? selectedTime,
    FormzStatus? formzStatus,
    LoadingStatus? pageLoadingStatus,
  }) {
    return CreateBookingState(
      currentStep: currentStep ?? this.currentStep,
      post: post ?? this.post,
      freetimes: freetimes ?? this.freetimes,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      tempSelectedTime: tempSelectedTime ?? this.tempSelectedTime,
      selectedTime: selectedTime ?? this.selectedTime,
      formzStatus: formzStatus ?? this.formzStatus,
      pageLoadingStatus: pageLoadingStatus ?? this.pageLoadingStatus,
    );
  }
}
