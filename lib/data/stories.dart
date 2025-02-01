class Stories {
  List<Map<String, dynamic>> stories = [
    {
      "id": 1,
      "title": "سرقة خزنة",
      "accused": [
        {"type": "مُحاسب", "criminal": false},
        {"type": "مُهندس ديكور", "criminal": false},
        {"type": "مُوظف استقبال", "criminal": false},
        {"type": "كهربائي", "criminal": true},
      ],
      "evidence": [
        "الخزنة في فندق",
        "دافع الجريمة الانتقام",
        "المجرم كان كحيان (معهوش فلوس)",
      ],
      "story":
          "الفندق اتقلل فيه العمالة والكهربائي اتطرد من غير ما ياخذ فلوسه كاملة فا لما ملقاش شغل اضطر يسرق الفندق",
      "real": false,
      "source": "",
      "solved": false,
    },
    {
      "id": 2,
      "title": "اختفاء اللوحة الفنية",
      "accused": [
        {"type": "حارس أمن", "criminal": false},
        {"type": "فنان تشكيلي", "criminal": true},
        {"type": "منظف", "criminal": false},
        {"type": "زائر", "criminal": false},
      ],
      "evidence": [
        "اللوحة كانت في معرض فني",
        "دافع الجريمة كان الغيرة",
        "المجرم كان بيعاني من قلة التقدير",
      ],
      "story":
          "الفنان التشكيلي كان غيران من نجاح زميله، فقرر يسرق لوحته عشان يقلل من نجاحه.",
      "real": false,
      "source": "",
      "solved": false,
    },
    {
      "id": 3,
      "title": "تزوير الوثائق",
      "accused": [
        {"type": "موظف حكومي", "criminal": true},
        {"type": "مراجع حسابات", "criminal": false},
        {"type": "مواطن", "criminal": false},
        {"type": "محامٍ", "criminal": false},
      ],
      "evidence": [
        "اكتشاف وثائق مزورة",
        "دافع الجريمة كان الرشوة",
        "المجرم كان بيستغل منصبه",
      ],
      "story":
          "الموظف الحكومي كان بيزور وثائق رسمية مقابل رشاوي من الناس اللي محتاجة الأوراق دي.",
      "real": false,
      "source": "",
      "solved": false,
    },
  ];
}
