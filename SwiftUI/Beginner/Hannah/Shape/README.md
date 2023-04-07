# Shapes

<br>

## **Fill & Stroke**
<br/>



  <img src="https://user-images.githubusercontent.com/126866283/230525332-bde71ab8-ef99-4996-8bbe-0b1ce0ab13c6.png">
</p>

https://youtu.be/RKfkG01x79w?t=570

```swift
Circle()
	.fill(Color.green)                   // 색 채우기 1
	.foregroundColor(.green)             // 색 채우기 2
	.stroke()                            // 검은 테두리 생성
	.stroke(Color.blue)                  // 테두리 색
	.stroke(.blue, lineWidth: 5.0)       // 테두리 색, 두께 지정

  .stroke(.orange, style: StrokeStyle(lineWidth: 20, lineCap: .butt, dash: [10]))
	// StrokeStyle(lineWidth: _, lineCap: _, lineJoin: _, miterLimit: _, dash: _, dashPhase: _)
	// 원하는 것 선택 사용 가능
```
<br>

### **round와 square가 butt보다 길어보이는 이유**

.butt은 기준선 길이와 막대의 길이가 같고, .round와 .square는 기준선의 **양 끝에도 두께 처리**가 돼서 실제로는 더 길어보인다

<img src="https://user-images.githubusercontent.com/126866283/230527399-03a784cb-311f-4187-9331-9223df218742.png" width="400">

<br>
<br>

#

## **Trim**
<br>

### **1. 원하는 범위대로 자르기**
<br>

<p align="center">
  <img src="https://user-images.githubusercontent.com/126866283/230527736-02d5319f-7678-4047-a1d7-96d1efe174b1.png">
</p>

https://youtu.be/1dWHjdWgS5M?t=377

```swift
Circle()
	.trim(from: 0.0, to: 1.0)      // 전체 원 그려짐
  	.trim(from: 0.5, to: 1.0)      // 0.5 지점부터 1.0 지점까지 위로 둥근 반원
	.trim(from: 0.0, to: 0.5)      // 0.0 지점부터 0.5 지점까지 아래로 둥근 반원
```
<br>
<br>

### **2. Stroke 주기**
<br>

<p align="center">
  <img src="https://user-images.githubusercontent.com/126866283/230530422-cca4ed60-3057-4498-9d3f-4d4468f78505.png">
</p>

https://youtu.be/RKfkG01x79w?t=653

```swift
Circle()
	.trim(from: 0.2, to: 1.0)              // 0.2 부터 1.0 trim
  .stroke(.purple, lineWidth: 50)        // 테두리 색, 두께
```
- 잘린 모양대로 원 테두리를 주고 싶으면 무조건 trim 이후 stroke 설정하기 !
- 로딩 화면에서 인터랙션 아이콘으로 많이 쓰이는 코드

<br>
<br>

#

## **그 외 다양한 도형**
<br>

### **Capsule()**
<br>
<p align="center">
  <img src="https://user-images.githubusercontent.com/126866283/230535291-e5a8d1be-9a68-4971-9bec-35e133851c50.png">
</p>

https://youtu.be/1dWHjdWgS5M?t=535

```swift
VStack {
	Capsule(style: .circular)            // .circular는 사각형에서 모서리만 둥글게
		.frame(width: 300, height: 200)
	Capsule(style: .continuous)          // .continuous는 부드러운 타원 느낌
		.frame(width: 300, height: 200)
}
```

<br>
<br>

### **RoundedRectangle()**
<br>

- 자주 쓰이는 도형(버튼)
<p align="center">
  <img src="https://user-images.githubusercontent.com/126866283/230535746-eb576200-09b5-4345-bbce-5ea77547b49e.png">
</p>

https://youtu.be/1dWHjdWgS5M?t=610

```swift
RoundedRectangle(cornerRadius: 50).   // 모서리 라운드값 설정
	.frame(width: 300, height: 200)
```