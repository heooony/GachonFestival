import 'group.dart';

class FleaMarket extends Group {
  String? title;
  String? intro;
  int? openOrClose;
  double? xPosition;
  double? yPosition;
  String iconImagePath = "assets/images/flea-market-pin.png";

  FleaMarket(this.title, this.intro, this.openOrClose, this.xPosition, this.yPosition) : super(title, intro, openOrClose, xPosition, yPosition);

  static List<FleaMarket> initialData = [
    FleaMarket("1번째 플리마켓", "벼룩 팔아요!!", 0, 1100, 500),
    FleaMarket("2번째 플리마켓", "뭐든지 다 팝니다!!", 1, 900, 600),
  ];
}