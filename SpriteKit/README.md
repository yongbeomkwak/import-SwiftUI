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