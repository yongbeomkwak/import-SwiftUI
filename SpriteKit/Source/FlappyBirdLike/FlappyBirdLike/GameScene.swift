//
//  GameScene.swift
//  FlappyBirdLike
//
//  Created by yongbeomkwak on 2023/03/31.
//

import SpriteKit

class GameScene: SKScene {
    
    var bird = SKSpriteNode()
    var scoreLabel = SKLabelNode()
    var score:Int = 0 {
        didSet {
            scoreLabel.text = "\(score)"
        }
    }
 
    override func didMove(to view: SKView) {
        //초기화 진행
        
        self.physicsWorld.contactDelegate = self // 앱안에서 일어나는 충돌을 게임씬이 관리함
        //SKPhysicsContactDelegate 채택해야함
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8) // 중력
        createBird()
        createEnvironment()
        createInfinitePipe(4)
        createScore()
        
       
        
    }
    
    func createScore() {
        scoreLabel = SKLabelNode(fontNamed: "Minercraftory")
        scoreLabel.fontSize = 24
        scoreLabel.fontColor = .white
        scoreLabel.position = CGPoint(x: self.size.width/2, y: self.size.height - 60)
        scoreLabel.zPosition = Layer.hud
        scoreLabel.horizontalAlignmentMode = .center
        scoreLabel.text = "\(score)"
        addChild(scoreLabel)
        
    }
    
    func createBird() {
        let width = self.size.width
        let height = self.size.height
        
       
        
        bird = SKSpriteNode(imageNamed: "bird1")
        bird.position = CGPoint(x: width/2, y: 350)
        bird.zPosition = Layer.bird
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: bird.size.height/2)
        bird.physicsBody?.categoryBitMask = PhysicsCategory.bird
        
        bird.physicsBody?.contactTestBitMask = PhysicsCategory.land | PhysicsCategory.pipe | PhysicsCategory.ceiling | PhysicsCategory.score
        
        
        bird.physicsBody?.collisionBitMask = PhysicsCategory.land | PhysicsCategory.pipe | PhysicsCategory.ceiling
        
        bird.physicsBody?.isDynamic = true // 부딪히면 영향 받음
        bird.physicsBody?.affectedByGravity = true // 중력 영향
        
        
        self.addChild(bird)
        
         // 코드로 애니메이션 삽입
