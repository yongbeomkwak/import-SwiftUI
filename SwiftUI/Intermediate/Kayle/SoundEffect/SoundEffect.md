# SoundEffect

## 들어가기 전 알아야할 개념

<br>

### 싱글톤 패턴(Singleton)이란?

<br>

객체의 인스턴스가 오직 **1개**만 생성되는 패턴을 의미한다. 

<br>

### 쓰는 이유
<br>

1. 메모리 측면

- 최초 한번의 생성자를 통해서 고정된 메모리 영역을 사용하기 때문에 추후 해당 객체에 접근할 때 메모리 낭비를 방지할 수 있다.
 
- 뿐만 아니라 이미 생성된 인스턴스를 활용하니 속도 측면에서도 이점이 있다고 볼 수 있다.

2. 데이터 공유가 쉽다

- 싱글톤 인스턴스가 전역으로 사용되는 인스턴스이기 때문에 다른 클래스의 인스턴스들이 접근하여 사용할 수 있다. 
- 하지만 여러 클래스의 인스턴스에서 싱글톤 인스턴스의 데이터에 동시에 접근하게 되면 동시성 문제가 발생할 수 있으니 이점을 유의해서 설계하는 것이 좋다.

### 단점

1. 유지보수 비용이 높아질 수 있다.
-   싱글톤의 인스턴스가 너무 많은 일을 하거나 많은 데이터를 공유시킬 경우 다른 클래스와 결합도가 높아져 객체 지향 설계 원칙이 어긋나 수정이 어려워 진다.

2. 멀티스레드 환경
-   멀티스레드 환경에서 **동기화** 처리를 안할 경우 인스턴스가 1개보다 많이 생서 될 수 있다.

---

<br>

## 내용

### 1. 사운드 재생을 위해 AVKit을 사용한다.
### 2. Bundle을 이용하여 파일의 경로를 읽어온다.
### 3. 싱글톤 패턴을 이용한 SoundManager를 이용한다.

<br>

## SoundManager
```swift

import AVKit

class SoundManager {
    
    static let instance = SoundManager() // 싱글톤
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        case tada
        case duck
    }
    
    func playSound(sound:SoundOption) {
        
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else {return}
        //해당 음원파일.mp3 파일의 경로를 읽어 온다
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play() // 재생
        }   catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
        
    }
}

```

<br>

## View

```swift
struct ContentView: View {
    

    
    var body: some View {
        VStack{
            
            Button("Play sound 1"){
                SoundManager.instance.playSound(sound: .tada)
            }
            
            Button("Play sound 2"){
                SoundManager.instance.playSound(sound: .duck)
            }

        }
        .padding(40)

    }

}
```
