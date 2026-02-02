db.createCollection("students", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            title: "Student Required Input",
            required: ["name", "age", "code"],
        }
    }
})


db.students.insertOne({ _id: 1, dep: "HR", "name": "eman", "age": 15 }) //code

db.students.insertOne({ _id: 1, dep: "HR", "name": "eman", "age": 15, code: "VIP" })

db.students.insertOne({ _id: 2, dep: "HR", "name": 123, "age": "ahmed", code: "VIP" })

db.createCollection("students", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            title: "Student Object Validation",
            required: ["address", "major", "name", "year"],
            properties: {
                name: {
                    bsonType: "string",
                    description: "'name' must be a string and is required"
                },
                year: {
                    bsonType: "int",
                    minimum: 2017,
                    maximum: 3017,
                    description: "'year' must be an integer in [ 2017, 3017 ] and is required"
                },
                gpa: {
                    bsonType: ["double", "int"],
                    description: "'gpa' must be a double if the field exists"
                }
            }
        }
    }
})
// required: ["address", "major", "name", "year"],
//name : Required + string
//year : Required + int + Range(Min, Max)
//"address", "major" : Required Only
//gpa : Optional => Incase of insertion dobule 3.2 Or int 3

db.students.insertOne({ _id: 2, dep: "HR", name: "ahmed", major: "CS", year: 2026, address: "cairo" })


db.students.insertOne({ _id: 3, gpa: 3.2, dep: "HR", name: "ahmed", major: "CS", year: 2026, address: "cairo" })


db.runCommand({
    collMod: "students",
    validator: {
        $jsonSchema: {
            bsonType: "object",
            required: ["username", "password"],
            properties: {
                username: {
                    bsonType: "string",
                    description: "username must be a string and is required"
                },
                password: {
                    bsonType: "string", minLength: 6,
                    description: "must be a string of at least 6 characters, and is required"
                }
            }
        }
    }
})



db.students.insertOne({ username: "mohamed", password: "123ahf" })

db.students.insertOne({ address: "alex" })





db.runCommand({
    collMod: "students",
    validator: {  }
})


db.students.insertOne({ address: "alex" })




