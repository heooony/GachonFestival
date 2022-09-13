import 'package:untitled/models/club.dart';
import 'package:untitled/models/flea_market.dart';
import 'package:untitled/models/food_court.dart';
import 'package:untitled/repository/main_repository.dart';

import '../../models/group.dart';
import '../../models/major.dart';

class MapController {
  MainRepository _mainRepository = MainRepository();

  String getImagePath(Group group) {
    print(group.runtimeType);
    if(group is Major) return "assets/images/map/major-map.png";
    else if(group is Club) return "assets/images/map/club-map.png";
    else if(group is FoodCourt) return "assets/images/map/food-court-map.png";
    else return "assets/images/map/flea-market-map.png";
  }
}