import 'group.dart';

class FoodCourt extends Group {
  String? title;
  String? intro;
  int? openOrClose;
  double? xPosition;
  double? yPosition;
  String iconImagePath = "assets/images/food-court-pin.png";

  FoodCourt(this.title, this.intro, this.openOrClose, this.xPosition, this.yPosition) : super(title, intro, openOrClose, xPosition, yPosition);

  static List<FoodCourt> initialData = [
    FoodCourt("1번째 푸드코트", "안녕하세요 맛있는거 팝니다~", 1, 1300, 321),
    FoodCourt("2번째 푸드코트", "안녕하세요 맛은 없지만 그냥 팝니다~", 1, 1345, 450),
    FoodCourt("3번째 푸드코트", "다팔아요 그냥 오세요!", 1, 1452, 467),
  ];
}