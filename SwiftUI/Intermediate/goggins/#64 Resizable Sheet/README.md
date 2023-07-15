# #64 Resizable Sheet

<br>

## Sheet Size 조정하기
일반적으로 우리가 알고 있던 시트기능

<br>
<img width="80%" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/108869319/eafded10-6518-437c-8335-bfc73cfebf0c"/>

<br>
<br>

```swift
//
//  ResizableSheetBootcamp.swift
//  SwiftUIBootcamp
//
//  Created by David Goggins on 2023/07/11.
//

import SwiftUI

struct ResizableSheetBootcamp: View {
    
    @State private var showSheet: Bool = false
    
    var body: some View {
        Button("Click me") {
            showSheet.toggle()
        }
        .sheet(isPresented: $showSheet) {
            MyNextView()
								.presentationDetents([.large]) // Detents: 미끄럼을 막는 장치
								.presentationDragIndicator(.hidden)

								// .presentationDetents([.fraction(0.1), .medium, .large])
								//  < .large, .medium, .fraction(0.1) > Sheet의 사이즈 비율을 결정

                                // .presentationDetents([.height(200)]) // 높이

								// .interactiveDismissDisabled() // 시트가 사라지지 못하게 막는 역할
        }
    }
}

struct MyNextView: View {
    
    var body: some View {
        Text("Hello, world!!!!")
    }
}

struct ResizableSheetBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ResizableSheetBootcamp()
    }
}
```

<br>
<br>

### presentationDetents를 이용한 Sheet Size 조정
<br>

<img width="80%" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/108869319/49d25904-482d-40c7-a9ee-46d5451a0e48"/>

<br>

<br>

```swift
.presentationDetents([.large]) // Detents: 미끄럼을 막는 장치
.presentationDragIndicator(.hidden)

// .presentationDetents([.fraction(0.1), .medium, .large])
//  < .large, .medium, .fraction(0.1) > Sheet의 사이즈 비율을 결정

// .presentationDetents([.height(200)]) // 높이

// .interactiveDismissDisabled() // 시트가 사라지지 못하게 막는 역할

```

```swift
//
//  ResizableSheetBootcamp.swift
//  SwiftUIBootcamp
//
//  Created by David Goggins on 2023/07/11.
//

import SwiftUI

struct ResizableSheetBootcamp: View {
    
    @State private var showSheet: Bool = false
    @State private var detents: PresentationDetent = .large
    
    var body: some View {
        Button("Click me") {
            showSheet.toggle()
        }
        .sheet(isPresented: $showSheet) {
            MyNextView(detents: $detents)
        }
        .onAppear {
            showSheet = true
        }
    }
}

struct MyNextView: View {

    @Binding var detents: PresentationDetent
    
    var body: some View {
        ZStack {
            Color.red.ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                Button("20%") {
                    detents = .fraction(0.2)
                }
                
                Button("MEDIUM") {
                    detents = .medium
                }
                
                Button("600px") {
                    detents = .height(600)
                }
                
                Button("LARGE") {
                    detents = .large
                }
            }
        }
        .presentationDetents([.medium, .large, .fraction(0.2), .height(600)], selection: $detents)
        //presentationDetents 에서 설정한 [.medium, .large, .fraction(0.2)] 이것만 detents로 설정할 수 있음
        .presentationDragIndicator(.hidden) 

    }
}

struct ResizableSheetBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ResizableSheetBootcamp()
    }
}
```
