import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSaveData {
  static SharedPreferences _preferences;
  static const _keyuserName = 'name';
  static const _keyGender = 'gender';
  static const _keyuserProfilepic = 'pic';
  static const _keyuserAge = 'age';
  static const _keyuserFavouriteList = "favouritelist";
  static const _keyuserDownloadList = "downloadlist";

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
//name
  static Future setName({@required String username}) async =>
      await _preferences.setString(_keyuserName, username);

  static String getName() => _preferences.getString(_keyuserName) ?? "?";

//Gender
  static Future setGender({@required String gender}) async =>
      await _preferences.setString(_keyGender, gender);

  static String getGender() => _preferences.getString(_keyGender) ?? "?";

//Prifile pic
  static Future setProfilepic({@required String userProfilepic}) async =>
      await _preferences.setString(_keyuserProfilepic, userProfilepic);

  static String getProfilepic() =>
      _preferences.getString(_keyuserProfilepic) ?? "?";

//Age
  static Future setAge({@required String userAge}) async =>
      await _preferences.setString(_keyuserAge, userAge);

  static String getAge() => _preferences.getString(_keyuserAge) ?? "?";

//FavouriteList
  static Future setFavouriteList(
          {@required List<String> setFavouriteList}) async =>
      await _preferences.setStringList(_keyuserFavouriteList, setFavouriteList);

  static List<String> getFavouriteList() =>
      _preferences.getStringList(_keyuserFavouriteList) ?? [];

//DownloadList
  static Future setDownloadList(
          {@required List<String> setDownloadList}) async =>
      await _preferences.setStringList(_keyuserDownloadList, setDownloadList);

  static List<String> getDownloadList() =>
      _preferences.getStringList(_keyuserDownloadList) ?? [];
}
