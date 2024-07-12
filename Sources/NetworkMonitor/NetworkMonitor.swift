import SwiftUI
import Network

public class NetworkMonitor : ObservableObject {
    @Published public var isConnected = false
    private let workerQueue = DispatchQueue(label: "Monitor")
    private let networkMonitor = NWPathMonitor()
    
    public init (){
        networkMonitor.pathUpdateHandler = {path in
            self.isConnected = path.status == .satisfied
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        networkMonitor.start(queue: workerQueue)
    }
}
