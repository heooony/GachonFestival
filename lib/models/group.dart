import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/models/place.dart';

import 'booth.dart';

class Group {
  Group({
    required this.title,
    required this.intro,
    required this.booth,
    required this.place,
    required this.position,
    this.status,
    this.phone,
    this.waiting,
    this.password,
    this.account,
    this.link,
    this.passwords,
    this.start,
    this.end,
    required this.openOrClose,
    this.menu,
  });

  String? id;
  String? title;
  String? intro;
  int? booth;
  int? place;
  int? position;
  String? account;
  String? phone;
  String? link;
  int? status;
  int? waiting;
  String? password;
  List<String>? passwords;
  String? start;
  String? end;
  int? openOrClose;
  Map<String, dynamic>? menu;

  // {"1": {"name": "케이스", "price": 0, "status": 1}}
  static List<Group> initialData = [
    Group(title: "키키팩토리", account: "3333056278992", intro: "모자는 필수템이다.", booth: Booth.fleaMarket.key, place: Place.freedom.key, position: 8, status: 0, openOrClose: 1, menu: {'1': {'name': '캡 & 벙거지', 'price': 15000, 'status': 1}, '2': {'name': '캉골 캡 & 벙거지', 'price': 30000, 'status': 1}, }),
    Group(title: "짙은달", intro: "인싸 아싸 구분없는 뱃지 판매하고 있습니다.", booth: Booth.fleaMarket.key, place: Place.freedom.key, position: 8, status: 0, openOrClose: 1, menu: {'1': {'name': '뱃지(4000~6000원)', 'price': 5000, 'status': 1}}),
    Group(title: "체리쉬미앤유", account: "3126230564571", intro: "에어팟 케이스, 키링, 폰케이스 판매합니다. 4천원 ~ 9천원의 가격대입니다!", booth: Booth.fleaMarket.key, place: Place.freedom.key, position: 9, status: 0, openOrClose: 1, menu: {'1': {'name': '케이스,키링,폰케이스(4000~9000)', 'price': '', 'status': 1},}),
    Group(title: "모노 페이스페인팅", account: "100026572159", intro: "할로윈 페이스 페인팅과 패션 타투", booth: Booth.fleaMarket.key, place: Place.freedom.key, position: 12, status: 0, openOrClose: 1, menu: {'1': {'name': '페페(3000~)', 'price': 3000, 'status': 1}, '2': {'name': '헤나 타투(7000~)', 'price': 7000, 'status': 1}, '3': {'name': '타투 스티커', 'price': 10000, 'status': 1},}),
    Group(title: "허니미니솜사탕", account: "36504503302", intro: "동심의 세계로", booth: Booth.fleaMarket.key, place: Place.freedom.key, position: 8, status: 0, openOrClose: 1, menu: {'1': {'name': '솜사탕(3000원~6000원)', 'price': 3000, 'status': 1}}),
    Group(title: "숯블리", intro: "가천대 법학과 4학년 재학중입니다,, 귀여운 키링을 판매하고 있으며 뽑기판 이벤트도 현재 진행하고 있습니다.", booth: Booth.fleaMarket.key, place: Place.freedom.key, position: 9, status: 0, openOrClose: 1, menu: {'1': {'name': '키링', 'price': 4900, 'status': 1}, '2': {'name': '뽑기', 'price': 1000, 'status': 1}, }),
    Group(title: "메미케이", intro: "여심 저격 감성 쥬얼리", booth: Booth.fleaMarket.key, place: Place.freedom.key, position: 11, status: 0, openOrClose: 1, menu: {'1': {'name': '팔찌 반지 목걸이 귀걸이(10000원~25000원)', 'price': '', 'status': 1},}),
    Group(title: "엘레사", intro: "하나하나고른 원석으로 만든 핸드메이드", booth: Booth.fleaMarket.key, place: Place.freedom.key, position: 11, status: 0, openOrClose: 1, menu: {'1': {'name': '원석 목걸이(9000원~12000원)', 'price': 9000, 'status': 1},}),
    Group(title: "다곰", link: "https://www.instagram.com/dagongshop/", phone: "01062439533", intro: "다람쥐 담이와 담이가 키우는 레몬 쭈를 그리는 문구브랜드 다곰입니다.", booth: Booth.fleaMarket.key, place: Place.freedom.key, position: 7, status: 0, openOrClose: 1, menu: {'1': {'name': '스티커', 'price': 2500, 'status': 1}, '2': {'name': '텀블러', 'price': 15000, 'status': 1}, '3': {'name': '떡메모지', 'price': 2000, 'status': 1}, '4': {'name': '엽서', 'price': 1000, 'status': 1},}),
    Group(title: "Route Route", intro: "루트루트 2호점입니다.", booth: Booth.fleaMarket.key, place: Place.freedom.key, position: 6, status: 0, openOrClose: 1),
    Group(title: "법학과 추억의 게임, 간식", intro: "추억 속 감성자극 게임 및 과자 증정", booth: Booth.fleaMarket.key, place: Place.freedom.key, position: 2, status: 0, openOrClose: 1, menu: {'1': {'name': '아웃백', 'price': 50000, 'status': 1}, '2': {'name': '솜사탕', 'price': 1000, 'status': 1}, '3': {'name': '과자세트', 'price': '', 'status': 1},}),
    Group(title: "뷰포트", account: "1002851142897", phone: "01043173107", intro: "악세사리 - 머리끈 쓸 수 있는 팔찌", booth: Booth.fleaMarket.key, place: Place.freedom.key, position: 3, status: 0, openOrClose: 1, menu: {'1': {'name': '머리끈 쓸 수 있는 팔찌(1개 3000, 2개 5000, 5개 15000)', 'price': '', 'status': 1}, '2': {'name': '귀걸이(3개)', 'price': 25000, 'status': 1}, '3': {'name': '뱅글', 'price': 25000, 'status': 1}, '4': {'name': '반지', 'price': 20000, 'status': 1},}),
    Group(title: "Charmant; (샤르망)", account: "59280104144949", intro: "당신의 매력을 담은 향수, 샤르망", booth: Booth.fleaMarket.key, place: Place.freedom.key, position: 4, status: 0, openOrClose: 1, menu: {'1': {'name': '30ml 향수', 'price': 10000, 'status': 1}, '2': {'name': '30ml 시그니처 향수', 'price': 12000, 'status': 1}, }),
    Group(title: "오제커피", account: "01026799435", phone: "01026799435", intro: "수제 쿠키, 에그타르트 팔아요!", booth: Booth.fleaMarket.key, place: Place.freedom.key, position: 5, status: 0, openOrClose: 1, menu: {'1': {'name': '에그타르트', 'price': 2000, 'status': 1}, '2': {'name': '스모어쿠키', 'price': 2500, 'status': 1}, '3': {'name': '말차르뱅쿠키', 'price': 3000, 'status': 1}, '4': {'name': '레드벨벳쿠키', 'price': 2500, 'status': 1},}),

    // Group(title: "뇽뇽마카롱", account: '1005702928098', intro: "마카롱, 머랭쿠키, 아메리칸쿠키", booth: Booth.fleaMarket.key, place: Place.freedom.key, position: 8, status: 0, openOrClose: 1, menu: {'1': {'name': '마카롱,머랭,아메리칸쿠키(2000~4500원)', 'price': '', 'status': 1},}),
    // Group(title: "에이슬로우피스", intro: "유니크무드의 귀걸이 브랜드입니다!", booth: Booth.fleaMarket.key, place: Place.freedom.key, position: 8, status: 0, openOrClose: 1, menu: {'1': {'name': '유니크무드의 쥬얼리(12000 ~)', 'price': 12000, 'status': 1}, '2': {'name': '실버악세사리(24000 ~)', 'price': 24000, 'status': 1}, }),
    // Group(title: "크레바젬", account: "47580201158629", intro: "가천대의 니즈를 콕 찝은 쥬얼리", booth: Booth.fleaMarket.key, place: Place.freedom.key, position: 11, status: 0, openOrClose: 1),
    // Group(title: "바니바니", phone: "01028081992" , intro: "가방, 악세사리, 헤어집게, 그립톡 잡화점", booth: Booth.fleaMarket.key, place: Place.freedom.key, position: 10, status: 0, openOrClose: 1, menu: {'1': {'name': '악세사리', 'price': 5000, 'status': 1}, '2': {'name': '헤어집게', 'price': 4000, 'status': 1}, '3': {'name': '그립톡', 'price': 5000, 'status': 1}, '4': {'name': '가방', 'price': 15000, 'status': 1},}),
    // Group(title: "스트릿샵", phone: "01054442759", intro: "남여편집브랜드. 균일가 만원", booth: Booth.fleaMarket.key, place: Place.freedom.key, position: 10, status: 0, openOrClose: 1, menu: {'1': {'name': '의류', 'price': 10000, 'status': 1},}),
    // Group(title: "레드반하나", account: '16702539260', intro: "남여 신상니트 굿 초이스 2장 1.5, 2.5", booth: Booth.fleaMarket.key, place: Place.freedom.key, position: 10, status: 0, openOrClose: 1),
    // Group(title: "낫뚤공방", account: '3333109831422', intro: "3년만에 돌아온 저렴이 수제향수", booth: Booth.fleaMarket.key, place: Place.freedom.key, position: 12, status: 0, openOrClose: 1, menu: {'1': {'name': '향수 1개', 'price': 20000, 'status': 1}, '2': {'name': '향수 2개', 'price': 30000, 'status': 1},}),
    // Group(title: "오후", account: '1002331755825', intro: "핵인싸 아이템 겟하기", booth: Booth.fleaMarket.key, place: Place.freedom.key, position: 12, status: 0, openOrClose: 1, menu: {'1': {'name': '캐릭터랜덤팬', 'price': 5000, 'status': 1},}),
    // Group(title: "빈티지리버스", account: '3333022839943', intro: "대중적인 브랜드 사이에 유니크한 무드폴로 / 리바이스 / 올드스쿨", booth: Booth.fleaMarket.key, place: Place.freedom.key, position: 13, status: 0, openOrClose: 1, menu: {'1': {'name': '의류(20000~50000원)', 'price': '', 'status': 1},}),
    //
    // Group(title: "스트릿샵", account: "60720403787", intro: "남여 캐주얼 편집브랜드", booth: Booth.fleaMarket.key, place: Place.freedom.key, position: 11, status: 0, openOrClose: 1, menu: {'1': {'name': '의류(균일가)', 'price': 10000, 'status': 1},}),
    // Group(title: "레브오너먼트", intro: "세상에 하나뿐인 레진 악세사리", booth: Booth.fleaMarket.key, place: Place.freedom.key, position: 12, status: 0, openOrClose: 1, menu: {'1': {'name': '귀걸이 및 그립톡(8000 ~ 13000원)', 'price': '', 'status': 1},}),
    // Group(title: "하트펠트 공방", account: "3333215708901", intro: "감성 천재들의 감성 석고방향제", booth: Booth.fleaMarket.key, place: Place.freedom.key, position: 12, status: 0, openOrClose: 1, menu: {'1': {'name': '석고방향제', 'price': 8000, 'status': 1},}),
    // Group(title: "바니비니", account: "01700204500067", intro: "가천대학생들을 위해 전품목 할인전", booth: Booth.fleaMarket.key, place: Place.freedom.key, position: 10, status: 0, openOrClose: 1, menu: {'1': {'name': '그립톡', 'price': 5000, 'status': 1}, '2': {'name': '헤어집게', 'price': 4000, 'status': 1},}),
    // Group(title: "이브하우스", intro: "써지컬스틸반지, 써지컬스틸 목걸이", booth: Booth.fleaMarket.key, place: Place.freedom.key, position: 12, status: 0, openOrClose: 1, menu: {'1': {'name': '써지컬스틸반지(5000~)', 'price': 5000, 'status': 1}, '2': {'name': '써지컬스틸목걸이(10000~)', 'price': 10000, 'status': 1},}),
    //
    // Group(title: "소미공방", intro: "매듭과 다채로운 실의 세상에 빠지다", booth: Booth.fleaMarket.key, place: Place.freedom.key, position: 8, status: 0, openOrClose: 1, menu: {'1': {'name': '매듭팔찌(4000~)', 'price': 4000, 'status': 1}, '2': {'name': '매듭반지(4000~)', 'price': 4000, 'status': 1}, '3': {'name': '매듭 목걸이(4000~)', 'price': 4000, 'status': 1},}),
    // Group(title: "나다스토리", phone: "01023397684", intro: "마음을 보는 심리상담 체험", booth: Booth.fleaMarket.key, place: Place.freedom.key, position: 12, status: 0, openOrClose: 1, menu: {'1': {'name': '타로', 'price': 10000, 'status': 1},}),
    // Group(title: "메로페", intro: "유니크 빈티지 셀렉트 샵", booth: Booth.fleaMarket.key, place: Place.freedom.key, position: 13, status: 0, openOrClose: 1, menu: {'1': {'name': '의류 전품목(20000원~30000원)', 'price': 20000, 'status': 1},}),
    // Group(title: "호시아", account: "3333012071097", intro: "곱창 집게핀 5천원 (금액 3000원 ~ 5000원)", booth: Booth.fleaMarket.key, place: Place.freedom.key, position: 11, status: 0, openOrClose: 1),
    // Group(title: "MAGNOLIA 21", account: "1002938074905", intro: "천연주정베이스와 고급향료를 사용한 브랜드 타입 향수", booth: Booth.fleaMarket.key, place: Place.freedom.key, position: 11, status: 0, openOrClose: 1, menu: {'1': {'name': '10ml', 'price': 10000, 'status': 1}, '2': {'name': '20ml', 'price': 20000, 'status': 1},}),

    // 동아리
    Group(title: "민속놀이촌", start: '11', end: '16', intro: "직접 쓰면서 소원을 빌어보는 부적 내가 만드는 노리개 투호 윷놀이 등 다양한 놀이를 체험해봐요.", booth: Booth.club.key, place: Place.studUnion.key, position: 1, openOrClose: 1),
    Group(title: "민속카페", start: '11', end: '16', intro: "민속카페 컨셉의 다과회를 진행해요! 전통음료와 같이 과자를 먹으며 본격적인 축제 전 느긋하게 즐겨봅시다.", booth: Booth.club.key, place: Place.studUnion.key, position: 2, openOrClose: 1),
    Group(title: "포토존", intro: "해랑이(동연마스코트)와 같이 한복을 입고, 포토존에서 사진을 찍어봐요. 상주중인 스탭이 플라로이드 필름 사진을 찍어줍니다.", booth: Booth.club.key, place: Place.studUnion.key, position: 3, openOrClose: 1),
    // Group(title: "귀신의 집", start: '17', end: '22', intro: "학생회관에 귀신이 나타났다! 밤의 학생회관을 빠져나가야해요.", booth: Booth.club.key, place: Place.studUnion.key, position: 4, openOrClose: 0),
    Group(title: "코드네임 G", start: '11', end: '17', intro: "208호에서 진행합니다!\n\n회장의 비밀문서를 훔치기 위해 산업 스파이 G가 되어 회의실을 탈출하는 방탈출 프로그램🕵‍♂️🕵‍♀️ 긴장감 넘치는 스토리를 담은 코드네임-G", booth: Booth.normal.key, place: Place.studUnion.key, position: 5, openOrClose: 1),
    Group(title: "대박곱창", account: "26020104250051", phone: "01093794937", intro: "메뉴판 바뀌신거 보이시죠?! 학생분들을 위해 가격도 내렸습니다 맛도 대박이니 많이 들러주세요 😇🔥", booth: Booth.foodTruck.key, place: Place.studUnion.key, position: 7, openOrClose: 1, menu: {'1': {'name': '야채순대볶음 or 야채순대곱창볶음 or 야채곱창볶음(소)', 'price': 10000, 'status': 1}, '2': {'name': '야채순대볶음 or 야채순대곱창볶음 or 야채곱창볶음(중)', 'price': 15000, 'status': 1}, '1': {'name': '야채순대볶음 or 야채순대곱창볶음 or 야채곱창볶음(대)', 'price': 20000, 'status': 1},}),
    Group(title: "PLAN-B", account: "110492349381", intro: "대한민국 푸드트럭협회 출신 🇰🇷 매운맛, 순한맛, 데리야끼맛 다양하게 즐겨주세요!", booth: Booth.foodTruck.key, place: Place.studUnion.key, position: 6, openOrClose: 1, menu: {'1': {'name': '닭꼬치(매운맛, 순한맛, 데리야끼)', 'price': 4000, 'status': 1},}),

    // 바람개비 동산
    // Group(title: "가천갓텔런트", start: '18', intro: "[바람개비 동산]🎤 가천 갓 탤런트 🎤 가천대학교 학우들의 꿈의 무대, 이곳에서 스타가 탄생합니다. 스타가 탄생하는 이 곳에서 함께 자리를 빛내주세요 🌟 ", booth: Booth.normal.key, place: Place.wind.key, position: 1, openOrClose: 0),
    Group(title: "글램핑 : 'For : Rest", start: '10', end: '22:30', intro: "바쁘게 뛰어다니기만 했던 학교에서 즐기는 휴식😶 보드게임, 담요 대여 가능하며 푸드트럭 및 음식 배달이 가능하니 여유롭게 즐겨주세요", booth: Booth.normal.key, place: Place.wind.key, position: 1, openOrClose: 1),
    Group(title: "타코스토리", account: "110315725421", phone: "01094290710", intro: "오리지널, 매운맛, 치즈맛 3가지로 다양하게 즐기실 수 있습니다 🤤", booth: Booth.foodTruck.key, place: Place.wind.key, position: 2, openOrClose: 1, menu: {'1': {'name': '타코야끼(소스 택1)', 'price': 6000, 'status': 1},}),
    Group(title: "쉬림프 퍼플", account: "47810104436812", phone: "01044809811", intro: "깐풍 새우 맛집 ! 🍤 중식 요리사사 직접 만들어 드립니다", booth: Booth.foodTruck.key, place: Place.wind.key, position: 3, openOrClose: 1, menu: {'1': {'name': '깐풍새우(중)', 'price': 10000, 'status': 1}, '2': {'name': '깐풍새우(대)', 'price': 14000, 'status': 1}, '3': {'name': '코코넛 새우튀김(중)', 'price': 8000, 'status': 1}, '4': {'name': '깐풍새우(대)', 'price': 12000, 'status': 1}, '5': {'name': '버터구이 새우꼬치', 'price': 6000, 'status': 1}, '6': {'name': '눈꽃치즈 새우꾀', 'price': 7000, 'status': 1}, '7': {'name': '새우꼬치 콤보', 'price': 11000, 'status': 1},}),
    Group(title: "미스터츄러스", account: "01062225474", phone: "01062225474", intro: "스페인 전통 수제 츄러스입니다 가볍게 들고 축제 즐기기 딱 좋아요 🥨", booth: Booth.foodTruck.key, place: Place.wind.key, position: 4, openOrClose: 1, menu: {'1': {'name': '츄러스(오리지널, 눈꽃, 플레인, 멀티)', 'price': 3000, 'status': 1}, '2': {'name': '회오리 생감자(허니버터맛, 치즈맛, 바베큐맛)', 'price': 4000, 'status': 1},}),
    Group(title: "오빠곱창", account: "01028287078", phone: "01034448656", intro: "가천대 학생 여러분들 반갑습니다 최고의 맛으로 모시겠습니다 ❤️‍🔥", booth: Booth.foodTruck.key, place: Place.wind.key, position: 5, openOrClose: 1, menu: {'1': {'name': '곱창볶음(1팩)', 'price': 12000, 'status': 1}, '2': {'name': '곱창볶음(2팩)', 'price': 20000, 'status': 1}, '3': {'name': '순대볶음(1팩)', 'price': 10000, 'status': 1}, '4': {'name': '닭발볶음(1팩)', 'price': 12000, 'status': 1},}),

    // 교육대학원
    Group(title: "블라인드 미팅(가식걸이)", start: '11', end: '17', intro: "[사전예약] 얼굴을 보지 않은 상태로 제한 시간동안 상대와 대화를 나누는 블라인드 미팅 👩‍❤️‍👨 모든 가식은 밖에 걸어두고 꾸밈없는 모습으로 상대를 알아가는 미팅", booth: Booth.normal.key, place: Place.gradSchool.key, position: 1, openOrClose: 1),

    // 운동장
    Group(title: "공연 무대", intro: "", booth: Booth.normal.key, place: Place.schoolYard.key, position: 19, openOrClose: 1),
    Group(title: "지하 편의점(주류 판매)", intro: "", booth: Booth.normal.key, place: Place.schoolYard.key, position: 20, openOrClose: 1),
  ];

