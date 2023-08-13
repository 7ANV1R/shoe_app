class Shoe {
  Shoe({
    required this.name,
    required this.price,
    required this.img,
    required this.prodPrimaryColor,
    required this.description,
  });
  String name;
  double price;
  String img;
  String prodPrimaryColor;
  String description;

  static List<Shoe> productList = [
    Shoe(
      name: 'Nike Dunk Hi Retro',
      price: 125,
      img: 'assets/shoe/shoe0.png',
      prodPrimaryColor: 'be0000',
      description:
          "Created for the hardwood but taken to the streets, the b-ball icon returns with crisp synthetic leather and retro colors. The classic design channels '80s vintage back onto the streets while the padded, high-top collar adds an old-school look rooted to comfort.",
    ),
    Shoe(
      name: 'Air Jordan 1 Retro High OG',
      price: 180,
      img: 'assets/shoe/shoe1.png',
      prodPrimaryColor: '005891',
      description:
          "Game on! Inspired by MJ's high school days, this energetic colorway brings A+ energy to the streets. Bold bursts of Game Royal and Varsity Maize let you join the team in style, while subtly weathered leather ups the vintage appeal. Crafted details like the woven tongue label, hangtag and Wings logo add a premium boost to any 'fit. And the finishing touch? Nike Air cushioning underfoot lets you keep pace, so nothing holds you back from showing off your legendary look.",
    ),
    Shoe(
      name: 'Air Jordan 1 Mid SE',
      price: 135,
      img: 'assets/shoe/shoe2.png',
      prodPrimaryColor: '673335',
      description:
          "Dope sneakers count as self-care. And with colors inspired by the aisles of your neighborhood beauty supply store (plus cloud-like Nike Air cushioning underfoot), these mid-top J's will have you feeling anything but mid. Go ahead—treat yourself.",
    ),
    Shoe(
      name: 'Nike Dunk High Retro',
      price: 135,
      img: 'assets/shoe/shoe3.png',
      prodPrimaryColor: 'eb4835',
      description:
          "Created for the hardwood but taken to the streets, the '80s b-ball icon returns with perfectly sheened overlays and original university colors. With its classic hoops design, the Nike Dunk High Retro channels '80s vintage back onto the streets while its padded, high-top collar adds an old-school look rooted in comfort.",
    ),
  ];
}
