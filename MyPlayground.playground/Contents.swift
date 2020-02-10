import UIKit


/*
var str = "Hello, playground"

func sayHello(to name: String, positive: Bool = true) {
    if positive {
        print("Hello \(name) I like you")
    } else {
        print("Huh.. \(name)")
    }
}

sayHello(to: "Jarda")
sayHello(to: "Dominik", positive: false)


enum PasswordError: Error {
    case obvious
}

func checkPassword (_ password: String) throws ->
    Bool {
        if (password) == "password" {
            throw PasswordError.obvious
        }
        return true
    }


do {
    try (checkPassword("password"))
    print("You can use this password")
} catch {
        print("Dont use this password")
}

let driving = {

    print("I am driving in my car")
}

driving()

let drivingParam = { (place: String) -> String in
    var x = 0
    x += 1
    return ("I am driving \(place)")
}


print(drivingParam("Disney"))

func drivingFunction() {
    print("I am driving car")
}

*/

/*

func travel(action: (String) -> Void) {
    print("Getting ready...")
    action("London")
    print("You are in place that u choose")
}


travel { (place: String) in
    print("You are goint to \(place)")
}

struct Sport {
    var name: String
    var isOlympicSport: Bool
    
    var olympicStatus: String {
        if isOlympicSport {
            return "\(name) is olympic sport"
        } else {
            return "\(name) is not olympic sport"
        }
    }
}

var tenis = Sport(name: "Tennis", isOlympicSport: true)
print(tenis.olympicStatus)

tenis.isOlympicSport = false
print(tenis.olympicStatus)


struct Progress {
    var task: String
    var amount: Int {
        didSet {
            print("\(task) is now \(amount) %")
        }
    }
}

var progress = Progress(task: "Loading data", amount: 0)
progress.amount = 30
progress.amount = 60
progress.amount = 100


let string = "Do or do not, there is no try"
print(string.count)
print(string.hasPrefix("Do"))
print(string.uppercased())
print(string.sorted())


print(string.customMirror)
print(string.debugDescription)

struct User {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

var newuser = User(name: "Petr")
print(newuser.name)


struct City {
    var population: Int
    
    mutating func mutateProperty() {
        population *= 5
    }
    
    func taxSystem() -> Int {
        return population * 20
    }
}

var city = City(population: 100)
city.mutateProperty()
print(city.population)
print(city.taxSystem())


*/



struct FamilyTree {
    init() {
        print("Creating family tree")
    }
}

struct Person {
    
    static var numberOfPersons = 0
    
    private var id: Int
    var fName: String
    var lName: String
    var age: Int
    
    var canDrive: Bool {
        return age > 18 ? true : false
    }
    
    var fullName: String {
        return ("\(fName) \(lName)")
    }
    
    var acountBalance: Int {
        didSet {
            print("Your acount has now $\(acountBalance)")
        }
    }
    
    lazy var familyTree = FamilyTree()
    
    let ahoj = {
        print("Ahooj")
    }
    func ahoj2() -> Void {
        print("Ahooj")
    }
    
    init(fName: String, lName: String, age: Int, acountBalance: Int) {
        self.fName = fName
        self.lName = lName
        self.age = age
        self.acountBalance = acountBalance
        Person.numberOfPersons += 1
        self.id = Person.numberOfPersons
    }
    
    
    mutating func doubleAge() {
        age *= 2
    }
    
    func fullReviewOfPerson() -> String {
        return "Hi my name is \(fullName) I am \(age) years old. And my secret id is \(id) 💪 "
    }
    
}

var p1 = Person(fName: "Jára", lName: "Janda", age: 22, acountBalance: 1000)

print(p1.fullReviewOfPerson())
p1.ahoj()
p1.ahoj2()

enum WeatherType {
    case sunny
    case rainy(mm: Int)
    case cloud
    
    func getWeatherOverView(weather: WeatherType) -> String? {
        switch weather {
        case .cloud:
            return "Cloudy today"
        case .sunny:
            return "Nice sun today"
        case .rainy(let mm):
            return "Today is raining with \(mm) mm"
        }
    }
}


print(WeatherType.getWeatherOverView(.cloud))
print(WeatherType.getWeatherOverView(.rainy(mm: 20)))



func iAmDoing(action: () -> Void ) {
    print("I am now doing \(action())")
}
