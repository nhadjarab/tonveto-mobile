const String BASE_URL = "https://vetolib-backend-production.up.railway.app";
const String AI_URL = "http://ai.tonveto.com";
const String APP_NAME = "Tonveto";

const types = ["Chien", "Chat", "Autre"];

const Map<String, List<String>> animalsTypes = {
  "Chien": [
    "Akita Inu",
    "Alaskan Husky",
    "American Bully",
    "American Pitbull Terrier (Pitbull)",
    "American Staffordshire terrier",
    "Beagle",
    "Bearded Collie",
    "Beauceron (berger de Beauce)",
    "Berger allemand",
    "Berger australien",
    "Berger belge (Malinois)",
    "Bernedoodle",
    "Bichon maltais",
    "Bichon russe (Bolonka-Zwetna)",
    "Bobtail, berger anglais ancestral",
    "Border collie",
    "Bouledogue français",
    "Bouvier bernois",
    "Boxer allemand",
    "Brachet polonais (braque)",
    "Bull terrier",
    "Bulldog anglais",
    "Bullmastiff",
    "Cane corso",
    "Caniche nain",
    "Carlin",
    "Cavalier King Charles spaniel",
    "Chien de berger islandais",
    "Chien de montagne des Pyrénées",
    "Chien rouge de Bavière",
    "Chihuahua",
    "Chow-Chow",
    "Cockapoo",
    "Cocker Spaniel américain",
    "Cocker Spaniel anglais",
    "Dalmatien",
    "Dogue allemand",
    "Dogue argentin",
    "Dogue des Canaries",
    "Épagneul breton",
    "Golden Retriever",
    "Grand Spitz",
    "Husky de Sibérie",
    "Jack Russell Terrier",
    "Kelpie australien",
    "Eurasier",
    "Labrador Retriever",
    "Lévrier afghan",
    "Petit lévrier italien",
    "Petit spitz et spitz moyen",
    "Podenco andalou",
    "Rottweiler",
    "Samoyède",
    "Schnauzer moyen",
    "Schnauzer nain",
    "Setter anglais",
    "Shar pei",
    "Shiba Inu",
    "Shih tzu",
    "Spitz finlandais",
    "Spitz japonais",
    "Spitz loup ou Keeshbond",
    "Spitz nain (loulou de Poméranie)",
    "Staffordshire bull terrier (Staffie)",
    "Teckel",
    "Teckel nain",
    "Terre-Neuve",
    "Terrier australien",
    "West Highland White Terrier (Westie)",
    "Yorkshire Terrier",
  ],
  "Chat": [
    "Abyssin",
    "American Shorthair",
    "American Curl",
    "Balinais",
    "Angora Turc ",
    "Bleu Russe ",
    "Bengal",
    "Bombay ",
    "Bobtail japonais",
    "Burmese ",
    "British Shorthair",
    "Chartreux",
    "Burmilla",
    "Chinchilla",
    "Chat de gouttière",
    "Devon Rex",
    "Cornish Rex",
    "Exotic Shorthair",
    "Européen",
    "Havana Brown",
    "German Rex",
    "Korat",
    "Highland Fold",
    "Maine Coon ",
    "Laperm",
    "Manx ",
    "Mandarin",
    "Munchkin",
    "Mau Egyptien",
    "Norvégien",
    "Nebelung",
    "Oriental",
    "Ocicat ",
    "Ragdoll",
    "Persan ",
    "Scottish Fold",
    "Sacré de Birmanie",
    "Siamois",
    "Seregenti ",
    "Singapura",
    "Sibérien",
    "Sokoké",
    "Snowshoe",
    "Sphynx",
    "Somali",
    "Tonkinois",
    "Tiffany",
    "York Chocolate",
    "Turc de Van",
  ],
  "Autre": ["Autre"]
};

const List<String> species = [
  "dog",
  "cat",
  "poultry",
  "livestock",
  "cow",
  "hose",
  "goat",
  "sheep",
  "chicken",
  "turkey",
  "duck",
  "cattle",
  "pig",
  "donkey"
];
