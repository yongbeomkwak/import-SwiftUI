# SpriteKit

목차 추가 예정

## SpriteKit이란
-   2013년 WWDC에서 발표된 맥 생태계 전용 2D게임 개발용 API
-   iOS에 최적화, Metal API를 지원
-   iOS의 라이브러리를 자유롭게 가져다 쓸 수 있다.

 *Metal API: GPU관련 그래픽 처리 엔진* 

---
<br>

## SpriteKit의 구조

- 일반 앱과는 달리 단 하나의 뷰컨트롤를 사용
- 뷰 컨틀롤러 위에 Scence을 올림
- Scence 위에 노드를 올림 , 노드는 아이템,플레이어 등 다양한 객체를 말함
- 뷰컨틀롤러에서 미리 준비되어 있는 Scence을 교체하여 화면 전환 함.

 1. **SKView** 
 - Sprite Kit의 기본 뷰이다. 
 - 이 뷰는 각 장면 컨텐츠를 렌더링하여 표시하는 일을 한다. 
 - 이는 UIView를 서브클래싱하여 만들어진다.
 2. **SKScene**
 - 뷰는 장면들을 전환하여 보여줄 수 있다. 
 - SKScene은 각 장면에 해당하는 클래스이다. 
 - 장면은 화면에 등장하는 컨텐츠 구성요소인 Node들을 관리하게 된다. 
 - 또한 사용자 터치 이벤트를 이곳에서도 처리할 수 있다.
 3. **SKNode**
 - 장면 내의 배경, 캐릭터, UI요소 등은 모두 SKNode로 표현된다. 
 - SKNode는 노드트리를 구성하며, 각각의 노드는 액션(SKAction)을 실행하여 애니메이팅 된다고 보면 된다.

---
<br>

## Node의 종류
<br>

### 모든 노드는 SKNode의 하위 클래스이다.

<br>

 ### 1.  SKLabelNode

-  텍스트를 이용한 Label을 표현할 때 사용 

 ### 2. SKSpriteNode
    
- 이미지를 보여줄 때 사용

 ```swift
let land = SKSpriteNode(imageNamed: "land")
land.position = CGPoint(x: width/2, y: 50)
land.zPosition = 3 // 숫자가 클수록 화면 뒤쪽으로 배치 
self.addChild(land)
```

 ### 3. SKSapeNode
    
-  도형을 그릴 때 사용

 ### 4. SKEmitterNode
 
-  특수 효과를 발생시킬 때 사용
 ### 5. SKEffectNode 

-  코어 이미지 필터를 자식노드에 적용 합니다.(카메라 필터와 비슷)

 ### 6.   SKVideoNode

-  비디오를 재생해주는 노드 입니다.
 ### 7 6. SKCropNode

-  마스크를 이용해서 노드를 잘라 낼수 있습니다.

---
<br>

## 필드 종류

 ### 1. physicsBody

 - Scence 내 각 노드들이 물리적인 상호작용<br>
(충돌, 중력의 적용, 힘을 받아 움직이거나 회전)을 하는 경우라면<br> 노드의 physicsBody 속성을 정의하고, 그 속성들을 조정할 수 있다.


<br>

---
<br>

## 초기화

1. init()
2. sceneDidLoad()
3. didMove(to:)


<br>

## 콜백함수
1. update(_:)
2. didBegin(_:)
3. touches
   -  Began
   -  Moved
   -  Ended
   -  Cancelled(_:with:)

<br>

## ScaleMode

<br>

<img width="1376" alt="스크린샷 2023-03-30 오후 10 24 55" src="https://user-images.githubusercontent.com/48616183/228850861-00485047-4018-469b-bd15-4479716fac2e.png">

<br>

1. aspectFit
-   씬 너비 또는 높이 중 짧은 쪽이 기준으로 화면에 가득차게 확대한다.

2. aspectFill
-  씬 너비 또는 높이 중 긴 쪽을 기준으로 화면에 가득차게 확대한다.

3. fill
- 비율에 관계 없이 화면에 가득차게 확대

4. resizeFill
-  씬을 조정하지 않고 기기에 보여질 화면까지만 보여준다.

<br>

## 스프라이트 아틀라스

<img width="1137" alt="스크린샷 2023-03-31 오후 5 06 06" src="https://user-images.githubusercontent.com/48616183/229062735-7d32a8e9-3dac-4a13-902a-3186cdffaa1d.png">


### 장점
-  그림파일을 불러들이는 횟수가 줄어준다
-  메모리 최적화
-  Xcode에서는 .spriteatlas 폴더에 있는 파일에 대해 컴파일타임에 최적화된 스프라이트아틀라스를 자동으로 작성해 준다.

<br>

## 애니메이션 만들기

1. SpriteKit Action

- 한 프레임당 발생하는 사이클

<img width="885" alt="스크린샷 2023-03-31 오후 6 52 13" src="https://user-images.githubusercontent.com/48616183/229089830-2bfa3d71-61f6-43bf-a680-4d55100177cb.png">

<br>

## 충돌 판정

### 1. physicsBody는 .categoryBitMask 속성으로 판정한다

-  #### UInt32을 이용
-  #### ex)
   -  0 미사용
   -  Player(001) = 1
   -  Coin(010)  = 2
   -  미사용(011) = 3 (미사용, 1이 두개 들어갔기 때뮨에)
   -  적(100) = 4
   -  충돌(101) = 1 + 4  (플레이어와 적과 충돌)

### .collisionBitMask
-  충돌을 체크해야 하는 객체마스크를 기입한다.

