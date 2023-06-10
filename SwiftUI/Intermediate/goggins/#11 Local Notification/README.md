# LocalNotification

## LocalNotification 이란?
스위프트 유아이와 관련하여 응용 프로그램을 만드는 경우 중요한 로컬 알림에 대해서 알아보겠습니다.
로컬알림은 ex) 매주 월요일 5시 알람처럼, 실제로 우리가 설정해서 사용하는 알람이라고 볼 수 있음.
하지만 인스타그램처럼 누군가가 내 사진에 좋아요를 누르고 나한테 알림이 뜨는 경우에는 서버가 필요함.

<br>

### 코드 설명에 앞서서 우리는 앞으로 아래의 4가지 알림에 대해서 알아볼 것입니다.
<br>

`(1)알림과 관련한 권한`

`(2)시간과 관련한 알림`

`(3)날짜와 관련된 알림`

`(4)위치와 관련된 알림`

<br>

### 먼저 모든 알림 요청을 관리할 클래스를 만들기 위해 싱글톤을 만든다.
<br>

```swift
 class NotificationManager {
    static let instance = NotificationManager() 
}
```
싱글톤을 사용하면 애플리케이션 전체에서 하나의 인스턴스를 공유할 수 있습니다. 이는 메모리와 리소스를 절약하는 데 도움이 될 수 있습니다. 예를 들어, 여러 개의 객체가 동일한 알림 관리자를 사용해야 하는 경우에 싱글톤을 사용하면 모든 객체가 동일한 인스턴스를 참조할 수 있습니다.

<br>
<br>

## (1)알림과 관련한 권한

### 앱을 사용할 때 알림(알림, 소리, *배지 등)을 사용할 수 있는 권한을 요청합니다.

*badge(배지): 메세지 왔을 때, 카톡 아이콘 옆에 숫자 1 뜨는 것. 

<br>

<img src="https://github.com/HunyongSeong/MovieDiary/assets/108869319/1c73f0ee-7ca8-4a0f-888f-93aea2e9dab2" width=300 >

<br>

```swift

import SwiftUI
import UserNotifications

class NotificationManager {
    
    static let instance = NotificationManager() // 싱글톤
  
    func requestAuthorization() { // 앱을 사용할 때 알림 권한을 요청
        let options: UNAuthorizationOptions = [.alert, .sound, .badge] // 알림, 소리, 배지
        
        // 위에서 정의한 options을 아래로 전달 -> (options: options)
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error { // 만약(권한 요청 자체에) 오류가 있다면, 방금 얻은 오류를 출력
                print("ERROR: \(error)")
            } else {
                print("SUCCESS") // 권한 요청 자체에 오류가 없다면, 허락하지 않는다고 해도 SUCCESS 라고 나오게 됨
            }
        }
    }
}
```

```swift

struct LocalNotificationBootcamp: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Request permission") { // 버튼 클릭시, 권한 요청
                NotificationManager.instance.requestAuthorization()
        }
    }
}

```
<br>
<br>

## (2)시간과 관련한 알림

코드설명: 버튼을 누르면 5초 후에 알림을 줍니다.

<br>

<img src="https://github.com/HunyongSeong/MovieDiary/assets/108869319/52c55e44-2f48-40ab-b32f-362e747340bc" width=300 >

<br>

