import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'l10n_delegate.dart';
import 'messages_all.dart';

/// アプリでの文言はこれ経由で取得する
class L10n {
  /// 言語リソースを扱う
  ///
  /// localeは端末設定・アプリの指定を踏まえて最適なものが渡ってくる
  static Future<L10n> load(Locale locale) async {
    final name = locale.countryCode == null || locale.countryCode.isEmpty
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);

    // 言語リソース読み込み
    await initializeMessages(localeName);
    // デフォルト言語を設定
    Intl.defaultLocale = localeName;
    // 自身を返す
    return L10n();
  }

  // Widgetツリーから自身を取り出す
  static L10n of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n);
  }

  static const LocalizationsDelegate<L10n> delegate = L10nDelegate();

  // 以下、Intl.messageを用いて必要な文言を返すgetter・メソッドを定義

  String get list => Intl.message(
    'リスト',
    name: 'list',
    desc: 'TopPageButtonName', // オプション
  );

  String get challenge => Intl.message(
    'チャレンジ',
    name: 'challenge',
    desc: 'TopPageButtonName', // オプション
  );

  String get training => Intl.message(
    'トレーニング',
    name: 'training',
    desc: 'ChallengePageButtonName', // オプション
  );

  String get test => Intl.message(
    'テスト',
    name: 'test',
    desc: 'ChallengePageButtonName', // オプション
  );

  String get know => Intl.message(
    '知っている',
    name: 'know',
    desc: 'ResultTabValue', // オプション
  );

  String get unKnow => Intl.message(
    '知らない',
    name: 'unKnow',
    desc: 'ResultTabValue', // オプション
  );

  String get reload => Intl.message(
    '更新',
    name: 'reload',
    desc: 'FloatingActionButtonForReload', // オプション
  );

  String get back => Intl.message(
    '戻る',
    name: 'back',
    desc: 'FloatingActionButtonForBack', // オプション
  );

  String get search => Intl.message(
    '検索',
    name: 'search',
    desc: 'Search', // オプション
  );

  String get asiaForSearchCategory => Intl.message(
    'アジア',
    name: 'asiaForSearchCategory',
    desc: 'asiaForSearchCategory', // オプション
  );

  String get europeForSearchCategory => Intl.message(
    'ヨーロッパ',
    name: 'europeForSearchCategory',
    desc: 'europeForSearchCategory', // オプション
  );

  String get africaForSearchCategory => Intl.message(
    'アフリカ',
    name: 'africaForSearchCategory',
    desc: 'africaForSearchCategory', // オプション
  );

  String get northAmericaForSearchCategory => Intl.message(
    '北アメリカ',
    name: 'northAmericaForSearchCategory',
    desc: 'northAmericaForSearchCategory', // オプション
  );

  String get southAmericaForSearchCategory => Intl.message(
    '南アメリカ',
    name: 'southAmericaForSearchCategory',
    desc: 'southAmericaForSearchCategory', // オプション
  );

  String get oceaniaForSearchCategory => Intl.message(
    'オセアニア',
    name: 'oceaniaForSearchCategory',
    desc: 'oceaniaForSearchCategory', // オプション
  );

  String get andorraInCountryCategory => Intl.message(
    'アンドラ',
    name: 'andorraInCountryCategory',
    desc: 'andorraInCountryCategory', // オプション
  );

  String get areInCountryCategory => Intl.message(
    'アラブ首長国連邦',
    name: 'areInCountryCategory',
    desc: 'areInCountryCategory', // オプション
  );

  String get afghanistanInCountryCategory => Intl.message(
    'アフガニスタン',
    name: 'afghanistanInCountryCategory',
    desc: 'afghanistanInCountryCategory', // オプション
  );

  String get atgInCountryCategory => Intl.message(
    'アンティグア・バーブーダ',
    name: 'atgInCountryCategory',
    desc: 'atgInCountryCategory', // オプション
  );

  String get albaniaInCountryCategory => Intl.message(
    'アルバニア',
    name: 'albaniaInCountryCategory',
    desc: 'albaniaInCountryCategory', // オプション
  );

  String get armeniaInCountryCategory => Intl.message(
    'アルメニア',
    name: 'armeniaInCountryCategory',
    desc: 'armeniaInCountryCategory', // オプション
  );

  String get angolaInCountryCategory => Intl.message(
    'アンゴラ',
    name: 'angolaInCountryCategory',
    desc: 'angolaInCountryCategory', // オプション
  );

  String get argentinaInCountryCategory => Intl.message(
    'アルゼンチン',
    name: 'argentinaInCountryCategory',
    desc: 'argentinaInCountryCategory', // オプション
  );

  String get austriaInCountryCategory => Intl.message(
    'オーストリア',
    name: 'austriaInCountryCategory',
    desc: 'austriaInCountryCategory', // オプション
  );

  String get australiaInCountryCategory => Intl.message(
    'オーストラリア',
    name: 'australiaInCountryCategory',
    desc: 'australiaInCountryCategory', // オプション
  );

  String get azerbaijanInCountryCategory => Intl.message(
    'アゼルバイジャン',
    name: 'azerbaijanInCountryCategory',
    desc: 'azerbaijanInCountryCategory', // オプション
  );

  String get bihInCountryCategory => Intl.message(
    'ボスニア・ヘルツェゴビナ',
    name: 'bihInCountryCategory',
    desc: 'bihInCountryCategory', // オプション
  );

  String get barbadosInCountryCategory => Intl.message(
    'バルバドス',
    name: 'barbadosInCountryCategory',
    desc: 'barbadosInCountryCategory', // オプション
  );

  String get bangladeshInCountryCategory => Intl.message(
    'バングラデシュ',
    name: 'bangladeshInCountryCategory',
    desc: 'bangladeshInCountryCategory', // オプション
  );

  String get belgiumInCountryCategory => Intl.message(
    'ベルギー',
    name: 'belgiumInCountryCategory',
    desc: 'belgiumInCountryCategory', // オプション
  );

  String get bfaInCountryCategory => Intl.message(
    'ブルキナファソ',
    name: 'bfaInCountryCategory',
    desc: 'bfaInCountryCategory', // オプション
  );

  String get bulgariaInCountryCategory => Intl.message(
    'ブルガリア',
    name: 'bulgariaInCountryCategory',
    desc: 'bulgariaInCountryCategory', // オプション
  );

  String get bahrainInCountryCategory => Intl.message(
    'バーレーン',
    name: 'bahrainInCountryCategory',
    desc: 'bahrainInCountryCategory', // オプション
  );

  String get burundiInCountryCategory => Intl.message(
    'ブルンジ',
    name: 'burundiInCountryCategory',
    desc: 'burundiInCountryCategory', // オプション
  );

  String get beninInCountryCategory => Intl.message(
    'ベナン',
    name: 'beninInCountryCategory',
    desc: 'beninInCountryCategory', // オプション
  );

  String get brnInCountryCategory => Intl.message(
    'ブルネイ',
    name: 'brnInCountryCategory',
    desc: 'brnInCountryCategory', // オプション
  );

  String get bolInCountryCategory => Intl.message(
    'ボリビア',
    name: 'bolInCountryCategory',
    desc: 'bolInCountryCategory', // オプション
  );

  String get brazilInCountryCategory => Intl.message(
    'ブラジル',
    name: 'brazilInCountryCategory',
    desc: 'brazilInCountryCategory', // オプション
  );

  String get bahamasInCountryCategory => Intl.message(
    'バハマ',
    name: 'bahamasInCountryCategory',
    desc: 'bahamasInCountryCategory', // オプション
  );

  String get bhutanInCountryCategory => Intl.message(
    'ブータン王国',
    name: 'bhutanInCountryCategory',
    desc: 'bhutanInCountryCategory', // オプション
  );

  String get botswanaInCountryCategory => Intl.message(
    'ボツワナ',
    name: 'botswanaInCountryCategory',
    desc: 'botswanaInCountryCategory', // オプション
  );

  String get belarusInCountryCategory => Intl.message(
    'ベラルーシ',
    name: 'belarusInCountryCategory',
    desc: 'belarusInCountryCategory', // オプション
  );

  String get belizeInCountryCategory => Intl.message(
    'ベリーズ',
    name: 'belizeInCountryCategory',
    desc: 'belizeInCountryCategory', // オプション
  );

  String get canadaInCountryCategory => Intl.message(
    'カナダ',
    name: 'canadaInCountryCategory',
    desc: 'canadaInCountryCategory', // オプション
  );

  String get codInCountryCategory => Intl.message(
    'コンゴ民主共和国',
    name: 'codInCountryCategory',
    desc: 'codInCountryCategory', // オプション
  );

  String get cafInCountryCategory => Intl.message(
    '中央アフリカ共和国',
    name: 'cafInCountryCategory',
    desc: 'cafInCountryCategory', // オプション
  );

  String get cogInCountryCategory => Intl.message(
    'コンゴ',
    name: 'cogInCountryCategory',
    desc: 'cogInCountryCategory', // オプション
  );

  String get switzerlandInCountryCategory => Intl.message(
    'スイス',
    name: 'switzerlandInCountryCategory',
    desc: 'switzerlandInCountryCategory', // オプション
  );

  String get civInCountryCategory => Intl.message(
    'コートジボワール',
    name: 'civInCountryCategory',
    desc: 'civInCountryCategory', // オプション
  );

  String get cokInCountryCategory => Intl.message(
    'クック諸島',
    name: 'cokInCountryCategory',
    desc: 'cokInCountryCategory', // オプション
  );

  String get chileInCountryCategory => Intl.message(
    'チリ',
    name: 'chileInCountryCategory',
    desc: 'chileInCountryCategory', // オプション
  );

  String get cameroonInCountryCategory => Intl.message(
    'カメルーン',
    name: 'cameroonInCountryCategory',
    desc: 'cameroonInCountryCategory', // オプション
  );

  String get chinaInCountryCategory => Intl.message(
    '中国(中華人民共和国)',
    name: 'chinaInCountryCategory',
    desc: 'chinaInCountryCategory', // オプション
  );

  String get colombiaInCountryCategory => Intl.message(
    'コロンビア',
    name: 'colombiaInCountryCategory',
    desc: 'colombiaInCountryCategory', // オプション
  );

  String get criInCountryCategory => Intl.message(
    'コスタリカ',
    name: 'criInCountryCategory',
    desc: 'criInCountryCategory', // オプション
  );

  String get cubaInCountryCategory => Intl.message(
    'キューバ',
    name: 'cubaInCountryCategory',
    desc: 'cubaInCountryCategory', // オプション
  );

  String get cpvInCountryCategory => Intl.message(
    'カーボベルデ',
    name: 'cpvInCountryCategory',
    desc: 'cpvInCountryCategory', // オプション
  );

  String get cyprusInCountryCategory => Intl.message(
    'キプロス',
    name: 'cyprusInCountryCategory',
    desc: 'cyprusInCountryCategory', // オプション
  );

  String get czeInCountryCategory => Intl.message(
    'チェコ',
    name: 'czeInCountryCategory',
    desc: 'czeInCountryCategory', // オプション
  );

  String get germanyInCountryCategory => Intl.message(
    'ドイツ',
    name: 'germanyInCountryCategory',
    desc: 'germanyInCountryCategory', // オプション
  );

  String get djiboutiInCountryCategory => Intl.message(
    'ジブチ',
    name: 'djiboutiInCountryCategory',
    desc: 'djiboutiInCountryCategory', // オプション
  );

  String get denmarkInCountryCategory => Intl.message(
    'デンマーク',
    name: 'denmarkInCountryCategory',
    desc: 'denmarkInCountryCategory', // オプション
  );

  String get dominicaInCountryCategory => Intl.message(
    'ドミニカ',
    name: 'dominicaInCountryCategory',
    desc: 'dominicaInCountryCategory', // オプション
  );

  String get domInCountryCategory => Intl.message(
    'ドミニカ共和国',
    name: 'domInCountryCategory',
    desc: 'domInCountryCategory', // オプション
  );

  String get algeriaInCountryCategory => Intl.message(
    'アルジェリア',
    name: 'algeriaInCountryCategory',
    desc: 'algeriaInCountryCategory', // オプション
  );

  String get ecuadorInCountryCategory => Intl.message(
    'エクアドル',
    name: 'ecuadorInCountryCategory',
    desc: 'ecuadorInCountryCategory', // オプション
  );

  String get estoniaInCountryCategory => Intl.message(
    'エストニア',
    name: 'estoniaInCountryCategory',
    desc: 'estoniaInCountryCategory', // オプション
  );

  String get egyptInCountryCategory => Intl.message(
    'エジプト',
    name: 'egyptInCountryCategory',
    desc: 'egyptInCountryCategory', // オプション
  );

  String get eritreaInCountryCategory => Intl.message(
    'エリトリア',
    name: 'eritreaInCountryCategory',
    desc: 'eritreaInCountryCategory', // オプション
  );

  String get spainInCountryCategory => Intl.message(
    'スペイン',
    name: 'spainInCountryCategory',
    desc: 'spainInCountryCategory', // オプション
  );

  String get ethiopiaInCountryCategory => Intl.message(
    'エチオピア',
    name: 'ethiopiaInCountryCategory',
    desc: 'ethiopiaInCountryCategory', // オプション
  );

  String get finlandInCountryCategory => Intl.message(
    'フィンランド',
    name: 'finlandInCountryCategory',
    desc: 'finlandInCountryCategory', // オプション
  );

  String get fijiInCountryCategory => Intl.message(
    'フィジー',
    name: 'fijiInCountryCategory',
    desc: 'fijiInCountryCategory', // オプション
  );

  String get fsmInCountryCategory => Intl.message(
    'ミクロネシア連邦',
    name: 'fsmInCountryCategory',
    desc: 'fsmInCountryCategory', // オプション
  );

  String get franceInCountryCategory => Intl.message(
    'フランス',
    name: 'franceInCountryCategory',
    desc: 'franceInCountryCategory', // オプション
  );

  String get gabonInCountryCategory => Intl.message(
    'ガボン',
    name: 'gabonInCountryCategory',
    desc: 'gabonInCountryCategory', // オプション
  );

  String get gbrInCountryCategory => Intl.message(
    'イギリス',
    name: 'gbrInCountryCategory',
    desc: 'gbrInCountryCategory', // オプション
  );

  String get grenadaInCountryCategory => Intl.message(
    'グレナダ',
    name: 'grenadaInCountryCategory',
    desc: 'grenadaInCountryCategory', // オプション
  );

  String get georgiaInCountryCategory => Intl.message(
    'ジョージア',
    name: 'georgiaInCountryCategory',
    desc: 'georgiaInCountryCategory', // オプション
  );

  String get ghanaInCountryCategory => Intl.message(
    'ガーナ',
    name: 'ghanaInCountryCategory',
    desc: 'ghanaInCountryCategory', // オプション
  );

  String get gambiaInCountryCategory => Intl.message(
    'ガンビア',
    name: 'gambiaInCountryCategory',
    desc: 'gambiaInCountryCategory', // オプション
  );

  String get guineaInCountryCategory => Intl.message(
    'ギニア',
    name: 'guineaInCountryCategory',
    desc: 'guineaInCountryCategory', // オプション
  );

  String get gnqInCountryCategory => Intl.message(
    '赤道ギニア',
    name: 'gnqInCountryCategory',
    desc: 'gnqInCountryCategory', // オプション
  );

  String get greeceInCountryCategory => Intl.message(
    'ギリシャ',
    name: 'greeceInCountryCategory',
    desc: 'greeceInCountryCategory', // オプション
  );

  String get guatemalaInCountryCategory => Intl.message(
    'グアテマラ',
    name: 'guatemalaInCountryCategory',
    desc: 'guatemalaInCountryCategory', // オプション
  );

  String get gnbInCountryCategory => Intl.message(
    'ギニアビサウ',
    name: 'gnbInCountryCategory',
    desc: 'gnbInCountryCategory', // オプション
  );

  String get guyanaInCountryCategory => Intl.message(
    'ガイアナ',
    name: 'guyanaInCountryCategory',
    desc: 'guyanaInCountryCategory', // オプション
  );

  String get hondurasInCountryCategory => Intl.message(
    'ホンジュラス',
    name: 'hondurasInCountryCategory',
    desc: 'hondurasInCountryCategory', // オプション
  );

  String get croatiaInCountryCategory => Intl.message(
    'クロアチア',
    name: 'croatiaInCountryCategory',
    desc: 'croatiaInCountryCategory', // オプション
  );

  String get haitiInCountryCategory => Intl.message(
    'ハイチ',
    name: 'haitiInCountryCategory',
    desc: 'haitiInCountryCategory', // オプション
  );

  String get hungaryInCountryCategory => Intl.message(
    'ハンガリー',
    name: 'hungaryInCountryCategory',
    desc: 'hungaryInCountryCategory', // オプション
  );

  String get indonesiaInCountryCategory => Intl.message(
    'インドネシア',
    name: 'indonesiaInCountryCategory',
    desc: 'indonesiaInCountryCategory', // オプション
  );

  String get irelandInCountryCategory => Intl.message(
    'アイルランド',
    name: 'irelandInCountryCategory',
    desc: 'irelandInCountryCategory', // オプション
  );

  String get israelInCountryCategory => Intl.message(
    'イスラエル',
    name: 'israelInCountryCategory',
    desc: 'israelInCountryCategory', // オプション
  );

  String get indiaInCountryCategory => Intl.message(
    'インド',
    name: 'indiaInCountryCategory',
    desc: 'indiaInCountryCategory', // オプション
  );

  String get iraqInCountryCategory => Intl.message(
    'イラク',
    name: 'iraqInCountryCategory',
    desc: 'iraqInCountryCategory', // オプション
  );

  String get irnInCountryCategory => Intl.message(
    'イラン',
    name: 'irnInCountryCategory',
    desc: 'irnInCountryCategory', // オプション
  );

  String get icelandInCountryCategory => Intl.message(
    'アイスランド',
    name: 'icelandInCountryCategory',
    desc: 'icelandInCountryCategory', // オプション
  );

  String get italyInCountryCategory => Intl.message(
    'イタリア',
    name: 'italyInCountryCategory',
    desc: 'italyInCountryCategory', // オプション
  );

  String get jamaicaInCountryCategory => Intl.message(
    'ジャマイカ',
    name: 'jamaicaInCountryCategory',
    desc: 'jamaicaInCountryCategory', // オプション
  );

  String get jordanInCountryCategory => Intl.message(
    'ヨルダン',
    name: 'jordanInCountryCategory',
    desc: 'jordanInCountryCategory', // オプション
  );

  String get japanInCountryCategory => Intl.message(
    '日本',
    name: 'japanInCountryCategory',
    desc: 'japanInCountryCategory', // オプション
  );

  String get kenyaInCountryCategory => Intl.message(
    'ケニア',
    name: 'kenyaInCountryCategory',
    desc: 'kenyaInCountryCategory', // オプション
  );

  String get kyrgyzstanInCountryCategory => Intl.message(
    'キルギス',
    name: 'kyrgyzstanInCountryCategory',
    desc: 'kyrgyzstanInCountryCategory', // オプション
  );

  String get cambodiaInCountryCategory => Intl.message(
    'カンボジア',
    name: 'cambodiaInCountryCategory',
    desc: 'cambodiaInCountryCategory', // オプション
  );

  String get kiribatiInCountryCategory => Intl.message(
    'キリバス',
    name: 'kiribatiInCountryCategory',
    desc: 'kiribatiInCountryCategory', // オプション
  );

  String get comorosInCountryCategory => Intl.message(
    'コモロ',
    name: 'comorosInCountryCategory',
    desc: 'comorosInCountryCategory', // オプション
  );

  String get knaInCountryCategory => Intl.message(
    'セントクリストファー・ネイビス',
    name: 'knaInCountryCategory',
    desc: 'knaInCountryCategory', // オプション
  );

  String get prkInCountryCategory => Intl.message(
    '北朝鮮(朝鮮民主主義人民共和国)',
    name: 'prkInCountryCategory',
    desc: 'prkInCountryCategory', // オプション
  );

  String get korInCountryCategory => Intl.message(
    '韓国(大韓民国)',
    name: 'korInCountryCategory',
    desc: 'korInCountryCategory', // オプション
  );

  String get kuwaitInCountryCategory => Intl.message(
    'クウェート',
    name: 'kuwaitInCountryCategory',
    desc: 'kuwaitInCountryCategory', // オプション
  );

  String get kazakhstanInCountryCategory => Intl.message(
    'カザフスタン',
    name: 'kazakhstanInCountryCategory',
    desc: 'kazakhstanInCountryCategory', // オプション
  );

  String get laoInCountryCategory => Intl.message(
    'ラオス人民民主共和国',
    name: 'laoInCountryCategory',
    desc: 'laoInCountryCategory', // オプション
  );

  String get lebanonInCountryCategory => Intl.message(
    'レバノン',
    name: 'lebanonInCountryCategory',
    desc: 'lebanonInCountryCategory', // オプション
  );

  String get lcaInCountryCategory => Intl.message(
    'セントルシア',
    name: 'lcaInCountryCategory',
    desc: 'lcaInCountryCategory', // オプション
  );

  String get liechtensteinInCountryCategory => Intl.message(
    'リヒテンシュタイン',
    name: 'liechtensteinInCountryCategory',
    desc: 'liechtensteinInCountryCategory', // オプション
  );

  String get lkaInCountryCategory => Intl.message(
    'スリランカ',
    name: 'lkaInCountryCategory',
    desc: 'lkaInCountryCategory', // オプション
  );

  String get liberiaInCountryCategory => Intl.message(
    'リベリア',
    name: 'liberiaInCountryCategory',
    desc: 'liberiaInCountryCategory', // オプション
  );

  String get lesothoInCountryCategory => Intl.message(
    'レソト',
    name: 'lesothoInCountryCategory',
    desc: 'lesothoInCountryCategory', // オプション
  );

  String get lithuaniaInCountryCategory => Intl.message(
    'リトアニア',
    name: 'lithuaniaInCountryCategory',
    desc: 'lithuaniaInCountryCategory', // オプション
  );

  String get luxembourgInCountryCategory => Intl.message(
    'ルクセンブルク',
    name: 'luxembourgInCountryCategory',
    desc: 'luxembourgInCountryCategory', // オプション
  );

  String get latviaInCountryCategory => Intl.message(
    'ラトビア',
    name: 'latviaInCountryCategory',
    desc: 'latviaInCountryCategory', // オプション
  );

  String get libyaInCountryCategory => Intl.message(
    'リビア',
    name: 'libyaInCountryCategory',
    desc: 'libyaInCountryCategory', // オプション
  );

  String get moroccoInCountryCategory => Intl.message(
    'モロッコ',
    name: 'moroccoInCountryCategory',
    desc: 'moroccoInCountryCategory', // オプション
  );

  String get monacoInCountryCategory => Intl.message(
    'モナコ公国',
    name: 'monacoInCountryCategory',
    desc: 'monacoInCountryCategory', // オプション
  );

  String get mdaInCountryCategory => Intl.message(
    'モルドバ',
    name: 'mdaInCountryCategory',
    desc: 'mdaInCountryCategory', // オプション
  );

  String get montenegroInCountryCategory => Intl.message(
    'モンテネグロ',
    name: 'montenegroInCountryCategory',
    desc: 'montenegroInCountryCategory', // オプション
  );

  String get madagascarInCountryCategory => Intl.message(
    'マダガスカル',
    name: 'madagascarInCountryCategory',
    desc: 'madagascarInCountryCategory', // オプション
  );

  String get mhlInCountryCategory => Intl.message(
    'マーシャル諸島',
    name: 'mhlInCountryCategory',
    desc: 'mhlInCountryCategory', // オプション
  );

  String get mkdInCountryCategory => Intl.message(
    '北マケドニア',
    name: 'mkdInCountryCategory',
    desc: 'mkdInCountryCategory', // オプション
  );

  String get maliInCountryCategory => Intl.message(
    'マリ',
    name: 'maliInCountryCategory',
    desc: 'maliInCountryCategory', // オプション
  );

  String get myanmarInCountryCategory => Intl.message(
    'ミャンマー',
    name: 'myanmarInCountryCategory',
    desc: 'myanmarInCountryCategory', // オプション
  );

  String get mongoliaInCountryCategory => Intl.message(
    'モンゴル',
    name: 'mongoliaInCountryCategory',
    desc: 'mongoliaInCountryCategory', // オプション
  );

  String get mauritaniaInCountryCategory => Intl.message(
    'モーリタニア',
    name: 'mauritaniaInCountryCategory',
    desc: 'mauritaniaInCountryCategory', // オプション
  );

  String get maltaInCountryCategory => Intl.message(
    'マルタ',
    name: 'maltaInCountryCategory',
    desc: 'maltaInCountryCategory', // オプション
  );

  String get mauritiusInCountryCategory => Intl.message(
    'モーリシャス',
    name: 'mauritiusInCountryCategory',
    desc: 'mauritiusInCountryCategory', // オプション
  );

  String get maldivesInCountryCategory => Intl.message(
    'モルディブ',
    name: 'maldivesInCountryCategory',
    desc: 'maldivesInCountryCategory', // オプション
  );

  String get malawiInCountryCategory => Intl.message(
    'マラウイ',
    name: 'malawiInCountryCategory',
    desc: 'malawiInCountryCategory', // オプション
  );

  String get mexicoInCountryCategory => Intl.message(
    'メキシコ',
    name: 'mexicoInCountryCategory',
    desc: 'mexicoInCountryCategory', // オプション
  );

  String get malaysiaInCountryCategory => Intl.message(
    'マレーシア',
    name: 'malaysiaInCountryCategory',
    desc: 'malaysiaInCountryCategory', // オプション
  );

  String get mozambiqueInCountryCategory => Intl.message(
    'モザンビーク',
    name: 'mozambiqueInCountryCategory',
    desc: 'mozambiqueInCountryCategory', // オプション
  );

  String get namibiaInCountryCategory => Intl.message(
    'ナミビア',
    name: 'namibiaInCountryCategory',
    desc: 'namibiaInCountryCategory', // オプション
  );

  String get nigerInCountryCategory => Intl.message(
    'ニジェール',
    name: 'nigerInCountryCategory',
    desc: 'nigerInCountryCategory', // オプション
  );

  String get nigeriaInCountryCategory => Intl.message(
    'ナイジェリア',
    name: 'nigeriaInCountryCategory',
    desc: 'nigeriaInCountryCategory', // オプション
  );

  String get nicaraguaInCountryCategory => Intl.message(
    'ニカラグア',
    name: 'nicaraguaInCountryCategory',
    desc: 'nicaraguaInCountryCategory', // オプション
  );

  String get netherlandsInCountryCategory => Intl.message(
    'オランダ',
    name: 'netherlandsInCountryCategory',
    desc: 'netherlandsInCountryCategory', // オプション
  );

  String get norwayInCountryCategory => Intl.message(
    'ノルウェー',
    name: 'norwayInCountryCategory',
    desc: 'norwayInCountryCategory', // オプション
  );

  String get nepalInCountryCategory => Intl.message(
    'ネパール',
    name: 'nepalInCountryCategory',
    desc: 'nepalInCountryCategory', // オプション
  );

  String get nauruInCountryCategory => Intl.message(
    'ナウル',
    name: 'nauruInCountryCategory',
    desc: 'nauruInCountryCategory', // オプション
  );

  String get niueInCountryCategory => Intl.message(
    'ニウエ',
    name: 'niueInCountryCategory',
    desc: 'niueInCountryCategory', // オプション
  );

  String get nzlInCountryCategory => Intl.message(
    'ニュージーランド',
    name: 'nzlInCountryCategory',
    desc: 'nzlInCountryCategory', // オプション
  );

  String get omanInCountryCategory => Intl.message(
    'オマーン',
    name: 'omanInCountryCategory',
    desc: 'omanInCountryCategory', // オプション
  );

  String get panamaInCountryCategory => Intl.message(
    'パナマ',
    name: 'panamaInCountryCategory',
    desc: 'panamaInCountryCategory', // オプション
  );

  String get peruInCountryCategory => Intl.message(
    'ペルー',
    name: 'peruInCountryCategory',
    desc: 'peruInCountryCategory', // オプション
  );

  String get pngInCountryCategory => Intl.message(
    'パプア・ニューギニア',
    name: 'pngInCountryCategory',
    desc: 'pngInCountryCategory', // オプション
  );

  String get philippinesInCountryCategory => Intl.message(
    'フィリピン',
    name: 'philippinesInCountryCategory',
    desc: 'philippinesInCountryCategory', // オプション
  );

  String get pakistanInCountryCategory => Intl.message(
    'パキスタン',
    name: 'pakistanInCountryCategory',
    desc: 'pakistanInCountryCategory', // オプション
  );

  String get polandInCountryCategory => Intl.message(
    'ポーランド',
    name: 'polandInCountryCategory',
    desc: 'polandInCountryCategory', // オプション
  );

  String get portugalInCountryCategory => Intl.message(
    'ポルトガル',
    name: 'portugalInCountryCategory',
    desc: 'portugalInCountryCategory', // オプション
  );

  String get palauInCountryCategory => Intl.message(
    'パラオ',
    name: 'palauInCountryCategory',
    desc: 'palauInCountryCategory', // オプション
  );

  String get paraguayInCountryCategory => Intl.message(
    'パラグアイ',
    name: 'paraguayInCountryCategory',
    desc: 'paraguayInCountryCategory', // オプション
  );

  String get qatarInCountryCategory => Intl.message(
    'カタール',
    name: 'qatarInCountryCategory',
    desc: 'qatarInCountryCategory', // オプション
  );

  String get romaniaInCountryCategory => Intl.message(
    'ルーマニア',
    name: 'romaniaInCountryCategory',
    desc: 'romaniaInCountryCategory', // オプション
  );

  String get serbiaInCountryCategory => Intl.message(
    'セルビア',
    name: 'serbiaInCountryCategory',
    desc: 'serbiaInCountryCategory', // オプション
  );

  String get rusInCountryCategory => Intl.message(
    'ロシア',
    name: 'rusInCountryCategory',
    desc: 'rusInCountryCategory', // オプション
  );


  String get rwandaInCountryCategory => Intl.message(
    'ルワンダ',
    name: 'rwandaInCountryCategory',
    desc: 'rwandaInCountryCategory', // オプション
  );


  String get sauInCountryCategory => Intl.message(
    'サウジアラビア',
    name: 'sauInCountryCategory',
    desc: 'sauInCountryCategory', // オプション
  );


  String get slbInCountryCategory => Intl.message(
    'ソロモン諸島',
    name: 'slbInCountryCategory',
    desc: 'slbInCountryCategory', // オプション
  );


  String get seychellesInCountryCategory => Intl.message(
    'セーシェル',
    name: 'seychellesInCountryCategory',
    desc: 'seychellesInCountryCategory', // オプション
  );

  String get sudanInCountryCategory => Intl.message(
    'スーダン',
    name: 'sudanInCountryCategory',
    desc: 'sudanInCountryCategory', // オプション
  );

  String get swedenInCountryCategory => Intl.message(
    'スウェーデン',
    name: 'swedenInCountryCategory',
    desc: 'swedenInCountryCategory', // オプション
  );

  String get singaporeInCountryCategory => Intl.message(
    'シンガポール',
    name: 'singaporeInCountryCategory',
    desc: 'singaporeInCountryCategory', // オプション
  );

  String get sloveniaInCountryCategory => Intl.message(
    'スロベニア',
    name: 'sloveniaInCountryCategory',
    desc: 'sloveniaInCountryCategory', // オプション
  );


  String get slovakiaInCountryCategory => Intl.message(
    'スロバキア',
    name: 'slovakiaInCountryCategory',
    desc: 'slovakiaInCountryCategory', // オプション
  );


  String get sleInCountryCategory => Intl.message(
    'シエラレオネ',
    name: 'sleInCountryCategory',
    desc: 'sleInCountryCategory', // オプション
  );


  String get smrInCountryCategory => Intl.message(
    'サンマリノ',
    name: 'smrInCountryCategory',
    desc: 'smrInCountryCategory', // オプション
  );


  String get senegalInCountryCategory => Intl.message(
    'セネガル',
    name: 'senegalInCountryCategory',
    desc: 'senegalInCountryCategory', // オプション
  );


  String get somaliaInCountryCategory => Intl.message(
    'ソマリア',
    name: 'somaliaInCountryCategory',
    desc: 'somaliaInCountryCategory', // オプション
  );


  String get surinameInCountryCategory => Intl.message(
    'スリナム',
    name: 'surinameInCountryCategory',
    desc: 'surinameInCountryCategory', // オプション
  );


  String get ssdInCountryCategory => Intl.message(
    '南スーダン',
    name: 'ssdInCountryCategory',
    desc: 'ssdInCountryCategory', // オプション
  );


  String get stpInCountryCategory => Intl.message(
    'サントメ・プリンシペ',
    name: 'stpInCountryCategory',
    desc: 'stpInCountryCategory', // オプション
  );


  String get slvInCountryCategory => Intl.message(
    'エルサルバドル',
    name: 'slvInCountryCategory',
    desc: 'slvInCountryCategory', // オプション
  );


  String get syrInCountryCategory => Intl.message(
    'シリア',
    name: 'syrInCountryCategory',
    desc: 'syrInCountryCategory', // オプション
  );


  String get swzInCountryCategory => Intl.message(
    'エスワティニ',
    name: 'swzInCountryCategory',
    desc: 'swzInCountryCategory', // オプション
  );


  String get chadInCountryCategory => Intl.message(
    'チャド',
    name: 'chadInCountryCategory',
    desc: 'chadInCountryCategory', // オプション
  );


  String get togoInCountryCategory => Intl.message(
    'トーゴ',
    name: 'togoInCountryCategory',
    desc: 'togoInCountryCategory', // オプション
  );


  String get thailandInCountryCategory => Intl.message(
    'タイ',
    name: 'thailandInCountryCategory',
    desc: 'thailandInCountryCategory', // オプション
  );


  String get tajikistanInCountryCategory => Intl.message(
    'タジキスタン',
    name: 'tajikistanInCountryCategory',
    desc: 'tajikistanInCountryCategory', // オプション
  );


  String get tlsInCountryCategory => Intl.message(
    '東ティモール',
    name: 'tlsInCountryCategory',
    desc: 'tlsInCountryCategory', // オプション
  );


  String get turkmenistanInCountryCategory => Intl.message(
    'トルクメニスタン',
    name: 'turkmenistanInCountryCategory',
    desc: 'turkmenistanInCountryCategory', // オプション
  );


  String get tunisiaInCountryCategory => Intl.message(
    'チュニジア',
    name: 'tunisiaInCountryCategory',
    desc: 'tunisiaInCountryCategory', // オプション
  );


  String get tongaInCountryCategory => Intl.message(
    'トンガ',
    name: 'tongaInCountryCategory',
    desc: 'tongaInCountryCategory', // オプション
  );


  String get turkeyInCountryCategory => Intl.message(
    'トルコ',
    name: 'turkeyInCountryCategory',
    desc: 'turkeyInCountryCategory', // オプション
  );


  String get ttoInCountryCategory => Intl.message(
    'トリニダード・トバゴ',
    name: 'ttoInCountryCategory',
    desc: 'ttoInCountryCategory', // オプション
  );


  String get tuvaluInCountryCategory => Intl.message(
    'ツバル',
    name: 'tuvaluInCountryCategory',
    desc: 'tuvaluInCountryCategory', // オプション
  );


  String get taiwanInCountryCategory => Intl.message(
    '中華民国(中国台湾省)',
    name: 'taiwanInCountryCategory',
    desc: 'taiwanInCountryCategory', // オプション
  );


  String get tzaInCountryCategory => Intl.message(
    'タンザニア',
    name: 'tzaInCountryCategory',
    desc: 'tzaInCountryCategory', // オプション
  );


  String get ukrInCountryCategory => Intl.message(
    'ウクライナ',
    name: 'ukrInCountryCategory',
    desc: 'ukrInCountryCategory', // オプション
  );


  String get ugaInCountryCategory => Intl.message(
    'ウガンダ',
    name: 'ugaInCountryCategory',
    desc: 'ugaInCountryCategory', // オプション
  );


  String get usaInCountryCategory => Intl.message(
    'アメリカ合衆国',
    name: 'usaInCountryCategory',
    desc: 'usaInCountryCategory', // オプション
  );


  String get uruguayInCountryCategory => Intl.message(
    'ウルグアイ',
    name: 'uruguayInCountryCategory',
    desc: 'uruguayInCountryCategory', // オプション
  );


  String get uzbekistanInCountryCategory => Intl.message(
    'ウズベキスタン',
    name: 'uzbekistanInCountryCategory',
    desc: 'uzbekistanInCountryCategory', // オプション
  );


  String get vatInCountryCategory => Intl.message(
    'バチカン市国',
    name: 'vatInCountryCategory',
    desc: 'vatInCountryCategory', // オプション
  );

  String get vctInCountryCategory => Intl.message(
    'セントビンセントおよびグレナディーン諸島',
    name: 'vctInCountryCategory',
    desc: 'vctInCountryCategory', // オプション
  );


  String get venInCountryCategory => Intl.message(
    'ベネズエラ',
    name: 'venInCountryCategory',
    desc: 'venInCountryCategory', // オプション
  );


  String get vietnamInCountryCategory => Intl.message(
    'ベトナム',
    name: 'vietnamInCountryCategory',
    desc: 'vietnamInCountryCategory', // オプション
  );


  String get vanuatuInCountryCategory => Intl.message(
    'バヌアツ',
    name: 'vanuatuInCountryCategory',
    desc: 'vanuatuInCountryCategory', // オプション
  );


  String get kosovoInCountryCategory => Intl.message(
    'コソボ',
    name: 'kosovoInCountryCategory',
    desc: 'kosovoInCountryCategory', // オプション
  );


  String get samoaInCountryCategory => Intl.message(
    'サモア',
    name: 'samoaInCountryCategory',
    desc: 'samoaInCountryCategory', // オプション
  );


  String get yemenInCountryCategory => Intl.message(
    'イエメン',
    name: 'yemenInCountryCategory',
    desc: 'yemenInCountryCategory', // オプション
  );


  String get zafInCountryCategory => Intl.message(
    '南アフリカ',
    name: 'zafInCountryCategory',
    desc: 'zafInCountryCategory', // オプション
  );


  String get zambiaInCountryCategory => Intl.message(
    'ザンビア',
    name: 'zambiaInCountryCategory',
    desc: 'zambiaInCountryCategory', // オプション
  );


  String get zimbabweInCountryCategory => Intl.message(
    'ジンバブエ',
    name: 'zimbabweInCountryCategory',
    desc: 'zimbabweInCountryCategory', // オプション
  );

  String get notFoundForSearchResult => Intl.message(
    '国が見つかりませんでした',
    name: 'notFoundForSearchResult',
    desc: 'notFoundForSearchResult', // オプション
  );


}