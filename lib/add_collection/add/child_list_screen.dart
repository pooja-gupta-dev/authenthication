

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../controller/mixin_class.dart';
import '../../controller/parent_service.dart';


class ChildListScreen extends StatefulWidget  {
  final parentId;
  const ChildListScreen({super.key,this.parentId});

  @override
  State<ChildListScreen> createState() => _ChildListScreenState();
}

class _ChildListScreenState extends State<ChildListScreen>with CustumWidgets {

  @override

  Widget build(BuildContext context) {
    var nameController=TextEditingController();
    var emailController=TextEditingController();
    var phoneController=TextEditingController();
    var genderController=TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff90873092),
        title: Text("AddChildtData",style: TextStyle(color: Colors.white),),
      ),
      body: Column(

        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          viewTextFild("name",nameController,Icons.person),
          viewTextFild("email", emailController,Icons.email),
          viewTextFild("phone", phoneController,Icons.phone),
          viewTextFild("gender", genderController,Icons.generating_tokens),
          SizedBox(
            height: 10,
          ),
          viewbutton("Add child", onPressed: ()async{
            await service().childtData(
                nameController.text,
                emailController.text,
                int.parse(phoneController.text),
                genderController.text,
                widget.parentId);
            Navigator.pop(context);
          })
        ],

      ),
    );
  }
}
