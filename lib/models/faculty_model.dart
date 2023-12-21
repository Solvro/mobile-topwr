class FacultyModel {
  final String sectionName;
  final String sectionShortcut;
  final String customName;

  FacultyModel({
    required this.sectionName,
    required this.sectionShortcut,
    this.customName = '',
  });
}

class Faculties {
  final List<FacultyModel> faculties = [
    FacultyModel(
      sectionName: 'Wydział Architektury',
      sectionShortcut: 'W-1',
    ),
    FacultyModel(
        sectionName: 'Wydział Budownictwa Lądowego i Wodnego',
        sectionShortcut: 'W-2',
        customName: 'Wydział Budownictwa'),
    FacultyModel(
      sectionName: 'Wydział Chemiczny',
      sectionShortcut: 'W-3',
    ),
    FacultyModel(
        sectionName: 'Wydział Informatyki i Telekomunikacji',
        sectionShortcut: 'W-4',
        customName: 'Wydział Informatyki'),
    FacultyModel(
      sectionName: 'Wydział Elektryczny',
      sectionShortcut: 'W-5',
    ),
    FacultyModel(
        sectionName: 'Wydział Geoinżynierii, Górnictwa i Geologii',
        sectionShortcut: 'W-6',
        customName: 'Wydział Geoinżynierii'),
    FacultyModel(
        sectionName: 'Wydział Inżynierii Środowiska',
        sectionShortcut: 'W-7',
        customName: 'Wydział Środowiska'),
    FacultyModel(
      sectionName: 'Wydział Zarządzania',
      sectionShortcut: 'W-8',
    ),
    FacultyModel(
      sectionName: 'Wydział Mechaniczno-Energetyczny',
      sectionShortcut: 'W-9',
    ),
    FacultyModel(
      sectionName: 'Wydział Mechaniczny',
      sectionShortcut: 'W-10',
    ),
    FacultyModel(
      sectionName: 'Wydział Podstawowych Problemów Techniki',
      sectionShortcut: 'W-11',
    ),
    FacultyModel(
      sectionName: 'Wydział Elektroniki, Fotoniki i Mikrosystemów',
      sectionShortcut: 'W-12',
    ),
    FacultyModel(
      sectionName: 'Wydział Matematyki',
      sectionShortcut: 'W-13',
    ),
    FacultyModel(
      sectionName: 'Wydział Medyczny',
      sectionShortcut: 'W-14',
    ),
  ];
  List<FacultyModel> getFaculties() {
    return faculties;
  }
}
