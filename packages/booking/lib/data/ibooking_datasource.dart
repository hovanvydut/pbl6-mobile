import 'package:models/models.dart';

abstract class IBookingDatasource {
  Future<void> createBooking({
    required int postId,
    required DateTime bookingTime,
  });

  Future<List<BookingData>> getBookingList({
    int? month,
    int? year,
    int pageNumber = 1,
    int pageSize = 10,
    String? searchValue,
  });

  Future<List<Freetime>> getFreeTimeByUserId(int userId);

  Future<void> setFreetime({required List<Freetime> freetimes});

  Future<void> approveBooking({required int bookingId});

  Future<void> confirmMeeting({required int bookingId});
}
