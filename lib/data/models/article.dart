// TODO 1: Buat class Article
// 1. Buat class dengan properti: title, sourceName, author, description, url, imageUrl, publishedAt, content
// 2. Buat factory constructor `fromJson(Map<String, dynamic> json)`
// 3. Buat getter `cleanContent` untuk menghapus teks "[+... chars]" dari content
// 4. Buat getter `isValid` untuk memastikan artikel bukan "[Removed]"

class Article {
  // Siswi akan melengkapi bagian ini.
  const Article({
    required this.title,
    required this.sourceName,
    required this.url,
    required this.publishedAt,
    this.author,
    this.description,
    this.imageUrl,
    this.content,
  });

  final String title;
  final String sourceName;
  final String url;
  final DateTime? publishedAt;
  final String? author;
  final String? description;
  final String? imageUrl;
  final String? content;

  // Implementasi cleanContent
  String get cleanContent => (content ?? '').replaceAll(RegExp(r'\s*\[\+\d+ chars\]$'), '').trim(); // untuk menghapus teks "[+... chars]" dari content

  // Implementasi isValid, memastikan bahwa data yang kita panggil ada
  bool get isValid => title.isNotEmpty && title != '[Removed]' && url.isNotEmpty;

  // kalau data valid, maka kita bisa menampilkan data tersebut di UI
  @override
  bool operator == (Object other) => other is Article && other.url == url;

  @override
  int get hashCode => url.hashCode; // mengembalikan sebuah objek menjadi kode acak, hashCode
  // getter tersebut berfungsi mengubah semua objek menjadi kode acak, agar setiap objek yang dihasilkan khususnya dari API tetap aman.

  // Implementasi fromJson, untuk dikonversi menjadi bahasa Dart (bukan raw json)
  factory Article.fromJson(Map<String, dynamic> json) {
    final source = json['source'] as Map<String, dynamic>?;
    return Article(
      title: json['title'] as String? ?? '',
      url: json['url'] as String? ?? '', 
      sourceName: source?['name'] as String? ?? 'Tanpa Sumber',
      publishedAt: DateTime.tryParse(json['publishedAt'] as String? ?? ''),
      author: json['author'] as String?,
      description: json['description'] as String?,
      imageUrl: json['urlToImage'] as String?,
      content: json['content'] as String?
    );
  }

  // Implementasi toJson, untuk dikonversi menjadi raw json (bukan bahasa Dart) atau untuk mengkonfirmasi setelah data diambil dari API
  Map<String, dynamic> toJson() => {
    'title': title,
    'url': url,
    'source': {'name': sourceName},
    'description': description,
    'content': content,
    'author': author,
    'urlToImage': imageUrl,
    'publishedAt': publishedAt?.toIso8601String(),
  };

  // Dummy article untuk UI sementara
  static final dummy = Article(
    title: 'Berita Menarik Hari Ini',
    sourceName: 'Warta News',
    url: 'https://example.com',
    publishedAt: DateTime.now(),
    description: 'Ini adalah deskripsi berita sementara sebelum API disambungkan.',
    imageUrl: 'https://picsum.photos/400/200',
    content: 'Isi konten berita yang lebih panjang akan muncul di sini.',
  );
}
