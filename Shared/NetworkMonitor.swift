//
//  NetworkMonitor.swift
//  MonitorRed
//
//  Created by Eduardo Herrera Barros on 21-04-22.
//

import Foundation
import Network
import AppKit

final class NetworkMonitor : ObservableObject {
    let monitor = NWPathMonitor()
    let cola = DispatchQueue(label: "Monitor")
    
    @Published var statusRedBien = false
    @Published var isUP = false
    
    init() {
        monitor.pathUpdateHandler = {path in
            DispatchQueue.main.async {
                self.statusRedBien = path.status == .satisfied ? true : false
            }
        }
        monitor.start(queue: cola)
    }
    
 

}
