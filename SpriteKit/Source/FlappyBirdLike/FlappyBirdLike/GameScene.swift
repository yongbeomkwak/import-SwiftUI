//
//  GameScene.swift
//  FlappyBirdLike
//
//  Created by yongbeomkwak on 2023/03/31.
//

import SpriteKit

class GameScene: SKScene {
    
    
    override func didMove(to view: SKView) {
        //초기화 진행
        
        createBird()
        createEnvironment()
        setUpPipe()
        
        
    }
    
    func createBird() {
        let width = self.size.width
        let height = self.size.height
        
       
        
        let bird = SKSpriteNode(imageNamed: "bird1")
        bird.position = CGPoint(x: width/2, y: 350)
        bird.zPosition = 4
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
            land.zPosition = 3
            
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
            sky.zPosition = 1
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
            ceiling.zPosition = 3
            addChild(ceiling)
            
            let moveLeft = SKAction.moveBy(x: -ceilingWidth, y: 0, duration: 3)
            let moveReset = SKAction.moveBy(x: ceilingWidth, y: 0, duration: 0)
            let moveSequence = SKAction.sequence([moveLeft,moveReset])
            
            ceiling.run(SKAction.repeatForever(moveSequence))
            
            
        }
        
    
        
        
    }
    
    func setUpPipe() {
        let width = self.size.width
        let height = self.size.height
        
        let pipeUp = SKSpriteNode(imageNamed: "pipe")
        pipeUp.position = CGPoint(x: width/2, y: 0)
        pipeUp.zPosition = 2
        self.addChild(pipeUp)
        
        let pipeDown = SKSpriteNode(imageNamed: "pipe")
        pipeDown.position = CGPoint(x: width/2, y: height + 100 )
        pipeDown.zPosition = 2
        pipeDown.xScale = -1 // x방향으로 180도 회전 (좌우 반전)
        pipeDown.zRotation = .pi // 상하 반전
        
        self.addChild(pipeDown)
    }

}
