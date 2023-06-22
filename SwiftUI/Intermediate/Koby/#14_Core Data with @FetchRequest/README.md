# **#14 Core Data with @FetchRequest**
- 코어데이터는 아이폰에 저장돼있는 데이터베이스임. 데이터를 저장하고 
앱을 끄고 다시 열어도 데이터 보존됨. 

- 코어데이터는 app storage와 user defaults 와 같은 방식으로 작동하지만 더 복잡하고 큰 규모의 데이터베이스를 추가하는 데에 더 집중한다는 차이가 있다. 



- 새 프로젝트를 생성할 때 Using core data 에 체크하면 애플이 제공해주는 core data 템플릿이 있음. 
<img width="712" alt="스크린샷 2023-06-06 오후 8 37 34" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/87987002/55ac8199-2f94-4e55-b4c4-a321eb1fd733">

<br>
<br>


<br>
<br>









<br>
<br>
<br>


<br>
<br>

# **Core Data Stack**

![image](https://github.com/yongbeomkwak/SwiftUI-Study/assets/87987002/f0e7c0f8-35c5-4b82-b34e-9ed0268fef79)
## ⭐️ NSPersistentContainer
- Core Data Stack을 캡슐화한 컨테이너. 
- 즉, NSPersistentContainer 클래스가 NSManagedObjectModel, NSManagedObjectContext, NSPersistentStoreCoordinator를 프로퍼티로 가지고 있다. 
- 코어 데이터의 데이터베이스라고 볼 수 있다.
<br>
<br>

## ⭐️ NSManagedObjectContext
- 데이터베이스에 있는 객체를 보고 접근하게 해주는 window
- Core Data Stack의 핵심으로 Core Data와 상호작용할 때 사용한다. 
<br>
<br>

## NSManagedObjectModel
- Entities라고 불리는 데이터 모델 객체와 다른 Entity들과의 관계를 정의한다.
<br>
<br>

## NSPersistentStoreCoordinator
- managed obejct model과 managed object context에 대한 참조를 유지한다.

<br>
<br>
<br>
<br>

# ✅ **Core Data 만드는 방법**
## **1️. Data Model** 만들기

<img width="1016" alt="스크린샷 2023-06-22 오전 8 54 05" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/87987002/372a14b9-cd92-42e1-9372-b80a32bf0c3b">

<img width="1220" alt="스크린샷 2023-06-07 오전 2 27 55" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/87987002/4745d411-45ad-453f-ac3e-224ccd352823">

- Core data를 만드는 데 제일 먼저 할 일은 객체들의 구조를 정의하기 위해 data model 파일(xcdatamodeld 파일)을 만드는 것임. <br>
- Entity는 "저장되고, 관리되어야 하는 데이터의 집합"을 의미한다. 코어 데이터는 모든 데이터를 Entity 단위로 처리한다. 

- 코어 데이터에는 이미지나 컬러를 직접적으로 넣을 수는 없고 Binary Data 로 인코딩해서 넣어야 함. 
- Entity라는 class 안에 Attributes, Relationships, Fetched Properties 라는 프로퍼티들이 있는 형태임. 

<br>
<br>

## **2. Core Data Stack** 세팅하기
**NSPersistnetntContainer를 가져와서 container라는 변수를 생성하고 거기에다가 데이터를 로드하자!**
```swift
//  Persistence.swift
//
//

import CoreData

struct PersistenceController {             
    static let shared = PersistenceController()     //싱글톤 - 싱글 인스턴스

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CoreDate")     //2️⃣ Coredata.xcdatamodeld 파일을 참조한다. 즉, 코어데이터를 참조한다 //Container: 모든 데이터를 불러오는 데이터 베이스라고 보면 됨. //init으로 값을 초기화해준다.
                if inMemory {
                    container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
                }
    }
    
}
```
정리하면 PersistenceController는 container를 만들고 데이터를 container로 불러온다. 


<br>
<br>

## 3. NSPersistentContainer의 데이터 베이스에 접근하기
```swift
//  Persistence.swift
//
//

import CoreData

struct PersistenceController {             
    static let shared = PersistenceController()    

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CoreDate")   
                if inMemory {
                    container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
                }

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in        //3️⃣ Container에서 데이터를 불러오는 함수! 그래서 비동기다
            if let error = error as NSError? {         //로드가 성공적이면 storeDescription, NSError라는 종류의 에러가 나면 에러 발생 함수 실행.
                fatalError("Unresolved error \(error), \(error.userInfo)")  //fatalError - persistence container를 잘못 설정했을 때 자동으로 크래시나게 하는 에러
            }
        })
    }
    
}
```
<br>
<br>

## 4. 다른 모든 뷰에 Environment를 통해 viewContext를 전해준다. 
### App.swift
```swift
//  CoreDateApp.swift
//
//

import SwiftUI

@main
struct CoreDateApp: App {
    let persistenceController = PersistenceController.shared  //실제 앱에서 사용할 싱글톤  -  하나의 인스턴스임.

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext) //4️⃣
        }
    }
}
```


<br>
<br>

<img width="942" alt="스크린샷 2023-06-13 오후 8 51 04" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/87987002/119c3f83-7126-4034-9cd9-c20151d70c46">

.environment의 선언을 보면 environment(_ keyPath:, _ value:) 이런 구조로 이루어져 있음. <br>

- Environtment의 EnvironmentValues는 여러가지가 있지만 그 중에서도 managedObjectContext를 사용하여 NSPersistentContainer의 ViewContext값을 할당해준다. <br>
- ContentView, ContentView의 하위뷰는 이 persistenceController 안의 container 안의 viewContext라는 데이터에 접근할 수 있음

- Entity를 생성하고 업데이트, 삭제할 때 우리는 이 작업을 모두 managed object context를 통해서 수행하기 때문에 keyPath에 managedObjectContext를 할당. 

- **Key Path Expression** - environment(_ keyPath:, _ value:) 해당 keyPath 에 해당 value를 set 하라는 의미. 
- ```\.```는 특정 프로퍼티에 대한 경로를 표현해주는 것
<br>
<br>

## 5. ContenView에서 **@Environmen**를 통해 **managedObjectContet**에 접근




```swift
//  ContentView.swift
//
//

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext    //5️⃣ managedObjectContext에 접근 가능!

    ...
}
```
하위 뷰에서 이렇게 @Environment를 통해 내가 주입한 값을 꺼내쓸 수 있다. <br>
@Environment 라는 프로퍼티 래퍼는 읽기 전용으로 특정 뷰에서 EnvironmentValues의 특정 요소를 읽어와 뷰 구성에 반영한다.<br>
상위 계층의 뷰가 가진 환경 요소를 그대로 상속받는다.

<br>
<br>

## 6. @FetchRequst를 통해 데이터(entity)를 가져온다!

```swift
//  ContentView.swift
//
//

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(  //6️⃣ FruitEntity를 가져온다. FetchRequest는 데이터를 뷰에 빠르고 쉽게 가져오게 해줌.
        entity: FruitEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \FruitEntity.name, ascending: true)]) //백슬래시 무슨뜻?? 쨌든 이렇게 하면 이름순으로 정렬된다.
    var fruits: FetchedResults<FruitEntity> //FetchedResults타입인데 bunch of FruitEntity이 될 거라는 뜻.
    
    ...
}
```
- 어떤 Entity를 fetch할지, 어떤 순서로 정렬할지 등의 정보를 프로퍼티 래퍼 내부에서 정해준다.
- @FetchRequest를 쓰면 해당 데이터에 변경이 생길 때마다 계속해서 fetch해오기 때문에  데이터를 뷰에 빠르고 쉽게 가져올 수 있다.
- generic을 쓰는 이유는 애플에서 FetchedResult를 제공할 때 어떤 데이터든지 사용할 수 있게 해주려고

- FetchRequest할 수 있는 이유는 App.swift 파일에서 Environtment에 넣은  Core Data ViewContext를 가져온 다음, ContentView의 @Environment에서 ViewContext를 가져오고 있기 때문이다. 

## sortDescriptors 적용 before & after

<img width="1303" alt="스크린샷 2023-06-22 오전 11 04 22" src="https://github.com/yongbeomkwak/SwiftUI-Study/assets/87987002/98501564-97e9-46de-b026-05bb73d1a274">

이름순으로 정렬된다

<br>
<br>

## 7. Entity의 모든 변경사항을 디스크에 저장하기 위해 try ViewContext.save() 실행
```swift
//  ContentView.swift
//
//

    var body: some View {
        NavigationView {
            VStack(spacing  :20) {
                List {
                    ForEach(fruits) { fruit in
                            Text(fruit.name ?? "defaults")  
                    }
                    .onDelete(perform: deleteItems)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Fruits")
            .navigationBarItems(
                trailing:
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                }
            )

            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newFruit = FruitEntity(context: viewContext)  
                                                                
            newFruit.name = "Orange"
            saveItems()
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            guard let index = offsets.first else {return}  
            let FruitEntity = fruits[index]
            viewContext.delete(FruitEntity)
            
            saveItems()
        }
    }
    
    private func saveItems() {
        do {
            try viewContext.save()  //7️⃣ FruitEntity에 생기는 모든 변경사항을 디스크에 쓰려면 컨텍스트를 저장해야 하므로 .save() 실행
        } catch {

            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

struct ContentView_Previews: PreviewProvider {      //persistence 파일의 preview에서 온 거임
    
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
```
이제 코어데이터 완성! <br>
코어데이터에 저장되기 때문에 실제 기기나 시뮬레이터에서 아이템들을 새로 생성하고 지우면 영원히 저장된다. <br>
앱을 재실행해도 코어데이터에 저장되기 때문에 한번 저장한 아이템은 사라지지 않음. <br>
아이템을 삭제하면 그상태 그대로 껏다 켜도 유지됨. <br>
<br>
<br>
<br>
<br>




> 참고 사이트 <br>
https://velog.io/@nala/iOS-SwiftUI%EC%97%90%EC%84%9C-CoreData-%EC%8D%A8%EB%B3%B4%EA%B8%B0 <br>
https://zeddios.tistory.com/987 <br>
https://velog.io/@byron1st/SwiftUI%EC%9D%98-Environment
