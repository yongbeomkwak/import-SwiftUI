import SwiftUI

struct TestView: View {
    
    let backgroundColor: Color
    let title: String
    
    enum Fruit {
        case apple
        case orange
        case grape
    }
    
    init(fruit: Fruit) {
        if fruit == .apple {
            self.title = "Apple"
            self.backgroundColor = .red
        } else if fruit == .orange {
            self.title = "Orange"
            self.backgroundColor = .orange
        } else {
            self.title = "Grape"
            self.backgroundColor = .purple
        }
    }
    
    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        .frame(width: 150, height: 150)
        .background(backgroundColor)
        .cornerRadius(30)
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TestView(fruit: .grape)
            TestView(fruit: .apple)
        }
    }
}
