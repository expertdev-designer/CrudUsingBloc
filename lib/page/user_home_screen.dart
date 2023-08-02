//import 'package:flutter/material.dart';// import 'package:flutter/cupertino.dart';

 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import  '../bloc/user_list_bloc.dart';
 import 'package:flutter_bloc/flutter_bloc.dart';
 import '../bloc/user_list_bloc.dart';
import '../bloc/user_list_event.dart';
import '../bloc/user_list_state.dart';
import '../model/user.dart';
// part 'user_list_bloc.dart';
// import '../bloc/user_list_state.dart';
// import '../bloc/user_list_event.dart';
// import '../model/user.dart';
//import '../model/user_list_model/user.dart';


 class UserHomePage extends StatelessWidget{

   final TextEditingController name = TextEditingController();
   final TextEditingController email= TextEditingController();

   void showBottomSheet({
     required BuildContext context,
     bool isEdit = false,
     required int id,
 })=> showModalBottomSheet(
     context:context,
     isScrollControlled: true,
     builder:(context){
       return Padding(
         padding: EdgeInsets.only(
             bottom: MediaQuery.of(context).viewInsets.bottom),
         child: Column(
           mainAxisSize: MainAxisSize.min,
           children: [
             buildTextField(controller: name,hint:'Enter name'),
             buildTextField(controller: email,hint:'Enter email'),
             ElevatedButton(onPressed: (){
               final user= User(
                 name: name.text,
                 email: email.text,
                 id: id,
               );
               if(isEdit){
                 BlocProvider.of<UserListBloc>(context)
                     .add(UpdateUser(user: user));
               }
               else{
                 BlocProvider.of<UserListBloc>(context)
                     .add(AddUser(user: user));
                 //userListBloc(context).add(AddUser(user: user));
               }
               Navigator.pop(context);
             }, child: Text(isEdit ? 'Upadte' : 'Add user'),
             ),
          ],
         ),
       );
     }
   );
  @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         centerTitle:true,
         title: Text('Crud using bloc',style: TextStyle(color: Colors.white),),
         backgroundColor: Colors.blueAccent.shade100,
       ),
       floatingActionButton: ElevatedButton(
         onPressed: (){
           final state = BlocProvider.of<UserListBloc>(context).state;
           final id =state.users.length +1;
           showBottomSheet(context: context, id: id);
         },
         style: ElevatedButton.styleFrom(
           backgroundColor: Colors.blueAccent,
           foregroundColor: Colors.black,
         ),
         child: Text('Add user',style: TextStyle(color: Colors.white),),
       ),
       body: Container(
         decoration: BoxDecoration(
           gradient:LinearGradient(
             colors: [
               Color(0xffffbc2eb),
               Color(0xfffa6c1ee),
             ]
           )
         ),
         child: BlocBuilder<UserListBloc,UserListState> (
           builder:(context,state){
             if(state is UserListUpdated && state.users.isNotEmpty) {
               final users = state.users;
               return Stack(
                 children:<Widget> [
                  ListView.builder(
                     itemCount: users.length,
                     itemBuilder: (context, index) {
                     //  Color itemColor = index % 2 == 0 ? Colors.blue.shade200 : Colors.green.shade200;
                       final user = users[index];
                       return Container(
                         //color:itemColor,
                         //   decoration: BoxDecoration(
                         //     borderRadius: BorderRadius.circular(6),
                         //     color:itemColor,
                         //   ),
                           child: buildUserTile(context, user),
                         );
                     }
                 ),
                ],
               );
             }
             else{
               return const SizedBox(
                 width: double.infinity,
                 child:  Center(child: Text('No users Found'),),
               );
             }
         }
         ),
       ),
     );
   }

   Widget buildUserTile(BuildContext context, User user){
     return Column(
       children: [
         ListTile(
           title: Text(user.name),
           subtitle: Text(user.email),
           trailing: Row(
             mainAxisSize: MainAxisSize.min,
             children: [
               IconButton(onPressed: (){
                 BlocProvider.of<UserListBloc>(context).add(DeleteUser(user: user));
                 //userListBloc(context).add(DeleteUser(user:user));
               },
                   icon: const Icon(Icons.delete,size: 30,color: Colors.red,),
               ),
               IconButton(
                   onPressed:(){
                     name.text = user.name;
                     email.text = user.email;
                     showBottomSheet(context: context, id: user.id, isEdit: true,);// builder: (BuildContext context) {  }: builder)
                   } ,
                   icon: const Icon(Icons.edit,size: 30,color: Colors.green,)),
             ],
           ),
         ),

         Divider(
           color:Colors.grey,
           endIndent:MediaQuery.of(context).size.width*0.05,
           indent: MediaQuery.of(context).size.width*0.05,
           thickness: 1.0,
           height: 0.8,
         ),
       ],
     );
   }

   static Widget buildTextField({
     required TextEditingController controller,
    required String hint,
 })=> Padding(
   padding: const EdgeInsets.all(12.0),
   child: TextField(
       controller: controller,
       decoration: InputDecoration(
         hintText: hint,
         border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8)
       ),
      ),
    ),
 );
}