//2. Create a Collection named "Staff". 
db.createCollection("Staff")

//3. Insert one document into the "Staff" collection: {_id, name, age, gender, department}
db.Staff.insertOne({
  _id : 440,
   Name : "Noha",
   Age : 22,
   Gender : "F",
   Department : "IT"
})

//4. Insert many documents into the "Staff" collection: 

  // Object: {_id, name, age: 20, gender: "male", department} 
  // Object: {_id, name, age: 25, gender: "female", managerName, department} 
  // Object: {_id, name, age: 15, gender, DOB} 
  
db.Staff.insertMany([
 {
 _id: 480,
 Name: "Ali",
 Age: 20,
 Gender: "M",
 Department: "IT"
 },
 {
 _id: 789,
 Name: "Mona",
 Age: 24,
 Gender: "F",
 Manager_Name: "Hossam",
 Department: "IT"
 },
 {
 _id: 654,
 Name: "Israa",
 Age: 15,
 DOB: ISODate("2011-05-18")
 }
])
db.Staff.find()
//5. Query to find data from the "Staff" collection: 
// 1) Find all documents.
db.Staff.find()
	 
// 2) Find documents where gender is "male".  //Projection
db.Staff.find(
{Gender : "M"},
{Name: 1, Gender : 1, _id: 1}
)

//3) Find documents with age between 20 and 25. 
db.Staff.find({
  Age: { $gte: 20, $lte: 25 }
})

// 4) Find documents where age is 25 and gender is "female". 
db.Staff.find({
  Age: 25,
  Gender: "F"
})
//5) Find documents where age is 20 or gender is "female".
db.Staff.find({
    $or: [
    {Age: 20},
    {Gender: "F"}
    ]
}) 
  
//6.Update one document in the "Staff" collection where age is 15, set the name to 
// "your name". 
db.Staff.updateOne(
    {Age: 15},
    {$set:{Name: "Asmaa"}}
)
db.Staff.find({}, { Name: 1, Age: 1 })

// 7. Update many documents in the "Staff" collection, update the department to "AI". 
db.Staff.updateMany({},                   
   {$set: {Department:"AI"}}
)
db.Staff.find({}, {Name:1, Department: 1 })

//8.Create a new collection called "test" and insert documents from Question 4. 
db.test.insertMany([
 {
 _id: 480,
 Name: "Ali",
 Age: 20,
 Gender: "M",
 Department: "IT"
 },
 {
 _id: 789,
 Name: "Mona",
 Age: 24,
 Gender: "F",
 Manager_Name: "Hossam",
 Department: "IT"
 },
 {
 _id: 654,
 Name: "Israa",
 Age: 15,
 DOB: ISODate("2011-05-18")
 }
])

db.test.find()

//9. Try to delete one document from the "test" collection where age is 15. 
db.test.deleteOne({Age:15})

//With justification, explain which document will be deleted if more than one has age = 15.
// (Try it.) 
db.test.deleteMany({Age:15})

//First insert: db.collection.insertOne({ _id: 5, name: "ahmed", age: 15 }) 
db.test.insertOne({_id: 5,name: "Ahmed", age:15 })

//Second insert: db.collection.insertOne({ _id: 6, name: "eman", age: 15 }) 
db.test.insertOne({_id: 6,name: "Eman", age:15 })
// b. When you run deleteOne, will it delete ahmed or eman? 
db.test.find()

//10. try to delete all male gender 
db.test.deleteMany({Gender : "M"})

//11.Try to delete all documents in the "test" collection.
db.test.deleteMany({})
  
  
  