  factory Group.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return Group(
      title: data?['title'],
      intro: data?['intro'],
      booth: data?['booth'],
      place: data?['place'],
      position: data?['position'],
      status: data?['status'],
      account: data?['account'],
      phone: data?['phone'],
      waiting: data?['waiting'],
      password: data?['password'],
      // passwords: List<String>.from(data?['passwords'].map((e) => e)),
      openOrClose: data?['openOrClose'],
      menu: data?['menu'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (title != null) "major": title,
      if (intro != null) "intro": intro,
      if (booth != null) "booth": booth,
      if (place != null) "place": place,
      if (position != null) "position": position,
      if (status != null) "status": status,
      if (account != null) "account": account,
      if (phone != null) "phone": phone,
      if (waiting != null) "waiting": waiting,
      if (password != null) "password": password,
      // if (passwords != null) "passwords": List<dynamic>.from(passwords!.map((e) => e)),
      if (openOrClose != null) "openOrClose": openOrClose,
      if (menu != null) "menu": menu,
    };
  }
}

class Menu {
  Menu({
    required this.name,
    required this.price,
    required this.status,
  });

  String? name;
  int? price;
  int? status;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        name: json["name"],
        price: json["price"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "status": status,
      };

  factory Menu.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return Menu(
      name: data?['name'],
      price: data?['price'],
      status: data?['status'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (price != null) "price": price,
      if (status != null) "status": status,
    };
  }
}