```swift

func scheduleNotification() { // 일정 알림
        
    let content = UNMutableNotificationContent() // 알림에 들어갈 내용들 / 개체를 생성
    content.title = "This is my first notification!" //제목
    content.subtitle = "This was soooooo easy!" //부제
    content.sound = .default //소리
    content.badge = 10000 // badge == 앱 아이콘 옆에 뜰 배지를 사용
    
    // time trigger
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false) // 시간의 간격을 이용한 알림
    //(timeInterval: 5.0, repeats: false) // (시간 간격, 반복)
    // 일정을 잡은 후 5초가 지나면 해당 트리거를 가져와 아래의 let request에 전달한다.(앱을 나갔을 경우)

		// request
    let request = UNNotificationRequest(
        identifier: UUID().uuidString, // 추적을 할 필요가 없기 때문에 UUID().uuidString을 사용
        content: content, // 알림의 내용들
        trigger: trigger) // time, calendar, locagion / 설정한 트리거에 맞게 요청

    UNUserNotificationCenter.current().add(request) // 설정한 알림 요청을 마지막에 호출
}

struct LocalNotificationBootcamp: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Request permission") { // 버튼 클릭시, 권한 요청
                NotificationManager.instance.requestAuthorization()
            }
            Button("Schedule Notification") { // 일정 알림 만들기
                NotificationManager.instance.scheduleNotification()
            }
        }
    }
}

```
`UNMutableNotificationContent` 개체를 생성한 후에는 다양한 속성을 설정하여 제목, 부제, 본문, 소리, 배지, 첨부 파일과 같은 알림 콘텐츠를 사용자 지정할 수 있습니다.

<br>

### * 알림에서 identifier: UUID().uuidString를 사용하는 이유는?

<br>

*식별자는 특정 알림 요청을 식별하는 데 사용되며 예약하는 각 요청에 대해 고유한 값을 제공하는 것이 중요합니다. 동일한 식별자로 여러 알림을 예약하면 동일한 식별자를 가진 이전 알림이 새 알림으로 대체됩니다.

**`UUID().uuidString`** 를 사용하면 코드가 실행될 때마다 고유한 문자열 식별자를 생성합니다. 이렇게 하면 알림 요청이 충돌하거나 우발적으로 교체되는 것을 방지할 수 있습니다. 

UUID를 식별자로 사용하는 것은 고유한 값을 생성하는 신뢰할 수 있는 방법을 제공하여 각 알림 요청이 고유하게 식별되도록 하기 때문에 일반적인 관행입니다.



<br>
<br>

## (3)날짜와 관련된 알림

원하는 요일과 시간에 반복하여 알림을 줄 수 있음

<br>

```swift

import SwiftUI
import UserNotifications

class NotificationManager {
    
    static let instance = NotificationManager() // 싱글톤: 모든 알림 요청을 관리할 클래스를 만들기 위해 싱글톤을 만듬
  
    func requestAuthorization() { // 앱을 사용할 때 알림 권한을 요청
        let options: UNAuthorizationOptions = [.alert, .sound, .badge] // 알람, 소리, 배지
        
        // 위에서 정의한 options을 아래로 전달 -> (options: options)
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error { // 만약 오류가 있다면, 방금 얻은 오류를 출력
                print("ERROR: \(error)")
            } else {
                print("SUCCESS")
            }
        }
    }
    func scheduleNotification() { // 스케줄 알람
        
        let content = UNMutableNotificationContent()
        content.title = "This is my first notification!" //title
        content.subtitle = "This was soooooo easy!" //subtitle
        content.sound = .default // sound
        content.badge = 10000 // badge == 앱 아이콘 옆에 뜰 배지
        
        // calendar trigger
        var dateComponents = DateComponents() // 비어있는 날짜 생성
        dateComponents.hour = 11 // 시간 추가
        dateComponents.minute = 27 // 분 추가
        dateComponents.weekday = 6 // 요일 추가 / 일(1), 월, 화, 수, 목, 금, 토(7)

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true) // 일정을 이용한 알림 / 설정을 통하여 매주 매일 알림을 줄 수 있음
        
        // request ============================
        let request = UNNotificationRequest(
            identifier: UUID().uuidString, // 이 identifier와 그냥 region의 identify는 무슨 차이가 있을까?
            content: content,
            trigger: trigger) // time, calendar, locagion / 설정한 트리거에 맞게 요청
        // request ============================
        UNUserNotificationCenter.current().add(request) // 설정한 알림 요청을 마지막에 호출
    }
}

struct LocalNotificationBootcamp: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Request permission") { // 버튼 클릭시, 권한 요청
                NotificationManager.instance.requestAuthorization()
            }
            Button("Schedule Notification") { // 일정 알림 만들기
                NotificationManager.instance.scheduleNotification()
            }
        }
    }
}

```

