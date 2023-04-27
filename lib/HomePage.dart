import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var price, fat, protein, grade, summary, sumRound, customFormula, formulaField = false;
  
  Parser p = Parser();
  ContextModel cm = ContextModel();
  
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  TextEditingController t4 = TextEditingController();
  
  List<String> formulas = ['Формула 1', 'Формула 2', 'Формула 3', 'Формула 4', 'Формула 5', 'Формула 6', 'Формула 7', 'Формула 8', 'Своя формула'];
  List<String> grades = ['1', '1.1'];
  String? _selectedGrade, _selectedFormula;

  var buttonColor = ElevatedButton.styleFrom(backgroundColor: const Color(0xFF92C46D));

  void add() {
    price = double.parse(t1.text);
    fat = double.parse(t2.text);
    protein = double.parse(t3.text);
    grade = double.parse('$_selectedGrade');
    customFormula = t4.text;

    setState(() {
      switch(_selectedFormula) {
        case 'Формула 1':
          summary = price*(0.6*protein/3 + 0.4*fat/3.4)*grade*1.1;
          break;
        case 'Формула 2':
          summary = price*(0.6*protein/3 + 0.4*fat/3.6)*grade*1.1;
          break;
        case 'Формула 3':
          summary = price*(0.5*protein/3 + 0.5*fat/3.4)*grade*1.1;
          break;
        case 'Формула 4':
          summary = price*(0.5*protein/3.1 + 0.5*fat/3.6)*grade*1.1;
          break;
        case 'Формула 5':
          summary = price*(0.5*protein/3.1 + 0.5*fat/3.4)*grade*1.1;
          break;
        case 'Формула 6':
          summary = price*(fat/3.4)*grade*1.1;
          break;
        case 'Формула 7':
          summary = (price + 3.5*(fat-3.6))*grade*1.1;
          break;
        case 'Формула 8':
          summary = (price + 2.7*(fat-3.4) + 3*(protein-3))*grade*1.1;
          break;
        case 'Своя формула':
          Variable
              proteinCustom = Variable('protein'),
              fatCustom = Variable('fat'),
              priceCustom = Variable('price'),
              gradeCustom = Variable('grade');
          Expression exp = p.parse(customFormula);
          cm.bindVariable(priceCustom, Number(price));
          cm.bindVariable(fatCustom, Number(fat));
          cm.bindVariable(proteinCustom, Number(protein));
          cm.bindVariable(gradeCustom, Number(grade));

          summary = exp.evaluate(EvaluationType.REAL, cm);

          print(cm);
          break;
      }

      sumRound = num.parse(summary.toStringAsFixed(2));
    });
  }

  List<DropdownMenuItem<String>> _formulaList() {
    return formulas
        .map<DropdownMenuItem<String>>(
          (e) => DropdownMenuItem(
        value: e,
        child: Text(e),
      ),
    )
        .toList();
  }

  List<DropdownMenuItem<String>> _gradeList() {
    return grades
        .map<DropdownMenuItem<String>>(
          (e) => DropdownMenuItem(
        value: e,
        child: Text(e),
      ),
    )
        .toList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Color(0xff313131),
        title: Container(
          alignment: Alignment.center,
          child: Image(
            image: AssetImage('assets/logo.png'),
            width: 50,
            height: 50,
          ),
        ),
      ),
      backgroundColor: const Color(0xff000),
      body: Padding (
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: Text('Цена с НДС равна ${sumRound == null ? 0 : sumRound}', style: const TextStyle(fontSize: 24, color: Color(0xffffffff))),
            ), // Поле вывода цены с ндс

            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Container(
                    width: 185.5,
                    margin: const EdgeInsets.only(right: 10),
                    child: TextField(
                      style: const TextStyle(color: Color(0xffffffff)),
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xffa0a0a0))),
                        hintText: ("Цена без НДС"),
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(3))),
                      ),
                      controller: t1,
                      keyboardType: TextInputType.number,
                    ),
                  ), // Поле ввода цены без ндс

                  Container(
                    width: 185.5,
                    child: TextField(
                      style: const TextStyle(color: Color(0xffffffff)),
                      decoration: const InputDecoration(
                        hintText: "Жир",
                        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xffa0a0a0))),
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(3))),
                      ),
                      controller: t2,
                      keyboardType: TextInputType.number,
                    ),
                  ), // Поле ввода жира
                ],
              ),
            ), // Поле ввода цены без ндс и жира

            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Container(
                    width: 185,
                    margin: const EdgeInsets.only(right: 10),
                    child: TextField(
                      style: const TextStyle(color: Color(0xffffffff)),
                      decoration: const InputDecoration(
                        hintText: "Белок",
                        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xffa0a0a0))),
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(3))),
                      ),
                      controller: t3,
                      keyboardType: TextInputType.number,
                    ),
                  ), // Поле ввода белка
                  Container(
                    height: 59,
                    width: 185,
                    padding: const EdgeInsets.only(left: 10, top: 5, bottom: 7),
                    decoration: BoxDecoration(border: Border.all(width: 1.1, color: const Color.fromRGBO(155, 155, 155, 1)), borderRadius: BorderRadius.circular(3)),
                    child: DropdownButton<String>(
                      style: const TextStyle(color: Color(0xffffffff)),
                      dropdownColor: Color(0xff000000),
                      items: _gradeList(),
                      elevation: 16,
                      underline: Container(
                        height: 0,
                        color: Colors.deepPurpleAccent,
                      ),
                      hint: const Text('Сортность'),
                      value: _selectedGrade,
                      onChanged: (String? value) => setState( () {
                        _selectedGrade = value ?? '';
                      }),
                    ),
                  ), //Список коэф-ов сортности
                ],
              ),
            ), // Поле ввода белка и коэф-а сортности

           Container(
             padding: const EdgeInsets.only(left: 10),
             margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(border: Border.all(width: 1, color: const Color.fromRGBO(155, 155, 155, 1)), borderRadius: BorderRadius.circular(3)),
                height: 45,
                width: 380,
                child: DropdownButton<String>(
                  style: const TextStyle(color: Color(0xffffffff)),
                  dropdownColor: Color(0xff000000),
                  items: _formulaList(),
                  elevation: 16,
                  underline: Container(
                    height: 0,
                    color: Colors.deepPurpleAccent,
                  ),
                  hint: const Text('Выберите формулу'),
                  value: _selectedFormula,
                  onChanged: (String? value) => setState( () {
                    _selectedFormula = value ?? '';
                    if(_selectedFormula == 'Своя формула') {
                      formulaField = true;
                    } else {
                      formulaField = false;
                    }
                  }),
                ),
              ), // Список формул

            Visibility(
              visible: formulaField,
                child: Container(
                  decoration: BoxDecoration(border: Border.all(width: 1.0, color: const Color(0xffa0a0a0))), padding: const EdgeInsets.all(3),
                  child: Column(
                    children: [
                      Visibility(
                        visible: formulaField,
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 2),
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: "Введите свою формулу",
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xffa0a0a0))),
                              border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(3))),

                            ),
                            keyboardType: TextInputType.number,
                            controller: t4,
                          ),
                        ),
                      ), // Поле ввода формулы

                      Visibility(
                        visible: formulaField,
                        child: Row(
                          children: [
                            Container(
                              width: 80.2,
                              margin: const EdgeInsets.only(right: 9.2),
                              child: ElevatedButton(
                                onPressed: () => { t4.text += 'price' },
                                child: const Text('Цена'),
                              ),
                            ),
                            Container(
                              width: 80.2,
                              margin: const EdgeInsets.only(right: 9.2),
                              child: ElevatedButton(
                                  onPressed: () => { t4.text += 'fat' },
                                  child: const Text('Жир')
                              ),
                            ),
                            Container(
                              width: 80.2,
                              margin: const EdgeInsets.only(right: 9.2),
                              child: ElevatedButton(
                                  onPressed: () => { t4.text += 'protein' },
                                  child: const Text('Белок')
                              ),
                            ),
                            Container(
                              width: 105.2,
                              child: ElevatedButton(
                                  onPressed: () => { t4.text += 'grade' },
                                  child: const Text('Сортность')
                              ),
                            ),
                          ],
                        ),
                      ), // Кнопки переменных

                      Visibility(
                        visible: formulaField,
                        child: Row(
                          children: [
                            Container(
                              width: 51.9,
                              margin: const EdgeInsets.only(right: 10),
                              child: ElevatedButton(
                                  onPressed: () => { t4.text += '+' },
                                  child: const Text('+')
                              ),
                            ),
                            Container(
                              width: 51.9,
                              margin: const EdgeInsets.only(right: 10),
                              child: ElevatedButton(
                                  onPressed: () => { t4.text += '-' },
                                  child: const Text('-')
                              ),
                            ),
                            Container(
                              width: 51.9,
                              margin: const EdgeInsets.only(right: 10),
                              child: ElevatedButton(
                                  onPressed: () => { t4.text += '/' },
                                  child: const Text('/')
                              ),
                            ),
                            Container(
                              width: 51.9,
                              margin: const EdgeInsets.only(right: 10),
                              child: ElevatedButton(
                                  onPressed: () => { t4.text += '*' },
                                  child: const Text('*')
                              ),
                            ),
                            Container(
                              width: 51.9,
                              margin: const EdgeInsets.only(right: 10),
                              child: ElevatedButton(
                                  onPressed: () => { t4.text += '(' },
                                  child: const Text('(')
                              ),
                            ),
                            Container(
                              width: 51.9,
                              child: ElevatedButton(
                                  onPressed: () => { t4.text += ')' },
                                  child: const Text(')')
                              ),
                            ),
                          ],
                        ),
                      ), //Кнопки мат. действий

                      Visibility(
                        visible: formulaField,
                        child: Container(
                          margin: const EdgeInsets.only(top: 5),
                          width: 250,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () => { t4.text = '' },
                            child: const Text('Очистить все'),
                          ),
                        ),
                      ), // Кнопка очистики поля формулы
                    ],
                  ),
                ),
            ), // Конструктор кастомных формул

            Container(
              width: 250,
              height: 50,
              margin: const EdgeInsets.only(top: 15,),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xfff69906)),
                  onPressed: add,
                  child: const Text('Рассчитать стоимость')
              ),
            ), // Кнопка для вывода итога
          ],
        ),
      ),
    );
  }
}
