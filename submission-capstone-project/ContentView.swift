import SwiftUI

struct ContentView: View {
  let presenter: TabMenuPresenter = Injection.init().providerTabMenuPresenter()
    var body: some View {
      TabMenuView(presenter: presenter).onAppear {
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
