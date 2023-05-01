# **#16 Grids**

### **LazyVGrid, LazyHGrid**

- **Why Lazy? → array 안에 있다가 부를 때만 화면에 나타나기** 때문에 게으르다고 표현.
    - grid가 lazy할수록 우리는 편해진다.
    
<br>

## 1) 폭이 고정되어 있는(.fixed()) Grid 선언

LazyVGrid definition을 확인해보면, **column** is in an **array** of grid item (**`[GridItem]`**).

So, `[columns]`를 `[GridItem]`**의 형식으로 initializing을 해보자!**


<img src="https://user-images.githubusercontent.com/126866283/235301659-83865c4f-35ea-4371-a547-070bbe76f978.png">

```swift
let columns: [GridItem] = [
	GridItem(.fixed(50), spacing: nil, alignment: nil),
	GridItem(.fixed(50), spacing: nil, alignment: nil),
  GridItem(.fixed(100), spacing: nil, alignment: nil),
  GridItem(.fixed(50), spacing: nil, alignment: nil),
  GridItem(.fixed(50), spacing: nil, alignment: nil),
  // grid 하나에 가로 폭이 50 or 100으로 고정되어 있고, 나머지는 x
]
```

`[GridItem]` 내 문장의 수 = 화면이 가로로 몇 등분으로 나뉠지 정해줌

<br>
<br>

### **LazyVGrid의 사용**

- view에서 LazyVGrid를 불러온 후, ForEach 구문으로 높이가 50으로 고정인 사각형을 그려보자.

```swift
var body: some View {
	LazyVGrid(columns: columns) {
            
		ForEach(0..<6) { index in
			Rectangle()
				.frame(height: 50)
		}
	}
}
```

<img src="https://user-images.githubusercontent.com/126866283/235301730-3584f7c7-1149-44c3-aff8-8f6b2d956b91.png" width=200>

→ LazyVGrid는 **위에서 아래**로, **오른쪽에서 왼쪽**으로 차례대로 하나씩 그려진다.


<br>

```swift
var body: some View {
	LazyVGrid(columns: columns) {
            
		ForEach(0..<50) { index in
			Rectangle()
				.frame(height: 50)
		}
	}
}
```
<img src="https://user-images.githubusercontent.com/126866283/235301768-d6f0c439-48c9-4e5c-8cef-9aa74e527f3f.png" width=200>

<br>
<br>


## 2) 폭이 유동적인(.flexible) Grid 선언

- `.flexible`은 폭을 정해두지 않았기 때문에, 화면 전체를 덮기 위해 자동으로 맞춰진다.
- column의 개수를 알아서 n등분 한다
- **[ ] 안의 줄 개수대로 row 생성**
- ⭐️⭐️⭐️ 세가지 옵션 중 가장 많이 쓰임

![image.jpg1](https://user-images.githubusercontent.com/126866283/235301851-cc5748de-7106-490c-ad47-ed099116ece9.png) |![image.jpg2](https://user-images.githubusercontent.com/126866283/235301871-be848755-83a2-4023-8ac4-0cfec572e07e.png)
--- | ---


아까처럼 view에서 LazyVGrid로 높이가 50인 사각형 50개를 그린다고 가정했을 때,

```swift
// (1) column 1개
let columns: [GridItem] = [
	GridItem(.flexible(), spacing: nil, alignment: nil)
]
```

```swift
// (2) column 5개
let columns: [GridItem] = [
	GridItem(.flexible(), spacing: nil, alignment: nil),
	GridItem(.flexible(), spacing: nil, alignment: nil),
	GridItem(.flexible(), spacing: nil, alignment: nil),
	GridItem(.flexible(), spacing: nil, alignment: nil),
	GridItem(.flexible(), spacing: nil, alignment: nil),
]
```
<br>
<br>

## 3) (.adaptive) Grid 선언

- `.adaptive` 은 정해진 minimum~maximum 폭 내에서 한 column에 최대한 많은 사각형을 포함시키도록 자동으로 출력해줌.
- 줄이 여러 개이면 그만큼 세로로 화면을 나눠서 각자 코드에 맞는 결과물을 꽉 채워서 뱉음

아까처럼 view에서 LazyVGrid로 높이가 50인 사각형 50개를 그린다고 가정했을 때,

![image.jpg1](https://user-images.githubusercontent.com/126866283/235301915-316e45ca-b631-481f-98f6-f66428e80fb7.png) |![image.jpg2](https://user-images.githubusercontent.com/126866283/235301939-58379f12-a168-46dd-a50e-ebcb2e34cb30.png)
--- | ---



```swift
// (1) 한 줄에 폭 50인 사각형 6개가 들어가고, 위에서부터 차례로 사각형 50개가 출력됨
let columns: [GridItem] = [
	GridItem(.adaptive(minimum: 50, maximum: 300), spacing: nil, alignment: nil),
]
```

```swift
// (2) 화면을 세로로 이등분 한 후, 절반은 폭 50인 사각형 38개, 나머지 절반은 폭 150인 사각형 12개
let columns: [GridItem] = [
	GridItem(.adaptive(minimum: 50, maximum: 300), spacing: nil, alignment: nil),
  GridItem(.adaptive(minimum: 150, maximum: 300), spacing: nil, alignment: nil),
]
```

