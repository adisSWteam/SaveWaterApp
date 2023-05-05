// ignore_for_file: file_names

class Question {
  String question = '';
  List options = [];
  List values = [];
  double cals = 0.0;
  List imgs = [];
  String topimg = '';

  Question(
      {required this.question,
      required this.options,
      required this.values,
      required this.cals,
      required this.imgs,
      required this.topimg});
}
