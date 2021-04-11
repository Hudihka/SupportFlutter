
import 'package:qut/Models/Content.dart';

import 'Base/BaseRequest.dart';
import 'Base/QUTError.dart';

class LikeRequest extends BaseRequest {

  String id;

  @override
  String get strUrl {
    return "content-feed/$id/favorite";
  }

  @override
  EnumMetods metods = EnumMetods.postReq;

  // @override
  // Map<String, String> parametrs(){
  //   return {'id':id};
  // }

  LikeRequest(this.id);
  
  @override
  handleOne({Map<String, dynamic> json, QUTError error}) async {

    Content content = Content.fromJson(json);
    endRequestJson(obj: content, error: error);

  }

}