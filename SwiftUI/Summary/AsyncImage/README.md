# **#54 AsyncImage**


### **`비동기 이미지 사용방법`**
비동기 이미지란?

<br>

- **`비동기 이미지는 웹 개발에서 사용되는 개념으로, 이미지를 로드하는 동안 페이지의 다른 요소들이 브라우저에서 동작할 수 있도록 하는 방식을 말합니다.`** 일반적으로 이미지를 로드하는 동안 브라우저는 이미지가 완전히 로드될 때까지 다른 작업을 차단하고 기다리게 됩니다. 이는 페이지의 사용자 경험을 저하시키거나 페이지가 느리게 로드되는 원인이 될 수 있습니다.

- 비동기 이미지는 이러한 문제를 해결하기 위해 도입된 기술입니다. **`비동기 이미지 로딩은 이미지를 별도의 스레드나 백그라운드 작업으로 처리하여 페이지의 다른 요소들과 병행하여 로드되게 합니다. 이를 통해 페이지의 로딩 속도를 향상시킬 수 있고, 사용자가 페이지를 더 빠르게 볼 수 있게 됩니다.`**

<br>

***`반대로 동기는 해당 작업이 완료될 때 까지 다른 작업 실행이 불가능합니다.`**

<br>
<br>


<img src="https://github.com/HunyongSeong/SwiftUIStudy/assets/108869319/1f540c99-d857-405c-b6cd-f61af9c55cc3">

```swift
import SwiftUI
struct AsyncImageBootcamp: View {
    
    let url = URL(string: "https://picsum.photos/400")

    // AsyncImage: 비동기 이미지
    var body: some View {
        AsyncImage(url: url) // iOS 15.0 버전 이상에서 사용 가능
            .frame(width: 100, height: 100) // <- 적용 X
    }
}

struct AsyncImageBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageBootcamp()
    }
}
```

비동기로 이미지를 불러왔을 떄 프레임을 100x100으로 설정해도 이미지에 적용이 되지 않는다.
<br>
→ 하지만 아래처럼 content와 placeholder을 추가해주면 이미지의 사이즈를 조정할 수 있다.

<br>
<br>

<img src="https://github.com/HunyongSeong/SwiftUIStudy/assets/108869319/feead9a1-1a01-4023-85a7-046685d0d0a2">

```swift
struct AsyncImageBootcamp: View {
    
    let url = URL(string: "https://picsum.photos/400")
    
    var body: some View {
        AsyncImage(url: url, content: { returnedImage in
            returnedImage
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
        }, placeholder: {
            ProgressView()
        })
    }
}
```

### **`💡 위 코드에 대한 설명`**
<aside>

해당 코드는 SwiftUI를 사용하여 비동기 이미지 로딩을 구현하는 뷰를 정의하는 것입니다.

`AsyncImageBootcamp`은 **`View`** 프로토콜을 구현한 구조체입니다.

