import 'package:addcomments/comment/business%20logic/cubit/comment_cubit.dart';
import 'package:addcomments/comment/data/models/comment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  void initState(){
    context.read<CommentCubit>().loadedComments();
    super.initState();
  }
  int _current = 1;
  final TextEditingController _searchController = TextEditingController();
  set current(value){
      if(_current != value){
       setState(() {
         _current = value;
       });
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('add Comments'),
        centerTitle: true,
        elevation: 2,
      ),
      body:   Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        customcard(),

        Padding(
          padding: const EdgeInsets.only(left: 8,right: 8,top: 8),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Card(
                      child: searchBar(),
                ),
              ),
              IconButton(onPressed: (){
                showDialog(
                  context: context,
                  builder: (BuildContext context) => _buildPopupDialog(context,(String title){
                    context.read<CommentCubit>().addComment(CommentModel(title: title,id: 1,thumbnailUrl: "https://www.google.com/s2/favicons?sz=64&domain_url=yahoo.com ",albumId: 1,url: "https://yahoo.com"));
                    Navigator.pop(context);
                  }),
                );
              },
                  icon:const Icon(Icons.add)

              ),
            ],
          ),
        ),
        BlocConsumer<CommentCubit, CommentState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    if(state is CommentLoadingState){
      return const Center(child: CircularProgressIndicator(),);
    }
    else if(state is CommentLoadedState){

      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(itemCount: state.comments.length,itemBuilder: (BuildContext context,int index){
            var loadedState=state.comments[index];
            return Card(child:  ListTile(
              leading:  CircleAvatar(
                  backgroundImage: NetworkImage(loadedState.thumbnailUrl.toString()),
              ) ,
              title: Text(loadedState.title.toString(),maxLines: 1,overflow: TextOverflow.ellipsis,),
              trailing: const Icon(Icons.check)
            ));
          }

          ),
        ),
      );
    }
    return const SizedBox();
  },
),
      ],
    ),

      bottomNavigationBar: navbar(),
    );
  }
  Widget _buildPopupDialog(BuildContext context ,Function(String) onSave) {
    final TextEditingController  controller = TextEditingController();
    return  AlertDialog(
      title: const Text('Type Below'),
      content:   Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        Card(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextField(
            controller: controller,
            decoration: const InputDecoration(
                hintText: 'comment',

                border: InputBorder.none,
                prefixIcon: SizedBox(),


            ),

      ),
          ),
        ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(

          onPressed: (){
            if(controller.text.isNotEmpty) onSave(controller.text);

          },

          child: const Text('Add'),
        ),
        ElevatedButton(

          onPressed: (){

            Navigator.of(context).pop<bool>(true);
          },

          child: const Text('Cancel'),
        ),
      ],
    );
  }
  TextField searchBar(){
    return TextField(

      controller: _searchController,
      decoration: const InputDecoration(

        hintText: 'search',
        border: InputBorder.none,

        prefixIcon:

         Icon(Icons.search)

      ),

    );
  }

  Card customcard(){
    return Card(
      elevation: 2,
      child: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height/4,
          width:  MediaQuery.of(context).size.width,
          child:  Image.asset("assets/png/card.png",height: 500,width: 500,fit: BoxFit.contain,),


        ),
      ),
    );
  }
BottomNavigationBar  navbar(){
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.purpleAccent,
        showUnselectedLabels: true,
        currentIndex: _current,
        onTap: (v)=>current=v,
    items:  const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: "home"

    ),
    BottomNavigationBarItem(

    icon: Icon(Icons.credit_card),
    label: "add card"
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.wallet_sharp),
    label: "news"
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.account_circle),
    label: "profile"
    ),]);
  }
}


