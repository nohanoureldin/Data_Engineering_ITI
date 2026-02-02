use Demo

db.employee.find({})

db.employee.findAndModify()    //find + Modify //Old 

db.employee.findOneAndUpdate() //findOne + Update
db.employee.findOneAndDelete() //findOne + Delete

db.employee.findOne()
db.employee.findOneAndReplace() //findOne + Replace

db.employee.insert({ _id: 10, name: "eman" })

db.employee.update()

db.employee.deleteMany()
db.employee.deleteOne()



//db    =>    collection         => Column , Index ,...
db.employee.drop()

db.dropDatabase()

//--- 
var data = [{ _id: 1, age: 15 }, { _id: 2, address: "cairo" }] //Array

//data = 1
//date ="ali"

db.staff.insertMany(data)

db.student.insertMany(data)

//---
db.staff.insertOne(data) //db.staff.insertOne(data[0])

db.student.insertMany(data)

//----
db.employee.find({})

//Student First Name : 
db.employee.find({ fName: { $exists: true } }).forEach(function (myData) {
    print("Student First Name : " + myData.fName)
})

//-----------

db.serverCmdLineOpts()



db.employee.insertOne({_id:50 , age:25})