<br>
<br>

## (4)위치와 관련된 알림

원하는 요일과 시간에 반복하여 알림을 줄 수 있음

<br>

```swift

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
    
    static let instance = NotificationManager() // 싱글톤
  
    func requestAuthorization() { // 앱을 사용할 때 알림 권한을 요청
        let options: UNAuthorizationOptions = [.alert, .sound, .badge] // 알람, 소리, 배지
        
        // 위에서 정의한 options을 아래로 전달 -> (options: options)
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error { // 만약 오류가 있다면, 방금 얻은 오류를 출력
                print("ERROR: \(error)")
            } else {
                print("SUCCESS")
            }
        }
    }
    func scheduleNotification() { // 스케줄 알람
        
        let content = UNMutableNotificationContent()
        content.title = "This is my first notification!" //title
        content.subtitle = "This was soooooo easy!" //subtitle
        content.sound = .default // sound
        content.badge = 10000 // badge == 앱 아이콘 옆에 뜰 배지
        
        // location trigger
        let coordicates = CLLocationCoordinate2D( // coordicates: 좌표 <- 이곳에서 좌료를 설정
            latitude: 40.00, // 위도
            longitude: 50.00) // 경도

        let region = CLCircularRegion( // 중심점 주위에 반경이 100 미터인 영역을 추가 후 사용자가 해당역엑에 들어갈 때, 나갈 때 알림을 줄 수 있음
            center: coordicates, // 중심
            radius: 100,        // 반지름: 중심점에서 가장자리까지 미터 단위로 측정 됨
            identifier: UUID().uuidString)
        region.notifyOnEntry = true // 반경에 진입 시 알림
        region.notifyOnExit = true // 반경에서 퇴장 시 알림
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true) // 위치를 이용한 알림
        // import CoreLocation 해주면 (region: , repeats: )을 사용할 수 있다.
        
        // request ============================
        let request = UNNotificationRequest(
            identifier: UUID().uuidString, // 이 identifier와 그냥 region의 identify는 무슨 차이가 있을까?
            content: content,
            trigger: trigger) // time, calendar, locagion / 설정한 트리거에 맞게 요청
        // request ============================
        UNUserNotificationCenter.current().add(request) // 설정한 알림 요청을 마지막에 호출
    }
    
    func cancelNotification() { // 알림을 취소하기
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests() // 예약된 알림 메세지 제거
        UNUserNotificationCenter.current().removeAllDeliveredNotifications() // 받은 알림들 제거 즉 이미 확인한 알람 제거: 즉, 알림 창 제거
    }
    
}


struct LocalNotificationBootcamp: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Request permission") { // 버튼 클릭시, 권한 요청
                NotificationManager.instance.requestAuthorization()
            }
            Button("Schedule Notification") { // 일정 알림 만들기
                NotificationManager.instance.scheduleNotification()
            }
            Button("Cancel Notification") { // 알림 취소하기
                NotificationManager.instance.cancelNotification()
            }
        }
        .onAppear { // 앱이 다시 빌드가 되면, 배지 숫자가 0으로 변경
            UIApplication.shared.applicationIconBadgeNumber = 0 
        }
    }
}

```
<br>

### 전체알림을 제거하는 것이아닌 identifiers의 값을 확인하고 선택적으로 삭제하는 방법

```swift

// 보류 중인 알림 요청을 제거하는 함수
    func removePendingNotifications() {
        let identifiers: [String] = ["notification1", "notification2", "notification3"]
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
        
        // 제거한 알림 요청의 개수 출력
        print("Removed \(identifiers.count) pending notification requests.")
    }

    ```