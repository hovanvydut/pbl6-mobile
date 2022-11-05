part of 'create_booking_bloc.dart';

class CreateBookingState extends Equatable {
  const CreateBookingState({
    this.currentStep = 0,
    required this.post,
    this.phoneNumber = const PhoneNumber.pure(),
    this.formzStatus = FormzStatus.pure,
  });

  final int currentStep;
  final Post post;
  final PhoneNumber phoneNumber;
  final FormzStatus formzStatus;

  @override
  List<Object> get props => [
        currentStep,
        post,
        phoneNumber,
        formzStatus,
      ];

  CreateBookingState copyWith({
    int? currentStep,
    Post? post,
    PhoneNumber? phoneNumber,
    FormzStatus? formzStatus,
  }) {
    return CreateBookingState(
      currentStep: currentStep ?? this.currentStep,
      post: post ?? this.post,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      formzStatus: formzStatus ?? this.formzStatus,
    );
  }
}
