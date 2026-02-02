// 1. Provide the MongoDB code for enforcing JSON schema validation when creating 
// a collection named "employees" with required fields "name," "age" (min. 18), and 
// "department" (limited to ["HR," "Engineering," "Finance"]).
db.runCommand({
    collMod: "employee",
    validator: {
        $jsonSchema: {
            bsonType : "object",
            required : ["name","age", "department"],
            properties : {
                name: {
                    bsonType : "string",
                    description: "Name Must Be a String Is Required"
                },
                age: {
                    bsonType: "int",
                    minimum : 18,
                    description: " Age must be 18 or above"
                },
                department: {
                    enum: ["HR","Engineering", "Finance"]
                }
            } 
        }
    },
})
db.emploees.insert()
//2. Create new Database named Demo 

// And Collections named trainningCenter1, trainningCenter2 
use Demo
db.createCollection("trainningCenter1")
db.createCollection("trainningCenter2")

// Insert documents into trainningCenter1 collection contains (Use Variable named data
// as Array) >> _id , name as firstName lastName , age , address, status as array
var data = [
  {
    _id: 1,
    fname: "Noha",
    lname: "Mohamed",
    age: 22,
    address: "Zagazig",
    status: ["Active", "Inactive"]
  },
  {
    _id: 2,
    fname: "Mona",
    lname: "Ahmed",
    age: 30,
    address: "Banha",
    status: ["Active", "Inactive"]
  },
  {
    _id: 3,
    fname: "Salma",
    lname: "Tarek",
    age: 22,
    address: "Cairo",
    status: ["Active", "Inactive"]
  }
]

db.trainningCenter1.insertOne(data) // one Doc
db.trainningCenter1.find()
db.trainningCenter2.insertMany(data)

//3. Use find. explain function (find by age field) and mention scanning type 
db.employee.find({age : 22}).explain()  // COLLSCAN

//4. Create index on created collection named it “IX_age” on age field 
db.employee.createIndex({ age : 1},{name : "IX_age"}) 

//5. Use find. explain view winning plan for index created (find by age field) 
// and mention scanning type 
db.employee.find({age : 22}).explain() // "stage" : "IXSCAN"

//6. Create index on created collection named it “compound” on firstNsme and lastName 
db.employee.createIndex(
    {firstName: 1, lastName: 1},
    {name :"compound"
})
db.employee.getIndexes()

// a. Try find().explain before create index and mention scanning type 
db.employee.find({firstName : "Noha"}).explain()
db.employee.createIndex({ firstName : 1},{name : "IX_name_Zag"})  /// COLLSCAN

//b. Try find().explain after create index and mention scanning type 
db.employee.createIndex({ firstName : 1},{name : "name_Zag"}) 
db.employee.find({firstName : "Mona"}).explain() //"IXSCAN"

//7. Drop demo database 
db.employee.drop()









 