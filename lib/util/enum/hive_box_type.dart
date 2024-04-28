enum HiveBoxType {
  searchCondition,
  notificationSetting;

  String get key {
    switch (this) {
      case HiveBoxType.searchCondition:
        return 'searchConditionBox';
      case HiveBoxType.notificationSetting:
        return 'notificationSettingBox';
    }
  }

  int get typeId {
    switch (this) {
      case HiveBoxType.searchCondition:
        return 1;
      case HiveBoxType.notificationSetting:
        return 2;
    }
  }
}
