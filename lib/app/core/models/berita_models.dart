class BeritaRespose {
    int id;
    DateTime date;
    DateTime dateGmt;
    Guid guid;
    DateTime modified;
    DateTime modifiedGmt;
    String slug;
    Status status;
    BeritaResposeType type;
    String link;
    Guid title;
    Content content;
    Content excerpt;
    int author;
    int featuredMedia;
    CommentStatus commentStatus;
    PingStatus pingStatus;
    bool sticky;
    String template;
    Format format;
    Meta meta;
    List<int> categories;
    List<int> tags;
    List<String> classList;
    String yoastHead;
    YoastHeadJson yoastHeadJson;
    Links links;

    BeritaRespose({
        required this.id,
        required this.date,
        required this.dateGmt,
        required this.guid,
        required this.modified,
        required this.modifiedGmt,
        required this.slug,
        required this.status,
        required this.type,
        required this.link,
        required this.title,
        required this.content,
        required this.excerpt,
        required this.author,
        required this.featuredMedia,
        required this.commentStatus,
        required this.pingStatus,
        required this.sticky,
        required this.template,
        required this.format,
        required this.meta,
        required this.categories,
        required this.tags,
        required this.classList,
        required this.yoastHead,
        required this.yoastHeadJson,
        required this.links,
    });

    factory BeritaRespose.fromJson(Map<String, dynamic> json) {
  return BeritaRespose(
    id: json["id"],
    date: DateTime.parse(json["date"]),
    dateGmt: DateTime.parse(json["date_gmt"]),
    guid: Guid(rendered: json["guid"]["rendered"]),
    modified: DateTime.parse(json["modified"]),
    modifiedGmt: DateTime.parse(json["modified_gmt"]),
    slug: json["slug"],
    status: Status.PUBLISH,
    type: BeritaResposeType.POST,
    link: json["link"],
    title: Guid(rendered: json["title"]["rendered"]),
    content: Content(rendered: json["content"]["rendered"], protected: json["content"]["protected"]),
    excerpt: Content(rendered: json["excerpt"]["rendered"], protected: json["excerpt"]["protected"]),
    author: json["author"],
    featuredMedia: json["featured_media"],
    commentStatus: CommentStatus.CLOSED,
    pingStatus: PingStatus.OPEN,
    sticky: json["sticky"],
    template: json["template"],
    format: Format.STANDARD,
    meta: Meta(
      inlineFeaturedImage: json["meta"]["inline_featured_image"],
      footnotes: json["meta"]["footnotes"],
    ),
    categories: List<int>.from(json["categories"].map((x) => x)),
    tags: List<int>.from(json["tags"].map((x) => x)),
    classList: [],
    yoastHead: json["yoast_head"] ?? "",
    yoastHeadJson: YoastHeadJson(
      title: json["yoast_head_json"]["title"],
      description: json["yoast_head_json"]["description"],
      robots: Robots(
        index: Index.INDEX,
        follow: Follow.FOLLOW,
        maxSnippet: MaxSnippet.MAX_SNIPPET_1,
        maxImagePreview: MaxImagePreview.MAX_IMAGE_PREVIEW_LARGE,
        maxVideoPreview: MaxVideoPreview.MAX_VIDEO_PREVIEW_1,
      ),
      canonical: json["yoast_head_json"]["canonical"],
      ogLocale: OgLocale.EN_US,
      ogType: OgType.ARTICLE,
      ogTitle: json["yoast_head_json"]["og_title"],
      ogDescription: json["yoast_head_json"]["og_description"],
      ogUrl: json["yoast_head_json"]["og_url"],
      ogSiteName: AuthorEnum.SMK_MADINATULQURAN,
      articlePublisher: json["yoast_head_json"]["article_publisher"],
      articlePublishedTime: DateTime.parse(json["yoast_head_json"]["article_published_time"]),
      articleModifiedTime: DateTime.parse(json["yoast_head_json"]["article_modified_time"]),
      ogImage: (json["yoast_head_json"]["og_image"] as List)
          .map((e) => OgImage(
                width: e["width"],
                height: e["height"],
                url: e["url"],
                type: OgImageType.IMAGE_JPEG,
              ))
          .toList(),
      author: AuthorEnum.SMK_MADINATULQURAN,
      twitterCard: TwitterCard.SUMMARY_LARGE_IMAGE,
      twitterMisc: TwitterMisc(
        writtenBy: AuthorEnum.SMK_MADINATULQURAN,
        estReadingTime: EstReadingTime.THE_2_MINUTES,
      ),
      schema: Schema(context: "", graph: []),
    ),
    links: Links(
      self: [],
      collection: [],
      about: [],
      author: [],
      replies: [],
      versionHistory: [],
      predecessorVersion: [],
      wpFeaturedmedia: [],
      wpAttachment: [],
      wpTerm: [],
      curies: [],
    ),
  );
}


}

