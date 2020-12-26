# OnLoad
A SwiftUI equivalent of viewDidLoad().

## Usage
```swift
import SwiftUI
import OnLoad

struct ContentView: View {
    var body: some View {
        TabView {
            ForEach(1..<6) { number in
                Text("Tab \(number)")
                    .onLoad {
                        print("onLoad \(number)")
                    }
                    .onAppear {
                        print("onAppear \(number)")
                    }
                    .tabItem {
                        Image(systemName: "\(number).square.fill")
                        Text("Tab \(number)")
                    }
            }
        }
    }
}
```
