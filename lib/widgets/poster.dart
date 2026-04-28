// ─── Poster Model ─────────────────────────────────────────────────────────────

class Poster {
  String? title;
  String image;

  Poster(this.image, {this.title});
}

// ─── Poster Data ──────────────────────────────────────────────────────────────

List<Poster> poster1 = [
  Poster(
    "https://www.chipmongbank.com.kh/api/images/aac7ae7e-0f20-41be-b6f3-130e4084d3cb.jpg",
    title:
        'កាន់តែចំណាយ កាន់តែចំណេញ ជាមួChip Mong Bank App\n រហូតដល់:31 ខែឧសភា​ ឆ្នាំ 2026 ',
  ),
  Poster(
    "https://www.chipmongbank.com.kh/api/images/4c8fa166-9576-4662-9297-1bcdeb5d0391.jpg",
    title:
        'កម្មវិធីផ្ដល់ប្រាក់រង្វាន់លើកទឹកចិត្តសម្រាប់អាជីវករដែលប្រើប្រាស់ KHQR ធនាគារ ជីប ម៉ុង\n រហូតដល់:30 ខែ មិថុនា ឆ្នាំ 2026 ',
  ),
   Poster(
    "https://www.chipmongbank.com.kh/api/images/8b0afa9d-9590-41b6-985d-fe63e02ee518.jpg",
    title: 
    'ចំណាយក្លាយជាសន្សំ គ្រាន់តែទូទាត់វិក្កយបត្រភ្លើង\n រហូតដល់:30 ខែ មិថុនា ឆ្នាំ 2026',
  ),
];

List<Poster> poster2 = [
  Poster(
    "https://www.chipmongbank.com.kh/api/images/9951aa9f-e949-4561-81bf-2e97d1ffe042.png",
  ),
  Poster(
    "https://www.chipmongbank.com.kh/api/images/0da4709c-b11c-4a84-afed-19193b3566cb.jpg",
  ),
  Poster(
    "https://www.chipmongbank.com.kh/api/images/9c8dcd64-f12c-49fc-b31d-d4ebacffc23e.png",
  ),
];

List<Poster> poster3 = [
  Poster(
    "https://image.freshnewsasia.com/2020/id-024/fn-2021-02-28-14-59-29-0.jpg",
  ),
  Poster(
    "https://www.chipmongbank.com.kh/api/images/777fb1a3-cada-433e-801d-d0fa874e869a.jpg",
  ),
  Poster(
    "https://moi-static.sgp1.cdn.digitaloceanspaces.com/uploads/post/feature_image/15980/feature.jpeg",
  ),

  Poster(
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIzALxlshV4zRUTVKZ2L-NUnzZsBT6Sy9JcA&s",
  ),
];

// ─── ProductItem Model ────────────────────────────────────────────────────────

class ProductItem {
  final String titleKh;
  final String descriptionKh;
  final Poster poster;

  const ProductItem({
    required this.titleKh,
    required this.descriptionKh,
    required this.poster,
  });

  String get imageUrl => poster.image;
}

// ─── ProductItem Data ─────────────────────────────────────────────────────────

List<ProductItem> productList = [
  ProductItem(
    titleKh: 'កម្ចីរហ័ស',
    descriptionKh:
        'ប្រើប្រាស់និកប្រាក់របស់អ្នកដោយប្ដូរ\nចំាចំបិទនុរដាសីបភ្លើមាន​កាល\nកំណត់ និងមានបោត់របស់នុវ​ការប្រាក់ដ...',
    poster: poster3[0],
  ),
  ProductItem(
    titleKh: 'កម្ចីអាជីវកម្ម',
    descriptionKh: 'គាំទ្រកំណើនអាជីវកម្មរបស់អ្នក',
    poster: poster3[1],
  ),
  ProductItem(
    titleKh: 'កម្ចីផ្ទាល់ខ្លួន',
    descriptionKh: 'សម្រាប់តម្រូវការសាច់ប្រាក់រយពេលខ្លីរបស់អ្នក',
    poster: poster3[2],
  ),

  ProductItem(
    titleKh: 'កម្ចីគេហដ្ឋាន',
    descriptionKh: 'ទិញផ្ទះក្នុងក្ដីស្រមៃរបស់អ្នកបានយ៉ាងងាយស្រួល',
    poster: poster3[3],
  ),
];