**`let url = URL(string: "https://picsum.photos/400")`**은 비동기 이미지의 URL을 지정하는 상수입니다. 이 예시에서는 "**[https://picsum.photos/400"의](https://picsum.photos/400%22%EC%9D%98)** URL을 사용하고 있습니다.

`body`는 `some View`를 반환하는 컴퓨티드 프로퍼티입니다. 이 프로퍼티는 실제 뷰의 내용을 정의합니다.

`AsyncImage`는 비동기적으로 이미지를 로드하는 뷰입니다. `url`을 통해 지정된 URL에서 이미지를 비동기적으로 가져와서 표시합니다. 이때 `content`와 `placeholder` 두 가지 클로저를 사용합니다.

**`content`** 클로저는 비동기적으로 로드된 이미지(**`returnedImage`**)를 매개변수로 받아 사용합니다. `returnedImage`에 대해 `resizable()`과 `scaledToFit()`을 적용하여 이미지 크기를 조정하고, `frame`을 사용하여 이미지의 크기를 100x100으로 설정합니다.

**`placeholder`** 클로저는 이미지 로딩 중에 표시될 임시 뷰를 정의합니다. 
이 예시에서는 `ProgressView()`**를 사용하여 로딩 중임을 나타냅니다.

따라서, **`AsyncImageBootcamp`** 뷰는 지정된 URL에서 이미지를 비동기적으로 로드하고, 로딩 중에는 `ProgressView()`를 표시하며, 로드된 이미지가 나타나면 해당 이미지를 크기 100x100으로 조정하여 표시합니다.

</aside>

<br>
<br>

### **`비동기 이미지를 불러왔을 때 생길 수 있는 문제점을 아래와 같이 해결 하였습니다.`**

**생길 수 있는 이슈**
1. case empty -> No image is loaded.(이미지가 아직 로드 되지 않은 경우)
2. case success(Image) -> An image succesfully loaded.(이미지 로드 성공)
3. case failure(Error) -> An image failed to load with an error.(이미지 로딩 실패)


import SwiftUI

/*
 case empty -> No image is loaded.
 case success(Image) -> An image succesfully loaded.
 case failure(Error) -> An image failed to load with an error.
 */

<br>

```swift
struct AsyncImageBootcamp: View {
    
    let url = URL(string: "https://picsum.photos/400")
    
    var body: some View {
        AsyncImage(url: url) { phase in // phase == AsyncImagePhase 타입
            switch phase {
            case .empty:
                ProgressView() // 이미지 로딩 중 표시(로딩중...동글뱅이 표시)
            case .success(let returnedImage): // 성공시 보여줄 화면
                returnedImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(20)
            case .failure: // 실패시 questionmark 이미지 표시
                Image(systemName: "questionmark")
                    .font(.headline)
            default: // 그 외, questionmark 이미지 표시
                Image(systemName: "questionmark")
                    .font(.headline)
            }
        }
    }
}

```

<br>

### **`💡 위 코드에 대한 설명`**

이 코드는 SwiftUI에서 AsyncImage를 사용하여 비동기 이미지를 로드하는 예제입니다. AsyncImage는 비동기적으로 이미지를 로드하고 다양한 로딩 상태에 따라 다른 뷰를 표시할 수 있는 기능을 제공합니다.

<br>

코드의 주요 부분은 `AsyncImage(url: url) { phase in ... }`입니다. `AsyncImage`는 주어진 URL에서 이미지를 비동기적으로 로드합니다. `AsyncImage`의 클로저 매개변수인 `phase`는 **`AsyncImagePhase`**라는 열거형 타입입니다. `phase`는 로딩 상태를 나타내며, 다음과 같은 경우를 처리할 수 있습니다:

- **`.empty`**: 아직 이미지가 로드되지 않은 상태입니다. 이 경우 `ProgressView()`를 표시하여 로딩 중임을 알립니다.
- **`.success(let returnedImage)`**: 이미지가 성공적으로 로드된 상태입니다. **`returnedImage`** 매개변수로 로드된 이미지를 받아와 원하는 방식으로 표시할 수 있습니다. 위 예제에서는 이미지를 크기에 맞게 조정하고, 테두리를 둥글게 처리한 후 **`scaledToFit()`** 및 `cornerRadius()`를 적용하여 이미지를 표시하고 있습니다.
- **`.failure`**: 이미지 로드가 실패한 상태입니다. 이 경우 "questionmark" 시스템 아이콘을 사용하여 이미지 로드 실패를 나타내고 있습니다.
- 기타 다른 상태: 위 예제에서는 다른 상태에 대해서도 `.failure`과 동일한 처리를 하고 있습니다.

비동기 이미지 로딩을 위해 `AsyncImage`는 내부적으로 URL 세션을 사용하며, 이미지를 비동기적으로 로드하여 메모리 관리와 성능을 개선합니다. 또한, `AsyncImage`는 이미지 로드 중에 뷰를 업데이트하기 때문에 사용자에게 로딩 상태를 시각적으로 보여줄 수 있습니다.

주석 처리된 코드 부분은 이전 버전의 `AsyncImage` 구문으로, iOS 15 이전 버전에서 사용할 수 있습니다. iOS 15 이후 버전에서는 첫 번째 구문이 권장되는 방식입니다.

