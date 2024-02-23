import '../page_meta_entity/page_meta_entity.dart';

class PagedEntity<T> {
  final PageMetaEntity pageEntity;
  final List<T> data;

  PagedEntity(this.pageEntity, this.data);
}
