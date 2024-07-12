import SwiftUI
import Network

public class NetworkMonitor : ObservableObject {
    @Published var isConnected = false
    private let workerQueue = DispatchQueue(label: "Monitor")
    private let networkMonitor = NWPathMonitor()
    
    public init (){
        networkMonitor.pathUpdateHandler = {path in
            self.isConnected = path.status == .satisfied
            Task {
                await MainActor.run{
                    self.objectWillChange.send()
                }
            }
        }
        networkMonitor.start(queue: workerQueue)
    }
}
