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
  /// Get all posts: GET /api/post
  /// Create new post: POST /api/post
  /// Get post by id: GET /api/post/{id}
  /// Edit post by id: PUT /api/post/{id}
  /// Delete post by id: DELETE /api/post/{id}
  static const post = '/api/post';

  // static const addressDistrict = '/api/address/district';
  // static const addressDistrict = '/api/address/district';
  // static const addressDistrict = '/api/address/district';
}