//        let birdTexture = SKTextureAtlas(named: "Bird")
//        var aniArray = [SKTexture]()
//
//        for i in 1...birdTexture.textureNames.count {
//            aniArray.append(SKTexture(imageNamed: "bird\(i)"))
//        }
//
//        let flyingAnimation = SKAction.animate(with: aniArray, timePerFrame: 0.1)
//        bird.run(.repeatForever(flyingAnimation))
        
        
        //.sks 파일에서 flynig이라는 Action 가져오기
        guard let flyingBySKS = SKAction(named: "flying") else {return}
        bird.run(flyingBySKS)
        
    }
    
    func createEnvironment() {
        
        let width = self.size.width
        let height = self.size.height
        
        let envAltas = SKTextureAtlas(named: "Environment")
        
        let landTexture = envAltas.textureNamed("land")
        let landWidth = landTexture.size().width
        let landRepeatNum = Int(ceil(width / landWidth))
        
        
        let skyTexture = envAltas.textureNamed("sky")
        let skyWidth = skyTexture.size().width
        let skyRepeatNum = Int(ceil(width / skyWidth))
        
        let ceilngTexture = envAltas.textureNamed("ceiling")
        let ceilingWidth = ceilngTexture.size().width
        let ceilingRepeatNum = Int(ceil(width / ceilingWidth))
       
        
        //화면의 전체 크기를 land의 크기로 나눈 올림값
        
        for i in 0...landRepeatNum {
            let land = SKSpriteNode(texture: landTexture)
            land.anchorPoint = .zero
            // 앵커포인트 : 어디를 기준으로 붙히냐
            // 0.5, 0.5 : 스프라이트의 중심을 기준으로
            // 0,0: 좌하단 기준
            // 1,1: 우상단 기준
            
            land.position = CGPoint(x: CGFloat(i)*landWidth, y: 0)
            land.zPosition = Layer.land
            
            land.physicsBody = SKPhysicsBody(rectangleOf: land.size,center: CGPoint(x: landWidth/2, y: land.size.height/2))
            land.physicsBody?.categoryBitMask = PhysicsCategory.land
            land.physicsBody?.affectedByGravity = false // 중력에 의해 떨어지지 않게 하기 위해
            land.physicsBody?.isDynamic = false // 부딪혀도 움직이지 않게
            
            addChild(land)
            
            let moveLeft = SKAction.moveBy(x: -landWidth, y: 0, duration: 20)
            let moveReset = SKAction.moveBy(x: landWidth, y: 0, duration: 0)
            let moveSequence = SKAction.sequence([moveLeft,moveReset])
            
            land.run(SKAction.repeatForever(moveSequence))
            
            
        }
        
        for i in 0...skyRepeatNum {
            let sky = SKSpriteNode(texture: skyTexture)
            sky.anchorPoint = .zero
            // 앵커포인트 : 어디를 기준으로 붙히냐
            // 0.5, 0.5 : 스프라이트의 중심을 기준으로
            // 0,0: 좌하단 기준
            // 1,1: 우상단 기준
            
            sky.position = CGPoint(x: CGFloat(i)*skyWidth, y: landTexture.size().height)
            sky.zPosition = Layer.sky
            addChild(sky)
            
            let moveLeft = SKAction.moveBy(x: -skyWidth, y: 0, duration: 40)
            let moveReset = SKAction.moveBy(x: skyWidth, y: 0, duration: 0)
            let moveSequence = SKAction.sequence([moveLeft,moveReset])
            
            sky.run(SKAction.repeatForever(moveSequence))
            
            
        }
        
        for i in 0...ceilingRepeatNum {
            let ceiling = SKSpriteNode(texture: ceilngTexture)
            ceiling.anchorPoint = .zero
            // 앵커포인트 : 어디를 기준으로 붙히냐
            // 0.5, 0.5 : 스프라이트의 중심을 기준으로
            // 0,0: 좌하단 기준
            // 1,1: 우상단 기준
            
            ceiling.position = CGPoint(x: CGFloat(i)*ceilingWidth, y: self.size.height - ceiling.size.height/2 )
            ceiling.zPosition = Layer.ceiling
            
            ceiling.physicsBody = SKPhysicsBody(rectangleOf: ceiling.size,center: CGPoint(x: ceilingWidth/2, y: ceiling.size.height/2))
            ceiling.physicsBody?.categoryBitMask = PhysicsCategory.ceiling
            ceiling.physicsBody?.affectedByGravity = false // 중력에 의해 떨어지지 않게 하기 위해
            ceiling.physicsBody?.isDynamic = false
            
            addChild(ceiling)
            
            let moveLeft = SKAction.moveBy(x: -ceilingWidth, y: 0, duration: 3)
            let moveReset = SKAction.moveBy(x: ceilingWidth, y: 0, duration: 0)
            let moveSequence = SKAction.sequence([moveLeft,moveReset])
            
            ceiling.run(SKAction.repeatForever(moveSequence))
            
            
        }
        
    
        
        
    }
    
    func setUpPipe(pipeDistance:CGFloat) {
        let width = self.size.width
        let height = self.size.height
        
        let envAtlas = SKTextureAtlas(named: "Environment")
        let pipeTexture = envAtlas.textureNamed("pipe")
        
        let pipeDown = SKSpriteNode(texture: pipeTexture)
    
        pipeDown.zPosition = Layer.pipe
        pipeDown.physicsBody = SKPhysicsBody(rectangleOf: pipeTexture.size())
        pipeDown.physicsBody?.categoryBitMask = PhysicsCategory.pipe
        pipeDown.physicsBody?.isDynamic = false
        
        
        let pipeUp = SKSpriteNode(texture: pipeTexture)
        
        pipeUp.zPosition = Layer.pipe
        pipeUp.xScale = -1 // x방향으로 180도 회전 (좌우 반전)
        pipeUp.zRotation = .pi // 상하 반전
        pipeUp.physicsBody = SKPhysicsBody(rectangleOf: pipeTexture.size())
        pipeUp.physicsBody?.categoryBitMask = PhysicsCategory.pipe
        pipeUp.physicsBody?.isDynamic = false
       
        let pipeCollision = SKSpriteNode(color: .red, size: CGSize(width: 1, height: self.size.height))
        
        pipeCollision.zPosition = Layer.pipe
        pipeCollision.physicsBody = SKPhysicsBody(rectangleOf: pipeCollision.size)
        pipeCollision.physicsBody?.categoryBitMask = PhysicsCategory.score
        pipeCollision.physicsBody?.isDynamic = false
        pipeCollision.name = "pipeCollision"
        
        
        self.addChild(pipeDown)
        self.addChild(pipeUp)
        self.addChild(pipeCollision)
        
        //스프라이트 배치
        
        let max = self.size.height * 0.3
        let xPos = self.size.width + pipeUp.size.width // 화면 너비 + 파이프 너비 = 화면 바깥
        let yPos = CGFloat(arc4random_uniform(UInt32(max))) + envAtlas.textureNamed("land").size().height
        // 화면 높이의 30% + 땅의 높이 만큼 올림
        
        let endPos = self.size.width + (pipeDown.size.width*2)
        
        pipeDown.position  = CGPoint(x: xPos, y: yPos)
        pipeUp.position = CGPoint(x: xPos, y: pipeDown.position.y + pipeDistance + pipeUp.size.height )
        
        pipeCollision.position = CGPoint(x: xPos, y: self.size.height/2 )
        
        let moveAct = SKAction.moveBy(x: -endPos, y: 0, duration: 6)
        let moveSeq = SKAction.sequence([moveAct,SKAction.removeFromParent()]) // 최적화를 위해, 사라지면 삭제
        
        pipeDown.run(moveSeq)
        pipeUp.run(moveSeq)
        pipeCollision.run(moveSeq)
        
        
        
        
    }
    
    func createInfinitePipe(_ duration:TimeInterval)
    {
        let create = SKAction.run { [unowned self] in
            self.setUpPipe(pipeDistance: 100)
        }
        
        let wait = SKAction.wait(forDuration: duration)
        let actSeq = SKAction.sequence([create,wait])
        
        run(SKAction.repeatForever(actSeq) )
        
    }

}


extension GameScene: SKPhysicsContactDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0) // 속도 리셋
        self.bird.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 7))
        
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        var  collideBody = SKPhysicsBody()
        
        
        //비트마스크 큰게 플레이어
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            collideBody = contact.bodyB
            
        } else {
            
            collideBody = contact.bodyA
        }
        
        
        let collideType = collideBody.categoryBitMask
        
        
        switch collideType {
            
        case PhysicsCategory.land:
            print("land")
        case PhysicsCategory.ceiling:
            print("cel")
        case PhysicsCategory.pipe:
            print("pipe")
        case PhysicsCategory.score:
            print("score")
            score += 1
            
        default:
            break
            
            
        }
        
        
    }
}
