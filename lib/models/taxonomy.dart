class TaxonomyModel {
  int id;
  String name;
  String slug;

  TaxonomyModel.fromJson(obj) {
   // var term = obj['term'];
    this.id = obj['id'];
    this.name = obj['name'];
    this.slug = obj['slug'];

  }

  static List<TaxonomyModel> fromJsonList(jsonList) {
    //var data = jsonList['data'];
    return jsonList
        .map<TaxonomyModel>((obj) => TaxonomyModel.fromJson(obj))
        .toList();
  }
}
