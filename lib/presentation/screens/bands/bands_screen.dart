import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../config/config.dart';

class BandsScreen extends StatefulWidget {
  const BandsScreen({super.key});

  @override
  State<BandsScreen> createState() => _BandsScreenState();
}

class _BandsScreenState extends State<BandsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bandas')
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, i) {

             return _bandTile(bands[i]);
       }
     ),
     floatingActionButton: FloatingActionButton(
      elevation: 1,
      onPressed: () => addereNovumBand(context),
        child: Icon(Icons.add),
     ),
      );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      child: ListTile(
          leading: CircleAvatar(
            child: Text(band.nomen.substring(0, 2).toUpperCase()),
              ),
              title: Text(band.nomen),
              trailing: Text('${ band.numerusVotum }', style: TextStyle(fontSize: 20),),
              onTap: () {
                print(band.nomen);},
         ),
    );
  }
  addereNovumBand(BuildContext context){

final TextEditingController textumController = TextEditingController();
/*showDialog(
  context: context, 
  builder:(context) {
    return AlertDialog(
      title: Text('New Band name'),
      content: TextField(controller: textumController,),
      actions: [
        MaterialButton(
          onPressed: () => {addereBandAdCollection(context, textumController.text)},
          textColor: Colors.blue,
          child: Text('add'),
          )
      ],
    );
  },
  );*/

  showCupertinoDialog(
  context: context, 
  builder: ( BuildContext context ) => CupertinoAlertDialog(
    title: const Text('New band name'),
    content:  CupertinoTextField(
      controller: textumController,
      style: TextStyle(
        color: Theme.of(context).brightness == Brightness.dark 
          ? Colors.white 
          : Colors.black
        )
      ),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: const Text('Add'),
          onPressed: () {
            addereBandAdCollection(context, textumController.text);
            context.pop();
          }
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          child: const Text('Close'),
          onPressed: () => context.pop()
        ),
      ],
   )
);

}

void addereBandAdCollection(BuildContext context, String nomen){
  print(nomen);
  context.pop();
}


}





