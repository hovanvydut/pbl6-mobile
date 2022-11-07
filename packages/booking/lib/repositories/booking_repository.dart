import 'package:booking/booking.dart';
import 'package:models/models.dart';

class BookingRepository {
  BookingRepository({required IBookingDatasource bookingDatasource})
      : _bookingDatasource = bookingDatasource;

  final IBookingDatasource _bookingDatasource;

  Future<void> createBooking({
    required int postId,
    required DateTime bookingTime,
  }) =>
      _bookingDatasource.createBooking(
        postId: postId,
        bookingTime: bookingTime,
      );

  Future<List<BookingData>> getBookingList({
    required int month,
    required int year,
    int pageNumber = 1,
    int pageSize = 10,
    String? searchValue,
  }) =>
      _bookingDatasource.getBookingList(
        month: month,
        year: year,
        pageNumber: pageNumber,
        pageSize: pageSize,
        searchValue: searchValue,
      );

  Future<List<Freetime>> getFreeTimeByUserId(int userId) =>
      _bookingDatasource.getFreeTimeByUserId(userId);

  Future<void> setFreeTime({required List<Freetime> freetimes}) =>
      _bookingDatasource.setFreetime(freetimes: freetimes);

  Future<void> approveBooking({required int bookingId}) =>
      _bookingDatasource.approveBooking(bookingId: bookingId);

  Future<void> confirmMeeting({required int bookingId}) =>
      _bookingDatasource.confirmMeeting(bookingId: bookingId);
}
