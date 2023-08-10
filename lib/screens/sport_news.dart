import 'package:flutter/material.dart';
import 'package:flutter_test_app/screens/sport_details_screen.dart';

import '../models/sport_item.dart';

class SportNews extends StatelessWidget {
  const SportNews({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: sportsItemList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SportDetailsScreen(
                  sportsItem: sportsItemList[index],
                ),
              ),
            );
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Image.network(
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      sportsItemList[index].imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    sportsItemList[index].name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      sportsItemList[index].description,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

List<SportsItem> sportsItemList = [
  SportsItem(
    name: "Football",
    imageUrl:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlFTc1mQRQQDe1cBkXHEr_KQiJiQ2haD8zJg&usqp=CAU",
    description:
        "A team sport where the goal is to score a ball into the opponent's goal.",
  ),
  SportsItem(
    name: "Tennis",
    imageUrl:
        "https://reviewed-com-res.cloudinary.com/image/fetch/s--UJ2sGByA--/b_white,c_limit,cs_srgb,f_auto,fl_progressive.strip_profile,g_center,q_auto,w_972/https://reviewed-production.s3.amazonaws.com/1597356287543/GettyImages-1171084311.jpg",
    description:
        "A game with a racket and a ball, where two players compete against each other.",
  ),
  SportsItem(
    name: "Basketball",
    imageUrl:
        "https://images.pexels.com/photos/1752757/pexels-photo-1752757.jpeg?cs=srgb&dl=pexels-markus-spiske-1752757.jpg&fm=jpg",
    description:
        "A team sport where the goal is to shoot a ball into the opponent's hoop.",
  ),
  SportsItem(
    name: "Running",
    imageUrl:
        "https://www.runtastic.com/blog/wp-content/uploads/2021/05/thumbnail_1200x800-2.jpg",
    description:
        "An individual sport where participants run on a track or course.",
  ),
  SportsItem(
    name: "Swimming",
    imageUrl:
        "https://img.jagranjosh.com/images/2021/August/582021/swimming.png",
    description: "A water sport involving different styles and distances.",
  ),
  SportsItem(
    name: "Gymnastics",
    imageUrl:
        "https://img.freepik.com/free-vector/silhouette-gymnast-watercolour-background_1048-16362.jpg?w=2000",
    description: "Acrobatic exercises requiring strength and flexibility.",
  ),
  SportsItem(
    name: "Cycling",
    imageUrl:
        "https://img.freepik.com/free-photo/professional-cyclist-woman_23-2149703285.jpg",
    description:
        "Competitions on bicycles, including road and mountain routes.",
  ),
  SportsItem(
    name: "Diving",
    imageUrl:
        "https://cdn.britannica.com/81/124081-050-740D9BE2/Scuba-diver.jpg",
    description:
        "The art of diving into water from various heights and positions.",
  ),
  SportsItem(
    name: "Boxing",
    imageUrl:
        "https://cdn.britannica.com/76/187976-050-7EF67E13/Floyd-Mayweather-Jr-ducks-Philippines-Manny-Pacquiao-May-2-2015.jpg",
    description: "A combat sport involving punches and protective gear.",
  ),
  SportsItem(
    name: "Hockey",
    imageUrl:
        "https://cdn.britannica.com/50/219150-050-0032E44D/Marc-Andre-Fleury-Vegas-Golden-Knights-Stanley-Cup-Final-2018.jpg",
    description: "A team sport played on ice with sticks and a puck.",
  ),
];
