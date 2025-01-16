import '../config/app_mode.dart';

class EndPoints {

  // base url

  static const productionUrlConst = 'https://iap.ezycourse.com/'; // live base URL
  static const developerBaseUrlConst = 'https://iap.ezycourse.com/'; // dev base URL

  static const baseUrl = AppMode.productionModeConst ? productionUrlConst : developerBaseUrlConst;

  // others

  static const String loginUrl = 'api/app/student/auth/login';
  static const String logoutUrl = 'api/app/student/auth/logout';
  static const String feedUrl = 'api/app/teacher/community/getFeed?status=feed&';
  static const String createFeedPostUrl = 'api/app/teacher/community/createFeedWithUpload?';
  static const String createCommentUrl = 'api/app/student/comment/createComment';
  static const String getCommentUrl = 'api/app/student/comment/getComment/';
  static const String getReactions = 'api/app/teacher/community/getAllReactionType?';
  static const String createOrDeleteReactionUrl = 'api/app/teacher/community/createLike?';
  static const String adReply = 'api/app/student/comment/createComment';
  static const String getReply = 'api/app/student/comment/getReply/';


}
