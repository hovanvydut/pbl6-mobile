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
  static const post = '/api/post';

  /// Get host personal posts: GET /api/post
  static const hostPostPersonal = '/api/host/personal/post';

  /// File Media
  static const mediaUpload = '/api/filecontroler/upload';
  // static const addressDistrict = '/api/address/district';
  // static const addressDistrict = '/api/address/district';
  // static const addressDistrict = '/api/address/district';

  /// Bookmark
  static const bookmark = '/api/bookmark';

  /// Create Payment and Transaction
  static const paymentBankCode = '/api/payment/bank-code';
  static const payment = '/api/payment';
  static const personalCreditHistory = '/api/payment/history/personal';

  /// Service Payment Transaction
  ///
  ///
  static const personalDebitHistory = '/api/payment-history/personal';

  /// Get other host posts: GET /api/post
  static String hostPostOther(int hostId) => '/api/host/$hostId/post';

  /// BOOKING
  /// `POST`: create booking
  ///
  static const booking = '/api/booking';

  /// GET_BOOKING_LIST
  ///
  /// `GET`: get booking list
  static const bookingPersonal = '/api/booking/personal';

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

  /// `GET`: check can review post
  ///
  ///
  static String checkReviewPost(int postId) =>
      '/api/review/check-review/post/$postId';

  /// Uptop
  ///
  /// `GET` : get uptop by postID
  ///
  /// `POST`: uptop post
  static String uptop([int? postId]) =>
      '/api/uptop${postId == null ? '' : '/$postId'}';

  /// **Uptop**
  ///
  /// `GET` duplicate: get duplicate
  ///
  static const uptopDuplicate = '/api/uptop/duplicate';

  /// **Config**
  ///
  /// `GET` config value by key
  ///
  static String configSetting(String key) => '/api/config-setting/$key';

  /// **Post Statistics**
  ///
  /// `GET` post statistics
  ///
  static const postStatistics = '/api/post-statistic';

  /// **Detail Post Statistics**
  ///
  /// `GET` detail post statistics
  ///
  static const detailPostStatistics = '/api/post-statistic/detail';

  /// **Top Post Statistics**
  ///
  /// `GET` top post statistics
  ///
  static const topPostStatistics = '/api/post-statistic/top';

  /// **User Statistics**
  ///
  /// `GET` User statistics
  ///
  static const userStatistics = '/api/user-statistic';

  /// **Detail User Statistics**
  ///
  /// `GET` top user statistics
  ///
  static const detailUserStatistics = '/api/user-statistic/detail';

  /// **Top User Statistics**
  ///
  /// `GET` top user statistics
  ///
  static const toplUserStatistics = '/api/user-statistic/top';

  /// **Get notification**
  ///
  /// `GET` notifications;
  ///
  static const notifications = '/api/notification';

  /// **Count unread notification**
  ///
  /// `GET` get count unread notification
  ///
  static const countUnreadNotification = '/api/notification/unread/count';

  /// **Read notification by id**
  ///
  /// `PUT` read notification by id
  ///
  static String readNotification(int id) => '/api/notification/has-read/$id';

  /// **Read all notification**
  ///
  /// `PUT` read all notifications
  ///
  static const readAllNotification = '/api/notification/mark-all-read';
}
