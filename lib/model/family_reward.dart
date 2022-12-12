class FamilyReward {
  FamilyReward({
    required this.userName,
    required this.iconUrl,
    required this.requestingCount,
    required this.smallRewardId,
    required this.smallRewardName,
    required this.smallRewardPoint,
    required this.smallRewardOwnedPoint,
    required this.smallRewardDifferencePoint,
    required this.smallRewardRating,
    required this.smallRewardIsRequesting,
    required this.smallRewardNote,
    required this.middleRewardId,
    required this.middleRewardName,
    required this.middleRewardPoint,
    required this.middleRewardOwnedPoint,
    required this.middleRewardDifferencePoint,
    required this.middleRewardRating,
    required this.middleRewardIsRequesting,
    required this.middleRewardNote,
    required this.largeRewardId,
    required this.largeRewardName,
    required this.largeRewardPoint,
    required this.largeRewardOwnedPoint,
    required this.largeRewardDifferencePoint,
    required this.largeRewardRating,
    required this.largeRewardIsRequesting,
    required this.largeRewardNote,
  });

  final String userName;
  final String iconUrl;
  final int requestingCount;
  final int smallRewardId;
  final String smallRewardName;
  final int smallRewardPoint;
  final int smallRewardOwnedPoint;
  final int smallRewardDifferencePoint;
  final double smallRewardRating;
  final bool smallRewardIsRequesting;
  final String smallRewardNote;
  final int middleRewardId;
  final String middleRewardName;
  final int middleRewardPoint;
  final int middleRewardOwnedPoint;
  final int middleRewardDifferencePoint;
  final double middleRewardRating;
  final bool middleRewardIsRequesting;
  final String middleRewardNote;
  final int largeRewardId;
  final String largeRewardName;
  final int largeRewardPoint;
  final int largeRewardOwnedPoint;
  final int largeRewardDifferencePoint;
  final double largeRewardRating;
  final bool largeRewardIsRequesting;
  final String largeRewardNote;

  static FamilyReward fromJson(Map<String, dynamic> json) {
    return FamilyReward(
      userName: json['user']['userName'],
      iconUrl: json['user']['iconUrl'],
      requestingCount: json['requestingCount'],
      smallRewardId: json['smallReward']['id'],
      smallRewardName:  json['smallReward']['name'],
      smallRewardPoint: json['smallReward']['rewardPoint'],
      smallRewardOwnedPoint: json['smallReward']['ownedPoint'],
      smallRewardDifferencePoint: json['smallReward']['differencePoint'],
      smallRewardRating: json['smallReward']['rating'],
      smallRewardIsRequesting: json['smallReward']['isRequesting'],
      smallRewardNote: json['smallReward']['note'],
      middleRewardId: json['middleReward']['id'],
      middleRewardName:  json['middleReward']['name'],
      middleRewardPoint: json['middleReward']['rewardPoint'],
      middleRewardOwnedPoint: json['middleReward']['ownedPoint'],
      middleRewardDifferencePoint: json['middleReward']['differencePoint'],
      middleRewardRating: json['middleReward']['rating'],
      middleRewardIsRequesting: json['middleReward']['isRequesting'],
      middleRewardNote: json['middleReward']['note'],
      largeRewardId: json['largeReward']['id'],
      largeRewardName:  json['largeReward']['name'],
      largeRewardPoint: json['largeReward']['rewardPoint'],
      largeRewardOwnedPoint: json['largeReward']['ownedPoint'],
      largeRewardDifferencePoint: json['largeReward']['differencePoint'],
      largeRewardRating: json['largeReward']['rating'],
      largeRewardIsRequesting: json['largeReward']['isRequesting'],
      largeRewardNote: json['largeReward']['note'],
    );
  }
}
