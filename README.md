# JSONModelMapper

## Introduction
[动手写个 JSON-Model Mapping 库](http://www.jianshu.com/p/72aafbd39fa7)

## Usage

Demo JSON:

{
  "array": [
    {
      "birthday": 2015-12-24,
      "name": "sheepy"
    },
    {
      "birthday": 2015-12-24,
      "name": "sleepy"
    }
  ],
  "boolean": true,
  "number": 123,
  "string": "Hello World"
}

### Define Model

```swift
class JSONModel: NSObject {
    var array = []
    var boolean = false
    var number = 0
    var string = ""
}

class PersonModel: NSObject {
    var birthday = NSDate()
    var name = ""
}
```

### Send request and convert data to optional model

```swfit
getDataFromUrl(Constant.DemoAPI, method: .GET, parameter: nil) { data, error in
    if let jsonData = data {
        let jsonModel = jsonData => JSONModel.self
    }
    
    if let httpError = error {
        print(httpError)
    }
}
```

### Convert AnyObject to optional model

```swift
if let model = jsonModel {
    let person = model.array[0] => PersonModel.self 
}
```

### Convert model to NSData 

```swift
let data = person => NSData.self
```

### Convert model to Dictionary

```swfit
let dict = person.convertToDictinary()
```