enum CommentStatus {
    CLOSED
}

class Content {
    String rendered;
    bool protected;

    Content({
        required this.rendered,
        required this.protected,
    });

}

enum Format {
    STANDARD
}

class Guid {
    String rendered;

    Guid({
        required this.rendered,
    });

}

class Links {
    List<Self> self;
    List<About> collection;
    List<About> about;
    List<AuthorElement> author;
    List<AuthorElement> replies;
    List<VersionHistory> versionHistory;
    List<PredecessorVersion> predecessorVersion;
    List<AuthorElement> wpFeaturedmedia;
    List<About> wpAttachment;
    List<WpTerm> wpTerm;
    List<Cury> curies;

    Links({
        required this.self,
        required this.collection,
        required this.about,
        required this.author,
        required this.replies,
        required this.versionHistory,
        required this.predecessorVersion,
        required this.wpFeaturedmedia,
        required this.wpAttachment,
        required this.wpTerm,
        required this.curies,
    });

}

class About {
    String href;

    About({
        required this.href,
    });

}

class AuthorElement {
    bool embeddable;
    String href;

    AuthorElement({
        required this.embeddable,
        required this.href,
    });

}

class Cury {
    Name name;
    Href href;
    bool templated;

    Cury({
        required this.name,
        required this.href,
        required this.templated,
    });

}

enum Href {
    HTTPS_API_W_ORG_REL
}

enum Name {
    WP
}

class PredecessorVersion {
    int id;
    String href;

    PredecessorVersion({
        required this.id,
        required this.href,
    });

}

class Self {
    String href;
    TargetHints targetHints;

    Self({
        required this.href,
        required this.targetHints,
    });

}

class TargetHints {
    List<Allow> allow;

    TargetHints({
        required this.allow,
    });

}

enum Allow {
    GET
}

class VersionHistory {
    int count;
    String href;

    VersionHistory({
        required this.count,
        required this.href,
    });

}

class WpTerm {
    Taxonomy taxonomy;
    bool embeddable;
    String href;

    WpTerm({
        required this.taxonomy,
        required this.embeddable,
        required this.href,
    });

}

enum Taxonomy {
    CATEGORY,
    POST_TAG
}

class Meta {
    bool inlineFeaturedImage;
    String footnotes;

    Meta({
        required this.inlineFeaturedImage,
        required this.footnotes,
    });

}

enum PingStatus {
    OPEN
}

enum Status {
    PUBLISH
}

enum BeritaResposeType {
    POST
}

class YoastHeadJson {
    String title;
    String? description;
    Robots robots;
    String canonical;
    OgLocale ogLocale;
    OgType ogType;
    String ogTitle;
    String ogDescription;
    String ogUrl;
    AuthorEnum ogSiteName;
    String articlePublisher;
    DateTime articlePublishedTime;
    DateTime articleModifiedTime;
    List<OgImage> ogImage;
    AuthorEnum author;
    TwitterCard twitterCard;
    TwitterMisc twitterMisc;
    Schema schema;

    YoastHeadJson({
        required this.title,
        this.description,
        required this.robots,
        required this.canonical,
        required this.ogLocale,
        required this.ogType,
        required this.ogTitle,
        required this.ogDescription,
        required this.ogUrl,
        required this.ogSiteName,
        required this.articlePublisher,
        required this.articlePublishedTime,
        required this.articleModifiedTime,
        required this.ogImage,
        required this.author,
        required this.twitterCard,
        required this.twitterMisc,
        required this.schema,
    });

}

enum AuthorEnum {
    SMK_MADINATULQURAN,
    TIM_IT_SMK
}

class OgImage {
    int width;
    int height;
    String url;
    OgImageType type;

    OgImage({
        required this.width,
        required this.height,
        required this.url,
        required this.type,
    });

}

enum OgImageType {
    IMAGE_JPEG
}

enum OgLocale {
    EN_US
}

enum OgType {
    ARTICLE
}

class Robots {
    Index index;
    Follow follow;
    MaxSnippet maxSnippet;
    MaxImagePreview maxImagePreview;
    MaxVideoPreview maxVideoPreview;

