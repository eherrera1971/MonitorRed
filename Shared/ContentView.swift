//
//  ContentView.swift
//  Shared
//
//  Created by Eduardo Herrera Barros on 21-04-22.
//

import SwiftUI

struct ContentView: View {
//    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @ObservedObject var monitor = NetworkMonitor()
    @ObservedObject var red = EstadoRed()
    var body: some View {
        VStack{
            Image(systemName: monitor.statusRedBien ? "wifi":"wifi.slash")
                .font(.system(size: 64))
                .foregroundColor(monitor.statusRedBien ? .green : .red)
            Text(red.estadoRed)
                .foregroundColor(red.isUp ? .green : .blue)
                }
        .frame(width: 200, height: 100)
        .onTapGesture {
            red.check()
        }
            }
        }



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
