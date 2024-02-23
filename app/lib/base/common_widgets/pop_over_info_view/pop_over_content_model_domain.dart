import 'open_view_type.dart';
import 'pop_over_content_model.dart';

class PopOverContentModelDomain {
  final PopOverContentModel _popOverContentModel;

  const PopOverContentModelDomain(this._popOverContentModel);

  String? get videoUrl => _popOverContentModel.videoUrl;
  String? get avatarUrl => _popOverContentModel.avatarUrl;
  String get title => _popOverContentModel.title ?? "";
  String get text => _popOverContentModel.message;
  String? get thumbnailUrl => _popOverContentModel.thumbnailUrl;
  String get buttonTitle => _popOverContentModel.buttonText ?? "";
  PopUpOpenViewType get buttonType {
    return PopUpOpenViewType.none;
  }
}