    Robots({
        required this.index,
        required this.follow,
        required this.maxSnippet,
        required this.maxImagePreview,
        required this.maxVideoPreview,
    });

}

enum Follow {
    FOLLOW
}

enum Index {
    INDEX
}

enum MaxImagePreview {
    MAX_IMAGE_PREVIEW_LARGE
}

enum MaxSnippet {
    MAX_SNIPPET_1
}

enum MaxVideoPreview {
    MAX_VIDEO_PREVIEW_1
}

class Schema {
    String context;
    List<Graph> graph;

    Schema({
        required this.context,
        required this.graph,
    });

}

class Graph {
    GraphType type;
    String id;
    Breadcrumb? isPartOf;
    GraphAuthor? author;
    String? headline;
    DateTime? datePublished;
    DateTime? dateModified;
    Breadcrumb? mainEntityOfPage;
    int? wordCount;
    Breadcrumb? publisher;
    Image? image;
    String? thumbnailUrl;
    List<String>? articleSection;
    InLanguage? inLanguage;
    String? url;
    String? name;
    Breadcrumb? primaryImageOfPage;
    String? description;
    Breadcrumb? breadcrumb;
    List<PotentialAction>? potentialAction;
    String? contentUrl;
    int? width;
    int? height;
    List<ItemListElement>? itemListElement;
    Image? logo;
    List<String>? sameAs;
    List<String>? keywords;
    String? caption;

    Graph({
        required this.type,
        required this.id,
        this.isPartOf,
        this.author,
        this.headline,
        this.datePublished,
        this.dateModified,
        this.mainEntityOfPage,
        this.wordCount,
        this.publisher,
        this.image,
        this.thumbnailUrl,
        this.articleSection,
        this.inLanguage,
        this.url,
        this.name,
        this.primaryImageOfPage,
        this.description,
        this.breadcrumb,
        this.potentialAction,
        this.contentUrl,
        this.width,
        this.height,
        this.itemListElement,
        this.logo,
        this.sameAs,
        this.keywords,
        this.caption,
    });

}

class GraphAuthor {
    AuthorEnum name;
    String id;

    GraphAuthor({
        required this.name,
        required this.id,
    });

}

class Breadcrumb {
    String id;

    Breadcrumb({
        required this.id,
    });

}

class Image {
    String id;
    GraphType? type;
    InLanguage? inLanguage;
    String? url;
    String? contentUrl;
    AuthorEnum? caption;
    int? width;
    int? height;

    Image({
        required this.id,
        this.type,
        this.inLanguage,
        this.url,
        this.contentUrl,
        this.caption,
        this.width,
        this.height,
    });

}

enum InLanguage {
    EN_US
}

enum GraphType {
    ARTICLE,
    BREADCRUMB_LIST,
    IMAGE_OBJECT,
    ORGANIZATION,
    PERSON,
    WEB_PAGE,
    WEB_SITE
}

class ItemListElement {
    ItemListElementType type;
    int position;
    String name;
    String? item;

    ItemListElement({
        required this.type,
        required this.position,
        required this.name,
        this.item,
    });

}

enum ItemListElementType {
    LIST_ITEM
}

class PotentialAction {
    PotentialActionType type;
    dynamic target;
    QueryInput? queryInput;

    PotentialAction({
        required this.type,
        required this.target,
        this.queryInput,
    });

}

class QueryInput {
    QueryInputType type;
    bool valueRequired;
    ValueName valueName;

    QueryInput({
        required this.type,
        required this.valueRequired,
        required this.valueName,
    });

}

enum QueryInputType {
    PROPERTY_VALUE_SPECIFICATION
}

enum ValueName {
    SEARCH_TERM_STRING
}

class TargetClass {
    TargetType type;
    UrlTemplate urlTemplate;

    TargetClass({
        required this.type,
        required this.urlTemplate,
    });

}

enum TargetType {
    ENTRY_POINT
}

enum UrlTemplate {
    HTTPS_SMKMADINATULQURAN_SCH_ID_S_SEARCH_TERM_STRING
}

enum PotentialActionType {
    READ_ACTION,
    SEARCH_ACTION
}

enum TwitterCard {
    SUMMARY_LARGE_IMAGE
}

class TwitterMisc {
    AuthorEnum writtenBy;
    EstReadingTime estReadingTime;

    TwitterMisc({
        required this.writtenBy,
        required this.estReadingTime,
    });

}

enum EstReadingTime {
    THE_2_MINUTES,
    THE_4_MINUTES
}
