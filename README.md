# ExtendFuture


## How it work

Create 2 Future function

```swift

import Combine

func plusInt(a: Int, b: Int) -> Future<Int, Never> {
    return Future<Int, Never> { promise in
        promise(.success(a+b))
    }
}

func plusFloat(a: Int, b: Int) -> Future<Int, Never> {
    return Future<Int, Never> { promise in
        promise(.success(a+b))
    }
}

```

### 1. Wait

```swift
// Future Await extension
let a = try! plusInt(a: 4, b: 5).await()
let b = try! plusFloat(a: 3, b: 5).await()

print(a + b)

```
Ouput: 17

### 2. Then

```swift
// Future Then extension
let d = try! plusInt(a: 1, b: 1)
    .then {
        plusFloat(a: $0, b: 3)
    }
    .then {
        plusFloat(a: $0, b: 1)
    }
    .await()

print(d)

```
Ouput: 6


## Contact
- Email: caophuocthanh@gmail.com
- Site: https://onebuffer.com
- Linkedin: https://www.linkedin.com/in/caophuocthanh/

