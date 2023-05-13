# **#43 TabView**

```swift
    var body: some View {
        TabView {
            Text("Home TAB")
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            Text("BROWSE TAB")
                .tabItem {
                    Image(systemName: "globe")
                    Text("Browse")
                }
            Text("PROFILE TAB")
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
        .accentColor(.green)      //선택된 tabitem의 컬러를 바꿀 수 있다
    }
```
![화면 기록 2023-05-09 오전 1 04 02](https://user-images.githubusercontent.com/87987002/236875417-e0e63f03-4dac-43d5-9a07-fb05bc61005e.gif)

.tabitem 내부에 label을 사용할 수도 있음. 

<br>
<br>


## 배경 삽입
```swift
struct TabViewView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            Text("BROWSE TAB")
                .tabItem {
                    Image(systemName: "globe")
                    Text("Browse")
                }
            
            Text("PROFILE TAB")
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
        .accentColor(.green)
    }
}

struct TabViewView_Previews: PreviewProvider {
    static var previews: some View {
        TabViewView()
    }
}

----------------------------------------------------------------------------------

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.red.ignoresSafeArea()
            Text("HOME TAB")
                .foregroundColor(.white)
                .font(.largeTitle)
        }
    }
}
```
<img width="400" alt="스크린샷 2023-05-09 오전 1 25 15" src="https://user-images.githubusercontent.com/87987002/236877715-f09012b3-706a-4f3c-87a4-03b5e3852693.png">

cmd누르고 Zstack을 클릭해서 Extract Subview로 배경을 따로 뺀것. Rename으로 한번에 뷰 이름을 바꿀 수도 있다. <br> 실제로 앱을 만들 때는 HomeView파일이 따로 생성될 것. 

<br>
<br>






## **버튼을 생성해서 탭 전환**
![화면 기록 2023-05-09 오전 4 25 26](https://user-images.githubusercontent.com/87987002/236915035-8789657a-969f-4b1f-9eb7-25ab92a38f04.gif)

- tabitem을 눌러서 탭을 전환하는 방법 외에 **selectedtab**을 변경해서 탭을 전환할 수 있다. 
- @State로 바인딩하면 해당 페이지의 tag값으로 뷰를 새로 그려줄 수 있음. 이제 selectedtab 값이 업데이트될 때 탭을 전환할 수 있다.

<br>

```swift
struct TabViewView: View {
    @State var seletedTab:Int = 0   //selectedTab이라는 변수 정의
    
    var body: some View {
            TabView(selection: $seletedTab) {   //tabview의 매개변수 selection을 통해 바인딩할 수 있음

                HomeView(selectedTab: $seletedTab)  //HomeView를 초기화할 때 변수를 바인딩 해야함
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .tag(0)    //각 tab에 고유 색인을 부여하기 위해 tag 지정
                
                 Text("BROWSE TAB")
                    .tabItem { ... }
                    .tag(1)
                
                Text("PROFILE TAB")
                    .tabItem { ... }
                    .tag(2)
            }
            .onAppear() {
                UITabBar.appearance().scrollEdgeAppearance = .init()   
            }   //IOS 15부터는 이렇게 해야 기본 탭바 구분선 스타일이 적용됨
        }
    }


struct TabViewView_Previews: PreviewProvider {
    static var previews: some View {
        TabViewView()
    }
}

----------------------------------------------------------------------------------

struct HomeView: View {
    @Binding var selectedTab: Int   //다른 뷰에서 selectedtab을 변경하려면 Binding을 사용해야함. 
    
    var body: some View {
        ZStack {
            Color.red.ignoresSafeArea()
            VStack {
                Text("HOME TAB")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                Button {
                    selectedTab = 2     //버튼을 누르면 selectedtab값이 바뀜
                } label: {
                    Text("Go to profile")
                        .font(.headline)
                        .padding()
                        .padding(.horizontal)
                        .background(Color.white)
                        .cornerRadius(10)
                    
                }
            }


        }
    }
}
```


<br>

값이 자동으로 업데이트 되는 걸 바인딩이라고 한다. 
```$```는 Binding 한 변수를 $표시로 넘겨준다는 뜻. 그렇게 하면 다른 뷰에서 변하는 변수값이 동기화된다. State에서 는 안쓰고 Binding을 쓸 때만 쓴다. 



<br>
<br>

> tab bar 구분선 스타일 참고 - https://green1229.tistory.com/234

<br>
<br>
<br>

## **PageTabViewStyle**
- page controls 컴퍼넌트 추가하는 코드

```swift
var body: some View {
    TabView {
        RoundedRectangle(cornerRadius: 25)
            .foregroundColor(.red)
        RoundedRectangle(cornerRadius: 25)
        RoundedRectangle(cornerRadius: 25)
            .foregroundColor(.green)
    }
    .tabViewStyle(PageTabViewStyle())
}
```
![화면 기록 2023-05-09 오전 4 35 07](https://user-images.githubusercontent.com/87987002/236916770-d93c6cac-8d3e-43e1-8018-3d5c3abe3871.gif)

<br>
<br>

## **캐러셀에 이미지 삽입**
```swift
    let icons : [String] = [
    "heart.fill", "globe", "house.fill", "person.fill"
    ]
    
    var body: some View {
        TabView {
            ForEach(icons, id: \.self) { icon in
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .padding(30)
            }
        }
        .background(Color.red)
        .frame(height: 300)
        .tabViewStyle(PageTabViewStyle())
```
![화면 기록 2023-05-09 오전 5 07 11](https://user-images.githubusercontent.com/87987002/236923348-70c9ffca-61d1-4d0e-b568-71eec825871a.gif)