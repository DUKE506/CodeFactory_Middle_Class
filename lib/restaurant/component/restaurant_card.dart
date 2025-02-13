import 'package:flutter/material.dart';
import 'package:section2/common/const/colors.dart';
import 'package:section2/common/const/data.dart';
import 'package:section2/restaurant/model/restaurant_detail_model.dart';
import 'package:section2/restaurant/model/restaurant_model.dart';

class RestaurantCard extends StatelessWidget {
  //이미지
  final Widget image;
  //가게명
  final String name;
  //태그
  final List<String> tags;
  //별점 개수
  final int ratingsCount;
  //배달시간
  final int deliveryTime;
  //배달비용
  final int deliveryFee;
  //별점
  final double ratings;
  //상세 카드 여부
  final bool isDetail;

  //히어로 위젯 키
  final String? heroKey;
  //상세 내용
  final String? detail;

  const RestaurantCard({
    super.key,
    required this.image,
    required this.name,
    required this.tags,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.ratings,
    this.isDetail = false,
    this.heroKey,
    this.detail,
  });

  factory RestaurantCard.fromModel({
    required RestaurantModel model,
    bool isDetail = false,
  }) {
    return RestaurantCard(
      image: Image.network(
        model.thumbUrl,
        fit: BoxFit.cover,
      ),
      name: model.name,
      tags: model.tags,
      ratingsCount: model.ratingsCount,
      deliveryTime: model.deliveryTime,
      deliveryFee: model.deliveryFee,
      ratings: model.ratings,
      isDetail: isDetail,
      heroKey: model.id,
      detail: model is RestaurantDetailModel ? model.detail : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (heroKey != null)
          Hero(
            tag: ObjectKey(heroKey),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(isDetail ? 0 : 12.0),
              child: image,
            ),
          ),
        if (heroKey == null)
          ClipRRect(
            borderRadius: BorderRadius.circular(isDetail ? 0 : 12.0),
            child: image,
          ),
        const SizedBox(
          height: 16.0,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isDetail ? 16.0 : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                tags.join(' · '),
                style: const TextStyle(
                  fontSize: 14.0,
                  color: BODY_TEXT_COLOR,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Row(
                children: [
                  //평점
                  _RestaurantInfoRow(
                    icon: Icons.star,
                    label: ratings.toString(),
                  ),
                  renderDot(),
                  //평점수
                  _RestaurantInfoRow(
                    icon: Icons.comment,
                    label: ratingsCount.toString(),
                  ),
                  renderDot(),
                  //배송시간
                  _RestaurantInfoRow(
                    icon: Icons.timelapse,
                    label: '$deliveryTime분',
                  ),
                  renderDot(),
                  //배송비용
                  _RestaurantInfoRow(
                    icon: Icons.paid,
                    label: '${deliveryFee == 0 ? '무료' : '$deliveryFee원'}',
                  ),
                ],
              ),
              if (detail != null && isDetail)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    detail!,
                    style: TextStyle(fontSize: 12.0),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget renderDot() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Center(
        child: Text(
          '·',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

//가게 정보 ROW
class _RestaurantInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const _RestaurantInfoRow({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: PRIMARY_COLOR,
          size: MediaQuery.of(context).size.width / 28,
        ),
        SizedBox(
          width: 8.0,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
