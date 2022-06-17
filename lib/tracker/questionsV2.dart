class Question{
  String question = '';
  List options = [];
  List values = [];
  double cals = 0.0;
  List imgs = [];
  String topimg = '';

  Question({question, options, values, cals, imgs, topimg}){
    this.question = question;
    this.options = options;
    this.values = values;
    this.cals = cals;
    this.imgs = imgs;
    this.topimg = topimg;
  }
}