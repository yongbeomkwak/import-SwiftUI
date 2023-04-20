# #4 Color
## primary, secondary color

```
RoundedRectangle(cornerRadius: 25)
    .fill(Color.primary)
```
primary는 라아트모드에서는 기본적으로 Black이고, 다크모드에서는 White로 보임. 

<br>


>왜 난 **Color Literal** 안보이지 <br>
>사용자 지정 가능하다고 함. Color Wheel, 슬라이더, 프리셋 팔레트, 스펙트럼 탭등이 있다. <br>
슬라이더에서 Hex color 지정 가능

<br>

## UIColor

```swift
        RoundedRectangle(cornerRadius: 25)
            .fill(Color(color: UIColor.blue)     )
            
            //. 찍으면 UIKit의 다양한 컬러들에 쉽게 접근할 수 있음. 몇가지 추가 색상이 있는 것 빼고는 기본 컬러와 동일함, 
```
```swift
        RoundedRectangle(cornerRadius: 25)
            .fill(Color(color: UIColor.secondarySystemBackground)     )
            
            //SystemBackground 유용하게 설정가능. 현재 배경과 같은 색으로 설정해줌. 
            //secondarySystemBackground는 연한 회색을 보여주는데 자주 쓰기 좋다. 
            //이 System 컬러들은 다크보드에서도 자동으로 적절하게 변경됨. 
```

<br>

## 그림자 설정

```swift
        RoundedRectangle(cornerRadius: 25)
            .frame(width: 300, height: 200)
            .shadow(radius: 10)
```
기본 그림자 설정

```swift
        RoundedRectangle(cornerRadius: 25)
            .frame(width: 300, height: 200)
            .shadow(color: Color.red.opacity(0.3), radius: 10, x: 0, y: 20)
```
<img width="604" alt="스크린샷 2023-04-20 오후 1 42 07" src="https://user-images.githubusercontent.com/87987002/233260079-c5f5f865-98c7-41a5-9121-26721d871f66.png">



일케 자세하게 설정할 수도 있음. 
  
