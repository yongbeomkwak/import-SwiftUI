# Haptic


## 목차

### 1. 해당 영상에서는 2가지 방식으로 진동을 만들어 낸다.

-   UINotificationFeedbackGenerator
-   UIImpactFeedbackGenerator

<br>

## HapticManager
```swift
class HapticManager {
    
    static let instance = HapticManager() // 싱글톤

    
    func notification(type:UINotificationFeedbackGenerator.FeedbackType){
        
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type) //진동
    }
    
    func impact(style:UIImpactFeedbackGenerator.FeedbackStyle){
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred() // 진동
    }
    
}
```

<br>

### 1. UINotificationFeedbackGenerator.FeedbackType

#### 단순 진동이 아닌 약간 뒤끝이 있음
- .success : 완료를 알리는 알림 진동 , 약간 띠딩 느낌
- .warning : 경고 알림 진동, 띠..딩 느낌
- .error : 에러를 알림 , 가장 독특한 진동, 또로로롱 느낌 뭔가 굴러가는 느낌

<br>

### 2. UIImpactFeedbackGenerator.FeedbackStyle

#### 단순 진동 느낌 , 강도만 달라짐 
- .soft
- .light
- .medium
- .rigid
- .heavy
