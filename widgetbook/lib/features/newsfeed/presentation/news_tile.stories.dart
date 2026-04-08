import "package:flutter/material.dart";
import "package:topwr/features/newsfeed/data/models/newsfeed_models.dart";
import "package:topwr/features/newsfeed/presentation/news_list_view.dart";
import "package:widgetbook/widgetbook.dart";

part "news_tile.stories.g.dart";

const _productionArticle = Article(
  imageLink:
      "https://pwr.edu.pl/files/cache/1/pl/24/1861287/DGBUXFA1dbQ1kCEJpWlsGTxYCARclCU9YWGlDQTkeHm9ZBU5nRlVtDXdAGHpEQVJBDlAdLTseT05LNkMLRBRXOhsGS39UQXcCYBIJ/miniatura_politechica_nova_1020x720_2024.webp",
  title: "15 pomysłów na naszą uczelnię. Znamy finalistów Polytechnica Nova 2026",
  url:
      "https://pwr.edu.pl/uczelnia/aktualnosci/15-pomyslow-na-nasza-uczelnie-znamy-finalistow-polytechnica-nova-2026-14102.html",
  date: "20.03.2026",
  categories: ["działania społeczne", "życie uczelni"],
  previewText:
      "Od bezpieczeństwa i zielonych przestrzeni, przez nowoczesną dydaktykę, aż po zaawansowane laboratoria badawcze. Poznaliśmy 15 projektów, które przeszły do finału konkursu Polytechnica Nova 2026.",
);

const meta = Meta<NewsTile>();

final $default = NewsTileStory(args: NewsTileArgs(item: Arg.fixed(_productionArticle)));
