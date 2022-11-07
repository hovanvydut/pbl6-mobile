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
  });

  final int currentStep;
  final Post post;
  final List<Freetime> freetimes;
  final PhoneNumber phoneNumber;
  final List<Freetime> tempSelectedTime;
  final List<Freetime> selectedTime;
  final FormzStatus formzStatus;

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
    ];
  }

  CreateBookingState copyWith({
    int? currentStep,
    Post? post,
    List<Freetime>? freetimes,
    PhoneNumber? phoneNumber,
    List<Freetime>? tempSelectedTime,
    List<Freetime>? selectedTime,
    FormzStatus? formzStatus,
  }) {
    return CreateBookingState(
      currentStep: currentStep ?? this.currentStep,
      post: post ?? this.post,
      freetimes: freetimes ?? this.freetimes,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      tempSelectedTime: tempSelectedTime ?? this.tempSelectedTime,
      selectedTime: selectedTime ?? this.selectedTime,
      formzStatus: formzStatus ?? this.formzStatus,
    );
  }
}