### .contactTestBitMask
-  두 객체가 접촉콜백으로 시스템에 알려준다.
-  물리적 변화 없음
-  접촉을 확인해야 하는 객체마스크를 기입한다.

<br>

### 노드에 따른 비용

<img width="963" alt="스크린샷 2023-04-01 오후 3 21 03" src="https://user-images.githubusercontent.com/48616183/229269434-71c0a522-63db-42c8-b067-d1d314e4014d.png">

<br>

## AnchorPoint

<img width="957" alt="스크린샷 2023-04-01 오후 7 19 28" src="https://user-images.githubusercontent.com/48616183/229280432-4b269a1a-189c-4481-866a-d4373d22703a.png">

<br>

### 앵커포인트 : 어디를 기준으로 붙히냐
-   0.5, 0.5 : 스프라이트의 중심을 기준으로
-   0,0: 좌하단 기준
-   0,1: 좌상당 기준
-   1,0: 우하단 기준
-   1,1: 우상단 기준

<br>

### 텍스트 정렬

<img width="879" alt="스크린샷 2023-04-01 오후 7 22 51" src="https://user-images.githubusercontent.com/48616183/229280685-9d0bb7d6-f861-4667-aa66-aeceac0dd7ba.png">

-  .vertical
   -   .Baseline: 폰트기준 하단 (삐져 나올 수 있음)
   -   .Bottom : 빠져가자지 않는 박스 하단
   -   .Center : 센터
   -   .Top: 상단

-  .horizontal
   - .Left: 왼쪽
   - .Center: 중앙
   - .Right: 오른쪽

## 스테이트 머신

> ### 유한 상태 기계(Finite State Machine, FSM)
>
> ###  게임의 요소를 잘게 분해하여 하나의 상태로 만들고 그 상태들의 집합을 관리하거나 전환하는 관리자를 스테이트 머신이라 한다.


<br>

## SKAction

### 노드에 움직임을 부여하는 클래스


1. Moving
- To: A부터 B까지 , By: Amount를 지정하면 그 만큼
-  .moveTo,By:  a부터 b까지 이동 
-  .roateTo,By: 회전 
-  .scaleTo,By: 배수를 주면 커졌다 ,작아졌따
-  .resizeTo,By: 절대값을 주면 , 확대 또는 축소
-  .followPath: SKShapeNode로 Path를 그려주면 그 Path에 따라 이동한다.
-  .speed: 동작의 스피드 

2. Shape
-  .setTexture: 이미 있는 위에 텍스쳐를 합쳐주는
-  .colorize: 노드의 색깔을 변경
-  .fadeAlpha: 노드에 알파값 적용 

3. Timing
-  .sequence: 지정된 SKAction을 순서대로 실행줌
<img width="558" alt="스크린샷 2023-04-02 오후 2 23 25" src="https://user-images.githubusercontent.com/48616183/229333162-5ce3b5a5-6456-4f68-a4ed-6287dad03b82.png">

-  .group: 지정된 SKAction들을 동시에 실행, 끝나는 시간은 지정된 Action 중 가장 긴 것을 기준으로 같이 종료됨
<img width="408" alt="스크린샷 2023-04-02 오후 2 24 11" src="https://user-images.githubusercontent.com/48616183/229333189-6a786b01-9b13-4cb4-bd2a-03965a96c578.png">

- .wait:Duration만큼 멈춤
<img width="560" alt="스크린샷 2023-04-02 오후 2 26 24" src="https://user-images.githubusercontent.com/48616183/229333274-2c338ae5-0148-4232-9d42-88360746694f.png">

-  .repeat: 정해진 반복
-  .repeatForever: 무한히 반복

- .timingMode: 액션의 속도
   -  .linear: 일정한 속도
   -  .easeIn: 초반에 느리고 후반에 빠르게
   -  .easeOut: 초반에 빠르고 후반에 느리게
   -  .easeInEaseOut: 초반 느림, 중간 빠름, 후반 느림
 

## 사운드

### Sound Effect
-  재생 후 종료되는 사운드
-  SKAction.playSoundFileNamed

### BGM
- 여러가지 효과가 필요한 사운드
-  SKAudionode


<br>

## 파티클 이미터

-  입자를 방출하는 특수효과
-  전용 에디터를 이용하면 손쉽게 만들 수 있음

### 파티클 이미터 속성
-  Range: 범위
-  스피디의 단위 = point/second
-  Texture: 입자로 사용할 텍스처
-  Emitter Birthrate: 초당 생성될 입자 수
-  Emitter Maximum: 생성되는 입자의 총 개수 (0은 무한)
-  Lifetime: 한 개의 입자가 사라질 때까지의 시간(초)
-  Position : 입자 발생하는 범위
-  Angle: 입자의 초기발생 각도
-  Speed: 입자의 초기 속도
-  Acceleration: 입자에 가해진 가속도
-  Alpha: 입자의 투명도
-  Scale: 입자의 크기
-  Rotation: 입자의 회전 양
-  Color Blend: 지정한 색을 얼마나 반영할 것인 지
-  Color Ramp: 입자의 색
-  Blend Mode: 입자의 블렌딩 모드, 초기값은 Add
   -  Add는 검은 배경에서 에디터에서와 동일하게 보이거나 흰 배경에서 하얗게 변하는 문제가 있음
   -  블렌딩 모드가 Alpha이면 배경색의 영향을 안 받지만 Add와는 다르게 뿌연 효과가 들어간다.
   -  Add모드와 SkEffectNode를 조합하면 문제 해결
