import "package:test/test.dart";

import "package:topwr/features/branches/data/model/branch.dart";
import "package:topwr/features/departments/departments_view/data/models/department.dart";
import "package:topwr/features/departments/departments_view/data/repository/departments_repository.dart";

void main() {
  const departmentsFromProd = [
    Department(
      id: 1,
      name: "Wydział Architektury",
      code: "W1",
      betterCode: "WA",
      logo: null,
      gradientStart: "#BFBEBE",
      gradientStop: "#868585",
      branch: Branch.main,
    ),
    Department(
      id: 2,
      name: "Wydział Budownictwa Lądowego i Wodnego",
      code: "W2",
      betterCode: "WBLIW",
      logo: null,
      gradientStart: "#CA6846",
      gradientStop: "#FFA07E",
      branch: Branch.main,
    ),
    Department(
      id: 4,
      name: "Wydział Chemiczny",
      code: "W3",
      betterCode: "WCH",
      logo: null,
      gradientStart: "#D8C144",
      gradientStop: "#FFE86C",
      branch: Branch.main,
    ),
    Department(
      id: 5,
      name: "Wydział Informatyki i Telekomunikacji",
      code: "W4",
      betterCode: "WIT",
      logo: null,
      gradientStart: "#7A2229",
      gradientStop: "#B74A53",
      branch: Branch.main,
    ),
    Department(
      id: 6,
      name: "Wydział Elektryczny",
      code: "W5",
      betterCode: "WENY",
      logo: null,
      gradientStart: "#AC0721",
      gradientStop: "#ED1A3B",
      branch: Branch.main,
    ),
    Department(
      id: 7,
      name: "Wydział Geoinżynierii, Górnictwa i Geologii",
      code: "W6",
      betterCode: "WGGG",
      logo: null,
      gradientStart: "#035F2F",
      gradientStop: "#008C44",
      branch: Branch.main,
    ),
    Department(
      id: 8,
      name: "Wydział Inżynierii Środowiska",
      code: "W7",
      betterCode: "WIS",
      logo: null,
      gradientStart: "#61A33D",
      gradientStop: "#89C867",
      branch: Branch.main,
    ),
    Department(
      id: 9,
      name: "Wydział Zarządzania",
      code: "W8",
      betterCode: "WZ",
      logo: null,
      gradientStart: "#013E75",
      gradientStop: "#005AAB",
      branch: Branch.main,
    ),
    Department(
      id: 10,
      name: "Wydział Mechaniczno-Energetyczny",
      code: "W9",
      betterCode: "WME",
      logo: null,
      gradientStart: "#E58012",
      gradientStop: "#F5A248",
      branch: Branch.main,
    ),
    Department(
      id: 11,
      name: "Wydział Mechaniczny",
      code: "W10",
      betterCode: "WM",
      logo: null,
      gradientStart: "#7BCAB3",
      gradientStop: "#4AAC8F",
      branch: Branch.main,
    ),
    Department(
      id: 12,
      name: "Wydział Podstawowych Problemów Techniki",
      code: "W11",
      betterCode: "WPPT",
      logo: null,
      gradientStart: "#0C7D7E",
      gradientStop: "#009C9E",
      branch: Branch.main,
    ),
    Department(
      id: 13,
      name: "Wydział Elektroniki, Fotoniki i Mikrosystemów",
      code: "W12",
      betterCode: "WEFIM",
      logo: null,
      gradientStart: "#013E75",
      gradientStop: "#005AAB",
      branch: Branch.main,
    ),
    Department(
      id: 14,
      name: "Wydział Matematyki",
      code: "W13",
      betterCode: "WMAT",
      logo: null,
      gradientStart: "#86702C",
      gradientStop: "#9B8644",
      branch: Branch.main,
    ),
    Department(
      id: 15,
      name: "Wydział Medyczny",
      code: "W14",
      betterCode: "WMED",
      logo: null,
      gradientStart: "#00B2BA",
      gradientStop: "#66CCCC",
      branch: Branch.main,
    ),
    Department(
      id: 16,
      name: "Filia Politechniki Wrocławskiej w Jeleniej Górze",
      code: "J00",
      betterCode: "JELE",
      logo: null,
      gradientStart: "#52419a",
      gradientStop: "#7d6fb5",
      branch: Branch.jeleniaGora,
    ),
    Department(
      id: 18,
      name: "Filia Politechniki Wrocławskiej w Legnicy",
      code: "L00",
      betterCode: "LEGN",
      logo: null,
      gradientStart: "#00ae45",
      gradientStop: "#42c87a",
      branch: Branch.legnica,
    ),
    Department(
      id: 17,
      name: "Filia Politechniki Wrocławskiej w Wałbrzychu",
      code: "W00",
      betterCode: "WALB",
      logo: null,
      gradientStart: "#883279",
      gradientStop: "#b15f9f",
      branch: Branch.walbrzych,
    ),
  ];

  const prodOrderCodes = [
    "W1",
    "W2",
    "W3",
    "W4",
    "W5",
    "W6",
    "W7",
    "W8",
    "W9",
    "W10",
    "W11",
    "W12",
    "W13",
    "W14",
    "J00",
    "L00",
    "W00",
  ];

  group("sortByBranch", () {
    test("preserves prod order when branch is not selected", () {
      final sorted = departmentsFromProd.sortByBranch(null);

      expect(sorted.map((department) => department.code), prodOrderCodes);
    });

    test("keeps main departments first in prod order", () {
      final sorted = departmentsFromProd.sortByBranch(Branch.main);

      expect(sorted.map((department) => department.code), [
        "W1",
        "W2",
        "W3",
        "W4",
        "W5",
        "W6",
        "W7",
        "W8",
        "W9",
        "W10",
        "W11",
        "W12",
        "W13",
        "W14",
        "J00",
        "L00",
        "W00",
      ]);
    });

    test("keeps Walbrzych first and sorts other departments", () {
      final sorted = departmentsFromProd.sortByBranch(Branch.walbrzych);

      expect(sorted.map((department) => department.code), [
        "W00",
        "W1",
        "W2",
        "W3",
        "W4",
        "W5",
        "W6",
        "W7",
        "W8",
        "W9",
        "W10",
        "W11",
        "W12",
        "W13",
        "W14",
        "J00",
        "L00",
      ]);
    });

    test("keeps Legnica first and sorts other departments", () {
      final sorted = departmentsFromProd.sortByBranch(Branch.legnica);

      expect(sorted.map((department) => department.code), [
        "L00",
        "W1",
        "W2",
        "W3",
        "W4",
        "W5",
        "W6",
        "W7",
        "W8",
        "W9",
        "W10",
        "W11",
        "W12",
        "W13",
        "W14",
        "J00",
        "W00",
      ]);
    });

    test("keeps Jelenia Gora first and sorts other departments", () {
      final sorted = departmentsFromProd.sortByBranch(Branch.jeleniaGora);

      expect(sorted.map((department) => department.code), [
        "J00",
        "W1",
        "W2",
        "W3",
        "W4",
        "W5",
        "W6",
        "W7",
        "W8",
        "W9",
        "W10",
        "W11",
        "W12",
        "W13",
        "W14",
        "L00",
        "W00",
      ]);
    });
  });
}
