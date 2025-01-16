class ReactionResponse {
    ReactionResponse({
        required this.totalLikes,
        required this.reactionType,
        required this.meta,
    });

    final num? totalLikes;
    final String? reactionType;
    final Meta? meta;

    factory ReactionResponse.fromJson(Map<String, dynamic> json){ 
        return ReactionResponse(
            totalLikes: json["total_likes"],
            reactionType: json["reaction_type"],
            meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "total_likes": totalLikes,
        "reaction_type": reactionType,
        "meta": meta?.toJson(),
    };

    @override
    String toString(){
        return "$totalLikes, $reactionType, $meta, ";
    }
}

class Meta {
    Meta({required this.json});
    final Map<String,dynamic> json;

    factory Meta.fromJson(Map<String, dynamic> json){ 
        return Meta(
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
