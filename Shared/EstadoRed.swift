//
//  EstadoRed.swift
//  MonitorRed
//
//  Created by Eduardo Herrera Barros on 22-04-22.
//

import SwiftUI

class TestRef {
    var a : Int = 42

    func change() { a = 1975 }
}


class EstadoRed: ObservableObject {
    
    @Published var isUp = false
    @Published var estadoRed = "Estado Red"
    
    init() {
        (self.isUp, self.estadoRed) = checkIsConnectedToNetwork()
    }
    
    func check(){
        print("Me hicieron click")
        var dato : Bool = false
        var estado : String = "Sin Info"
                (dato,estado) = checkIsConnectedToNetwork()
                    // now update UI on main thread
        DispatchQueue.main.async {
                    self.isUp = dato
                    self.estadoRed = estado
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    print("-----> Esperar")
            self.check()
                }
     }
        
    
}


func checkIsConnectedToNetwork() -> (Bool , String) {
    var isUp : Bool = false
    var done : Bool = false
    var estado : String = "Sin Info"
    let hostUrl: String = "https://yahoo.com"
   if let url = URL(string: hostUrl) {
      var request = URLRequest(url: url)
      request.httpMethod = "HEAD"
      URLSession(configuration: .ephemeral)
      .dataTask(with: request) { (_, response, error) -> Void in
         guard error == nil else {
//            print("Error:", error ?? "")
             isUp = false
             done = true
             estado = error!.localizedDescription
            return
         }
         guard (response as? HTTPURLResponse)?
         .statusCode == 200 else {
            print("The host is down")
             isUp = false
             done = true
             estado = "Sitio Google.com abajo"
            return
         }
          isUp = true
          done = true
          estado = "Red Ok"
          return
      }
      .resume()
       repeat {
           RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))
       } while !done
   }
        return (isUp, estado)
    }
