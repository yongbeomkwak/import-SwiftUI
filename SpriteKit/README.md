# SpriteKit


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

---
<br>

## Node의 종류
<br>

> 모든 노드는 SKNode의 하위 클래스이다.

<br>

1.  SKLabelNode

    텍스트를 이용한 Label을 표현할 때 사용 

2. SKSpriteNode
    
    이미지를 보여줄 때 사용

3. SKSapeNode
    
    도형을 그릴 때 사용

4. SKEmitterNode, SKEffectNode

    특수 효과를 발생시킬 때 사용


