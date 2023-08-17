//
//  ContentView.swift
//  TerraRTiOSWatchDemo Watch App
//
//  Created by Bryan Tan on 14/08/2023.
//

import SwiftUI
import TerraRTiOS

struct Globals {
    static var shared = Globals()
//    var shownDevices: [Device] = []
    let cornerradius : CGFloat = 10
    let smallpadding: CGFloat = 12
}

extension Color {
    public static var border : Color {
        Color.init(.sRGB, red: 226/255, green: 239/255, blue: 254/255, opacity: 1)
    }
    
    public static var background : Color {
        Color.init(.sRGB, red: 255/255, green: 255/255, blue: 255/255, opacity: 1)
    }
    
    public static var button : Color {
        Color.init(.sRGB, red: 96/255, green: 165/255, blue: 250/255, opacity: 1)
    }
    
    public static var accent: Color{
        Color.init(.sRGB, red: 42/255, green: 100/255, blue: 246/255, opacity: 1)
    }
}


struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            watchConnection().padding([.leading, .trailing, .top, .bottom])
                .overlay(
                    RoundedRectangle(cornerRadius: Globals.shared.cornerradius)
                        .stroke(Color.border, lineWidth: 1)
                        .padding([.leading, .trailing], 5)
                    )
        }
        .padding()
    }
    
    private func watchConnection() -> some View{
        HStack{
            Button(action: {
                print("WatchOS selected!")
                let terra: Terra? = try? Terra()
                guard let terra else {
                    print("Error initialising Terra")
                    return
                }
            }, label: {
                Text("Apple Watch")
            })
            //            .sheet(isPresented: $showingWidget){ terraRT.startBluetoothScan(type: .BLE, callback: {success in
            //                showingWidget.toggle()
            //                print("Device Connection Callback: \(success)")
            //            })}
            //            Toggle(isOn: $bleSwitch, label: {
            //                Text("Real Time").fontWeight(.bold)
            //                    .font(.system(size: 14))
            //                    .foregroundColor(.inverse)
            //                    .padding([.top, .bottom], Globals.shared.smallpadding)
            //                    .padding([.trailing])
            //            }).onChange(of: bleSwitch){bleSwitch in
            //                let userId = terraRT.getUserid()
            //                print("UserId detected: \(userId ?? "None")")
            //                if (bleSwitch){
            //                    print("startRealtime - WatchOS")
            //                    terraRT.startRealtime(type: Connections.BLE, dataType: Set([.STEPS, .HEART_RATE, .CORE_TEMPERATURE]),
            //                        callback: { update in
            //                            print(update)
            //                            print("hello")
            //                        }
            //                    )
            //                }
            //                else {
            //                    terraRT.stopRealtime(type: .BLE)
            //                }
            //            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
