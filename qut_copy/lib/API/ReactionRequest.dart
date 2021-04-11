import 'package:qut/Models/Content.dart';

import 'Base/BaseRequest.dart';
import 'Base/QUTError.dart';

class ReactionRequest extends BaseRequest {

  String id;
  bool like;

  @override
  String get strUrl {
    return "content-feed/$id/reaction";
  }

  @override
  EnumMetods metods = EnumMetods.postReq;

  @override
  Map<String, String> parametrs(){
    final likeParametr = like ? "1" : "-1";
    return {'reaction': likeParametr};
  }

  ReactionRequest(this.id, this.like);
  
  @override
  handleOne({Map<String, dynamic> json, QUTError error}) async {

    Content content = Content.fromJson(json);
    endRequestJson(obj: content, error: error);

  }

}