class TermsOfUseModel {
  int? id;
  String? title;
  String? slug;
  String? content;
  String? updatedAt;

  TermsOfUseModel(
      {this.id, this.title, this.slug, this.content, this.updatedAt});

  TermsOfUseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    content = json['content'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['content'] = content;
    data['updated_at'] = updatedAt;
    return data;
  }
}
