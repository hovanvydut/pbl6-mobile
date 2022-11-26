abstract class StatisticsMapper {
  static const _data = <String, String>{
    'view_post_detail': 'Số lượt chi tiết bài viết',
    'booking': 'Số lượt đặt lịch xem trọ',
    'guest_met_motel': 'Số lượt đến xem trọ thành công',
    'bookmark': 'Số lượt lưu bài viết',
  };

  static String mapFrom(String key) => _data[key]!;
}
