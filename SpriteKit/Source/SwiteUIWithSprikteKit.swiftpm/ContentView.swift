import SwiftUI
import SpriteKit

class GameScence: SKScene {
    override func didMove(to view: SKView) {
        // 물리적인 작용이 있어 phsicsBody 필드를 선언
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        //첫번 째 터치를 인식
        guard let touch = touches.first else {return}
        
        //현재 뷰에서 터치 위치를 찾음
        let location = touch.location(in: self)
        
        /*
          1. W:50 H:50  빨간색 노드 정의
          2. 노드 위치 지정
          3. 해당 노드가 물리적인 작용을 해야하므로 물리바디 지정(모양:사각형 W:50 ,H:50)
          4. 생성
        */
        
        let box = SKSpriteNode(color:.red,size: CGSize(width: 50, height: 50))
        box.position = location
        box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        
        addChild(box)
        
        
    }
}

struct ContentView: View {
    
    var scence: SKScene {
        let scence = GameScence()
        scence.size = CGSize(width: 300, height: 400)
        scence.scaleMode = .fill
        return scence
         
    }
    
    var body: some View {
        SpriteView(scene: scence)
            .frame(width: 300,height: 400)
    }
}
