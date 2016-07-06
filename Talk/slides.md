# Network Testing
#### _@pepibumur - iOS Developer at_ SoundCloud

---

### How many of you implement
#_unit tests_
### in your projects?
## 🙋

---

## Specta, _Expecta_, OCMock, __OCMockito__, Quick, _Nimble_, __Kiwi__, _OCHamcrest_

---

## We test _units_ of code
## 📦

---

![](Images/Unit-Tests.png)

---

## _Integration_ tests

---

## We test the units of code
### _As a system_ :package: ↔️ :package:

---

### :package: *can* work as expected
### ↔️ but *not* the integration

---

![](Images/Integration-Tests.png)

---

### **But...**
## Your components are used by *ViewControllers*

---

### And these ones
## Have a *lifecycle*
## 🔁

---

### Controlled by your
## application *Users*
## 👨‍👨‍👦‍👦

---

## 👨‍👨‍👦‍👦
## Are part of the *system*

---

## :package: ↔️ 👨‍👨‍👦‍👦 ↔️  :package:

---

### _And we should test it..._
# Don't we?
### 😬

---

### How many of you implement
##_acceptance tests_
### in your projects?
## 🙋

---

![](Images/Acceptance-Tests.png)

---

### *They rely on Accessibility*
## Thus, the UI layer

---

```swift
let app = XCUIApplication()
app.launch()
app.buttons["Stream"].tap()
app.tables.staticTexts["Enrique Iglesias"].tap()
```

---

### **We test from the**
## User's viewpoint

---

# But...

---

### *Non-UI stuff*
#### **(That depends on the views lifecycle)**
## Is also taking place

---

# 🌍
### Networking

---

```swift
class StreamViewController: UIViewController {
  func viewDidLoad() {
    super.viewDidLoad()
    self.syncService.sync() // SYNC REQUEST
    self.eventGateway.screen("Stream") // ANALYTICS REQUEST
  }

  func userDidSelectTrack(track: Track) {
    self.eventGateway.event("open_player") // ANALYTICS REQUEST
  }
}
```

---

#### 🌍that reflects on UI
## API interaction
#### 🌍that doesn't reflect on UI
## Analytics

---

#### *API interaction*
## Can be tested with Acceptance Tests

---

```swift
let app = XCUIApplication()
app.launch()
app.buttons["Stream"].tap() //-----> REQUEST SENT
let enriqueCell = app.tables.staticTexts["Enrique Iglesias"]
enriqueCell.tap() // -----> REQUEST :+1:
```

---

### But Analytics...

---

```swift
let app = XCUIApplication()
app.launch()
app.buttons["Stream"].tap() //-----> SCREEN EVENT SENT
let enriqueCell = app.tables.staticTexts["Enrique Iglesias"]
enriqueCell.tap() // -----> WAS IT REALLY SENT?
```

---

# Szimpla
### _Network Testing in Swift_
#### github.com/pepibumur/szimpla

![image](images/szimpla.jpg)

---

![image, 90%](images/Szimpla-Schema.png)

---

## Only 3️⃣ Steps

---

### 1. Record the Snapshot

---

```swift
class AppUITests: XCTestCase {

    var app: XCUIApplication!
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testDefault() {
        try! Szimpla.instance.start()
        let app = XCUIApplication()
        app.buttons["Navigate"].tap()
        try! Szimpla.instance.record(path: "CMDUConf.json")
    }
}
```

---

### 2. Validate the Snapshot

---

```json
[
  {
    "url": "https://api.soundcloud.com/tracks/1235123",
    "parameters": {},
    "body": {}
  }
]
```

---

```json
[
  {
    "url": "https://api.soundcloud.com/tracks/[0-9]+",
    "parameters": {},
    "body": {}
  }
]
```

---

### 3. Update the test

---

```swift
class AppUITests: XCTestCase {

    var app: XCUIApplication!
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testDefault() {
        try! Szimpla.instance.start()
        let app = XCUIApplication()
        app.buttons["Navigate"].tap()
        try! Szimpla.instance.validate(path: "CMDUConf.json")
    }
}
```

---

## Spanshot Approach
#### *(Inspired by Facebook Snapshot Testing)*

---

### _Supports_
## Custom Validators

---

```swift
public protocol Validator {
    func validate(recordedSnapshot recordedSnapshot: Snapshot, localSnapshot: Snapshot) throws
}
```

---

### _Supports_
## Custom Filters

---

```swift
public protocol RequestFilter {
    func include(request request: NSURLRequest) -> Bool
}
```

---

## Analytics Team
### __Can validate the snapshots__
#### It's a JSON file! :tada:
### :memo:

---

## Live Demo
### :grinning: 🌴

![fill](images/Barcelona.jpeg)

---

## References
- [Szimpla](https://github.com/pepibumur/szimpla)
- [Facebook Snapshot Testing](https://github.com/facebook/ios-snapshot-test-case)
- [Swifter HTTP Server](https://github.com/httpswift/swifter)
- [Unsplash](https://unsplash.com)

---

# Gràcies :grinning:
### Questions?
#### Slides (SpeakerDeck) - [http://bit.ly/29xRq7m](http://bit.ly/29ekocn)
#### pepibumur - pepibumur@gmail.com

![fill](images/Montjuic.jpeg)
