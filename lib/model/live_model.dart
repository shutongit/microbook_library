class LiveModel {
  final int columnId;
  final String columnImg;
  final String companyId;
  final String companyLocation;
  final String companyName;
  final String content;
  final int flag;
  final int grade;
  final String h5Url;
  final int idLive;
  final String imgBigUrl;
  final String livelocation;
  final String livesubject;
  final int livetime;
  final String liveurl;
  final String logo;
  final String status;
  final String theme;

  LiveModel(
      {required this.columnId,
      required this.columnImg,
      required this.companyId,
      required this.companyLocation,
      required this.companyName,
      required this.content,
      required this.flag,
      required this.grade,
      required this.h5Url,
      required this.idLive,
      required this.imgBigUrl,
      required this.livelocation,
      required this.livesubject,
      required this.livetime,
      required this.liveurl,
      required this.logo,
      required this.status,
      required this.theme});

  factory LiveModel.fromJson(Map<String, dynamic> json) {
    return LiveModel(
      columnId: json['column_id'] ?? 0,
      columnImg: json['column_img'] ?? '',
      companyId: json['company_id'] ?? '',
      companyLocation: json['company_location'] ?? '',
      companyName: json['company_name'] ?? '',
      content: json['content'] ?? '',
      flag: json['flag'] ?? 0,
      grade: json['grade'] ?? 0,
      h5Url: json['h5_url'] ?? '',
      idLive: json['id_live'] ?? 0,
      imgBigUrl: json['img_big_url'] ?? '',
      livelocation: json['livelocation'] ?? '',
      livesubject: json['livesubject'] ?? '',
      livetime: json['livetime'] ?? 0,
      liveurl: json['liveurl'] ?? '',
      logo: isHttpLink(json['logo'])
          ? json['logo']
          : 'https://weice.cretech.cn/${json['logo']}',
      status: json['status'],
      theme: json['theme'],
    );
  }
}

/// 判断链接是否以http开头
bool isHttpLink(String url) {
  if (url.isEmpty) return false;
  return url.startsWith('http://') || url.startsWith('https://');
}
