import 'package:flutter/foundation.dart';

import './reward_type.dart';

class RewardModel {
  final String title;
  final RewardType type;
  final String imgUrl;
  final String infos;

  RewardModel(this.title, this.type, this.imgUrl, this.infos);
}