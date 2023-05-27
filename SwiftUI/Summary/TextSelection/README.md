# **#56 TextSelection**


### **`TextSelection`**

### 아래의 이미지와 같이 텍스트를 길게 눌렀을 때 Copy, Share 와 같은 기능을 사용할 수 있도록 해주는 유용한 기능입니다
<br>


<img src="https://github.com/HunyongSeong/SwiftUIStudy/assets/108869319/38591f70-11bd-4303-82cb-cbea25a8bda3">
<img src="https://github.com/HunyongSeong/SwiftUIStudy/assets/108869319/afcca02b-d502-4be0-b8a9-144ea3c44917">
<br>

<br>

`아래와 같은 간단한 코드로 적용이 가능합니다.`
<br>

```swift
//
//  TextSelectionBootcamp.swift
//  SwiftUIBootcamp
//
//  Created by David Goggins on 2023/05/25.
//

  Text("Hello, World!")
      .textSelection(.enabled) //enabled: 활성화 //disable: 비활성화
```
