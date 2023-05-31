# **#8 Mask**

별 5개로 평가하는 뷰

```swift
struct MaskView: View {
    
    @State var rating: Int = 3
    
    var body: some View {
        ZStack{
            HStack{
                ForEach(1..<6) { index in
                    Image(systemName: "star.fill")
                        .font(.largeTitle)
                        .foregroundColor(rating >= index ? Color.yellow : Color.gray)
                        .onTapGesture {
                            rating = index     //해당 인덱스를 클릭할 때마다 rating도 변하도록 함. 
                        }
                }
            }
        }
    }
}
```
삼항연산자로 index가 rating보다 작거나 같으면 노란색이 되도록 함. 

![화면 기록 2023-05-31 오전 2 58 37](https://github.com/yongbeomkwak/SwiftUI-Study/assets/87987002/8acec45f-e665-4b5f-b8bb-53bbdf73a2b9)
아무런 애니메이션 없이 변하기만 하는 상태


<br>
<br>

## Mask를 통해 애니메이션 넣어주기

```swift
struct MaskView: View {
    
    @State var rating: Int = 3
    
    var body: some View {
        ZStack{
            starsView
                .overlay(
                    GeometryReader{ geometry in
                        ZStack(alignment: .leading) {   //사각형 왼쪽 정렬
                            Rectangle()
                                .foregroundColor(.yellow)
                                .frame(width: CGFloat(rating)/5*geometry.size.width)    //5분의 3 * 가로 길이 
                        }
                    }
                )
        }
    }
    
    private var starsView: some View {      //왜 private을 썼지
        HStack{
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
                    .onTapGesture {
                        rating = index
                    }
            }
        }
    }
}
```

startsView를 따로 만들어서 뷰를 그려주고, 그 위에 overlay로 Rectangle을 하나 넣어준다. <br>
rating만큼 가로길이를 조절하기 위해 geometry.size. width의 5분의 3만큼 가로 길이를 설정한다. 

<img width="704" alt="스크린샷 2023-05-31 오전 3 52 15" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/87987002/05c7757c-eb19-471a-9a5e-a3161b0976db">

<br>
<br>

```swift
struct MaskView: View {
    
    @State var rating: Int = 3
    
    var body: some View {
        ZStack{
            starsView
                .overlay(overlayView.mask(starsView))
        }
    }
    
    private var overlayView: some View {
        GeometryReader{ geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.yellow)
                    .frame(width: CGFloat(rating)/5*geometry.size.width) 
            }
        }
    }
      .allowsHitTesting(false)    //onTapgesture가 사각형에는 없으므로, 유저가 사각형은 클릭하지 못하도록 해야함.  
    
    private var starsView: some View {   
        HStack{
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
                    .onTapGesture {
                      withanimation(.easeInOut){
                        rating = index
                      }
                    }
            }
        }
    }
}
```
사각형을 따로 overlayView로 빼고 starsView만큼 .mask하면 원하는 뷰 그려짐

![화면 기록 2023-05-31 오전 4 04 48](https://github.com/yongbeomkwak/SwiftUI-Study/assets/87987002/fa175b2e-baf7-4f19-9945-44b63bfd0a31)
