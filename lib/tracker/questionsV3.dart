class Question{
  String question = '';
  String type = '';
  List options = [];
  List values = [];
  List imgs = [];
  String topimg = '';

  Question({question, type, options, values, cals, imgs, topimg}){
    this.question = question;
    this.type = type;
    if(type == 'input'){
      this.options = ['', '', '', ''];
      this.values = [0, 0, 0, 0];
      this.imgs = ['something'];
    }else if(type == 'mcq'){
      this.options = options;
      this.values = values;
      this.imgs = imgs;
    }
    this.topimg = topimg;
  }
}