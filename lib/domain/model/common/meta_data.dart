class MetaDataClass {
  MetaDataClass({required this.json});
  final Map<String,dynamic> json;

  factory MetaDataClass.fromJson(Map<String, dynamic> json){
    return MetaDataClass(
        json: json
    );
  }

  Map<String, dynamic> toJson() => {
  };

  @override
  String toString(){
    return "";
  }
}