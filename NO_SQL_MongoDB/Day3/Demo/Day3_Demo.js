//Index

use Demo

db.employee.insertMany([
    { _id: 1, fName: "mohamed", lName: "ahmed", age: 15 },
    { _id: 2, fName: "noha", lName: "mahmoud", age: 25 },
    { _id: 3, fName: "malak", lName: "mohamed", age: 35 },
    { _id: 4, fName: "mazen", lName: "mohamed", age: 45 },
    { _id: 5, fName: "eman", lName: "ali", age: 55 }])


//Index Types --Simple - Single

//Before Index
db.employee.find({})

//Custom Field

db.employee.find({ fName: "mohamed" }).explain() //COLLSCAN

db.employee.find({ lName: "ahmed" }).explain() //COLLSCAN

//PK
db.employee.find({ _id: 2 }).explain() //IXSCAN

//Create Index
db.employee.createIndex({ fName: 1 })

db.employee.createIndex({ fName: 1 }, { name: "IXEmpFName" })

//After Inxex Created 
db.employee.find({ fName: "mohamed" }).explain() //IXSCAN

db.employee.find({ lName: "ahmed" }).explain() //COLLSCAN

//Index Data
db.employee.getIndexes()

//Drop Index
db.employee.dropIndex("fName_1")

db.employee.dropIndex("IXEmpFName")



//--Types --Componud Index
//Before Index
db.employee.find({})

//Custom Field

db.employee.find({ fName: "mohamed" }).explain() //COLLSCAN

db.employee.find({ lName: "ahmed" }).explain() //COLLSCAN

db.employee.find({ fName: "mohamed", lName: "ahmed" }).explain() //COLLSCAN

//Create Index
db.employee.createIndex({ fName: 1 })

db.employee.createIndex({ fName: 1, lName: 1 }, { name: "IXEmpName" })

db.employee.createIndex({ lName: 1, fName: 1 }, { name: "IXEmpName" })

//After Inxex Created 
db.employee.find({ fName: "mohamed" }).explain() //IXSCAN

db.employee.find({ lName: "ahmed" }).explain() //COLLSCAN

db.employee.find({ fName: "mohamed", lName: "ahmed" }).explain() //IXSCAN


//T-T-L
use AI

db.eventlog.find({})

db.eventlog.insertMany([{
    _id: 3, name: "Ordered", date: ISODate("2025-01-01")
},
{
    _id: 4, name: "new", date: ISODate("2026-01-24")

}])


db.eventlog.createIndex({ date: 1 }, { expireAfterSeconds: 1 })

db.eventlog.find({})
