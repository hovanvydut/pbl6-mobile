import 'package:flutter/material.dart';
import 'package:pbl6_mobile/app/app.dart';
import 'package:pbl6_mobile/home/home.dart';

class SearchByDistrictView extends StatelessWidget {
  const SearchByDistrictView({super.key});

  @override
  Widget build(BuildContext context) {
    final districts = [
      {
        'id': 356,
        'name': 'Thanh Khê',
        'imageUrl': 'https://file1.dangcongsan.vn/data/0/'
            'images/2022/07/26/giangntt/quang-canh-quan-thanh-khe.jpg'
      },
      {
        'id': 357,
        'name': 'Hải Châu',
        'imageUrl': 'https://cdn.baogiaothong.vn/upload/'
            '3-2022/images/2022-07-25/2-1658733315-112-width740height515.jpg'
      },
      {
        'id': 358,
        'name': 'Cẩm Lệ',
        'imageUrl': 'https://camle.danang.gov.vn/documents/10184/55713/1_'
            'trienlam.jpg/842b2a54-f058-4ae4-950a-3f610dc105e9?version=1.2&t='
            '1508900445000&imageThumbnail=0'
      },
      {
        'id': 355,
        'name': 'Liên Chiểu',
        'imageUrl': 'https://photo-cms-sggp.zadn.vn/w580/Uploaded/2022/chu'
            'kplu/2020_07_28/2402_yepz.jpg'
      },
      {
        'id': 359,
        'name': 'Ngũ Hành Sơn',
        'imageUrl': 'https://cdn.vntrip.vn/cam-nang/wp-content/uploads/2017'
            '/08/Ngu-Hanh-Son-e1502127139914.png'
      },
      {
        'id': 360,
        'name': 'Sơn Trà',
        'imageUrl':
            'https://dacotours.com/wp-content/uploads/2019/10/son-tra-da-nang.jpg'
      },
      {
        'id': 361,
        'name': 'Huyện Hòa Vang',
        'imageUrl':
            'https://dulichdiaphuong.com/imgs/thanh-pho-da-nang/cau-vang.jpg'
      },
    ];
    return SizedBox(
      height: context.height * 0.2,
      child: ListView.separated(
        itemCount: districts.length,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final district = districts[index];
          return TrendingDistrictBox(district: district);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(width: 8);
        },
      ),
    );
  }
}
