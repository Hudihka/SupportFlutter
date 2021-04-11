
import 'package:flutter/material.dart';
import 'package:qut/Extension/Aler.dart';
import 'package:qut/Models/Content.dart';
import 'package:qut/Support/LogOuth/Const.dart';
import 'package:qut/Extension/String.dart';
import 'package:qut/Views/Cells/CellComplain.dart';

class Complain extends StatefulWidget {

  Content content;
  Complain({@required this.content});

  @override
  _ComplainState createState() => _ComplainState();
}


class _ComplainState extends State<Complain> {

  List<String> resonSelected = [];
  List<String> resons = ['Reson 1', 'Reson 2', 'Reson 3', 'Reson 4', 'Reson 5', 'Reson 6', 'Reson 7'];
  BuildContext _context;


  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        actions: [

          
          Container(
            height: 60,
            width: 60,
            child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0))),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Image.asset('assets/icons/BBItem/BBItemCloseWhite.png'),
              )
          )

              
        ]
      ),
      backgroundColor: Colors.white,
      body: _columnContent(),
    );
  }

  Widget _columnContent(){
    return Column(
      children: [

        Container(
          height: 34,
          width: double.infinity,
          child: Row(
            children: [
              SizedBox(width: 16),
              Text('Complain', style: TextStyle(color: Const.darkGray, fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.left,)
            ]
          )
        ),

        SizedBox(height: 24),

        Container(
          height: 22,
          width: double.infinity,
          child: Row(
            children: [
              SizedBox(width: 16),
              Text('Are there any troubles?', style: TextStyle(color: Const.darkGray, fontSize: 16, fontWeight: FontWeight.w400), textAlign: TextAlign.left,)
            ]
          )
        ),

        SizedBox(height: 24),
        _containerList,
        SizedBox(height: 10),
        _containerButton,
        SizedBox(height: 34)
      ]
    );

  }

  Container get _containerList{
    return Container(
      width: double.infinity,
      height: Const.fullHeightBody - 196,
      child: ListView.builder(
            
            physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemCount: resons.length,
            itemBuilder: (_, index) {
              final obj = resons[index];
              CellComplain cell = CellComplain(content: obj, selected: resonSelected.contains(obj),);

              cell.taped = (cellReson){
                if (resonSelected.contains(obj)){
                  resonSelected.remove(obj);
                } else {
                  resonSelected.add(obj);
                }
                setState(() {});
              };

              return cell;
            }),
    );
  }



  Container get _containerButton{
    return Container(
      width: double.infinity,
      height: 48,
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: _button,
      ),
    );
  }


  RaisedButton get _button {
    return RaisedButton(
        color: resonSelected.isNotEmpty ? "5689C0".getColor() : "AFBAC8".getColor(),
        child: Text('Complain',
            style: TextStyle(
                color: resonSelected.isNotEmpty ? Colors.white : 'F4F3F0'.getColor(),
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        onPressed: resonSelected.isNotEmpty
            ? () {
                _showAlert();
              }
            : null,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(8.0)));
  }


  _showAlert() {
    final alert = AlertOneButton('Thanks for your message', '', () {
      Navigator.pop(_context);
    }, 'Ok');
    showDialog(context: _context, builder: (BuildContext context) => alert);
  }



}




