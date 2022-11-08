abstract class ApiPath {
  /// Address
  static const addressProvince = '/api/address/province';
  static const addressDistrict = '/api/address/district';
  static const addressWard = '/api/address/ward';

  /// Category
  static const categoryHouseType = '/api/category/house-type';

  /// Property
  static const property = '/api/property';

  /// Auth
  static const authLogin = '/api/auth/login';
  static const authRegister = '/api/auth/register';

  /// User
  static const userPersonal = '/api/user/personal';
  static const userAnonymous = '/api/user/anonymous';

  /// Post
  /// Create new post: POST /api/post
  /// Get post by id: GET /api/post/{id}
  /// Edit post by id: PUT /api/post/{id}
  /// Delete post by id: DELETE /api/post/{id}
  static const postFilter = '/api/post';

  /// Get all posts: GET /api/post
  static const postAll = '/api/post/all';

  /// Get host personal posts: GET /api/post
  static const hostPostPersonal = '/api/host/personal/post';

  /// File Media
  static const mediaUpload = '/api/filecontroler/upload';
  // static const addressDistrict = '/api/address/district';
  // static const addressDistrict = '/api/address/district';
  // static const addressDistrict = '/api/address/district';

  /// Bookmark
  static const bookmark = '/api/bookmark';

  /// Payment
  static const paymentBankCode = '/api/payment/bank-code';
  static const payment = '/api/payment';
  static const paymentHistoryPersonal = '/api/payment/history';

  /// Get other host posts: GET /api/post
  static String hostPostOther(int hostId) => '/api/host/$hostId/post';

  /// BOOKING

  /// `POST`: create booking
  ///
  /// `GET`: get booking list
  static const booking = '/api/booking';

  /// `PUT`: Approve Booking
  static String approveBooking(int bookingId) =>
      '/api/booking/$bookingId/approve';

  /// `PUT`: Confirm Meeting
  static String confirmMeeting(int bookingId) =>
      '/api/booking/$bookingId/confirm-meet';

  /// `POST`: config freetime
  static const freetime = '/api/booking/free-time';

  /// `GET`: get freetime of user
  ///
  static String freetimeOther(int userId) =>
      '/api/booking/user/$userId/free-time';

  /// `GET`: get reviews by postId
  ///
  /// `POST`: create review by postId
  static String postReview(int postId) => '/api/review/post/$postId';
}
