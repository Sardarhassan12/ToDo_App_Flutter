import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CreateTask.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  // List<TaskData> _tasks = [];
  List<String> tasks = [];
  List<String> dates = [];
  List<String> times = [];
  List<bool> isChecked = [];

  void initState(){
      super.initState();
      _setAllData();
    }

    // void _setAllTasks() async{
    //   HoldData _holdData = HoldData();
    //   List<dynamic> allTasks = await _holdData.loadData();
    //   setState(() {
    //     _tasks = allTasks.map((task) => TaskData.fromJson(task)).toList();
    //   });
    // }
  void _setAllData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? tasks = prefs.getStringList("tasks");
    List<String>? dates = prefs.getStringList("dates");
    List<String>? times = prefs.getStringList("times");
    setState(() {
      this.tasks = tasks ?? [];
      this.dates = dates ?? [];
      this.times = times ?? [];
      this.isChecked = List.generate(this.tasks.length, (index) => false);
    });
  }

  void _removeData(int index ) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {

      this.times.removeAt(index);
      this.dates.removeAt(index);
      this.tasks.removeAt(index);
    });
    pref.setStringList("tasks", this.tasks);
    pref.setStringList("dates", this.dates);
    pref.setStringList("times", this.times);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: ()=> {}, icon: Icon(Icons.menu), color: Colors.white,),
          title: Text("To Do App", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25,),),
          centerTitle: true,
          backgroundColor:  Color(0xFF1C1B33),
          actions: [
            IconButton(onPressed: ()=> {}, icon: Icon(Icons.search),color: Colors.white,),
          ],
        ),
        body: SafeArea(
          child: Stack(
            children: [
              // Positioned.fill(
              //     child:Image.asset("assets/bg.jpg", fit: BoxFit.cover,)
              //
              // ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF1C1B33), // Dark purple shade
                      Color(0xFF3E0E56),
                      Color(0xFF1C1B33)// Deep violet shade
                    ],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 100.0,
                    left: 20.0,
                    right: 20.0,
                  ),

                  child: ListView.builder(
                    itemBuilder: (context, index){
                      return Card(
                          color: Color(0xFF6246E3),
                          child: Container(
                            height: 100.0,
                            child: Column(
                              children: [
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: isChecked[index],
                                      onChanged: (bool? value) {
                                        setState(() {
                                          isChecked[index] = value!; // Toggle the state
                                        });
                                      },
                                      checkColor: Colors.white,
                                      side: BorderSide(color: Colors.white, width: 2),

                                    ),
                                    SizedBox(width: 20,),
                                    Text(this.tasks[index], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, decoration:isChecked[index] ? TextDecoration.lineThrough : TextDecoration.none, color: Colors.white,  decorationThickness: 4.5,)),
                                    Spacer(),
                                    IconButton(onPressed: ()=>{
                                      _removeData(index)
                                    }, icon: Icon(Icons.cancel),color: Colors.white, )
                                  ],
                                ),
                                SizedBox(height: 8,),
                                Row(
                                  children: [
                                    SizedBox(width: 70,),
                                    Text(this.dates[index], style: TextStyle( color: Colors.white, fontWeight: FontWeight.w700),),
                                    SizedBox(width: 50,),
                                    Text(this.times[index],  style: TextStyle( color: Colors.white, fontWeight: FontWeight.w700),)
                                  ],
                                )
                              ],
                            ),
                          )
                      );
                    },
                    itemCount: tasks.length,

                  ),

                ),
              ),
            ],
          )

        ),
        floatingActionButton: FloatingActionButton(
          onPressed: ()=>{
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Createtask()))
          },
          child: Icon(Icons.add),
        )

    );
  }
}
