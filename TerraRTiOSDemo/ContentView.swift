//
//  ContentView.swift
//  TerraRTiOSLocal
//
//  Created by Elliott Yu on 07/06/2022.
//

import SwiftUI
import CoreBluetooth
import TerraRTiOS

struct Globals {
    static var shared = Globals()
    var shownDevices: [Device] = []
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
    
    let terraRT = TerraRT(devId: DEVID, xAPIKey: XAPIKEY, userId: USERID)
    init(){
        terraRT.initConnection(type: .BLE)
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont.systemFont(ofSize: 24)]
    }
    
    @State private var showingWidget = false
    @State private var bleSwitch = false
    @State private var sensorSwitch = false

    var body: some View {
        NavigationView{
            VStack{
                connection().padding([.leading, .trailing, .top, .bottom])
                    .overlay(
                        RoundedRectangle(cornerRadius: Globals.shared.cornerradius)
                            .stroke(Color.border, lineWidth: 1)
                            .padding([.leading, .trailing], 5)
                        )
                appleConnection().padding([.leading, .trailing, .top, .bottom])
                    .overlay(
                        RoundedRectangle(cornerRadius: Globals.shared.cornerradius)
                            .stroke(Color.border, lineWidth: 1)
                            .padding([.leading, .trailing], 5)
                        )
                Spacer()
            }
            .navigationTitle(Text("Terra RealTime iOS")).padding(.top, 40)
        }
    }
    
    private func appleConnection() -> some View {
        HStack{
            Button(action: {
                terraRT.initConnection(type: .APPLE)
            }, label: {
                Text("Sensors")
                .fontWeight(.bold)
                .font(.system(size: 14))
                .foregroundColor(.inverse)
                .padding([.top, .bottom], Globals.shared.smallpadding)
                .padding([.leading, .trailing])
                .background(
                    Capsule()
                        .foregroundColor(.button)
                )
            })
            Toggle(isOn: $sensorSwitch, label: {
                Text("Real Time").fontWeight(.bold)
                    .font(.system(size: 14))
                    .foregroundColor(.inverse)
                    .padding([.top, .bottom], Globals.shared.smallpadding)
                    .padding([.leading, .trailing])
            }).onChange(of: sensorSwitch){sensorSwitch in
                if (sensorSwitch){
                    terraRT.startRealtime(type: .APPLE, dataType: Set([.GYROSCOPE, .ACCELERATION]))
                }
                else {
                    terraRT.stopRealtime(type: .APPLE)
                }
            }
        }
    }
    
    private func connection() -> some View{
        HStack{
            Button(action: {
                showingWidget.toggle()
            }, label: {
                    Text("BLE")
                    .fontWeight(.bold)
                    .font(.system(size: 14))
                    .foregroundColor(.inverse)
                    .padding([.top, .bottom], Globals.shared.smallpadding)
                    .padding([.leading, .trailing])
                    .background(
                        Capsule()
                            .foregroundColor(.button)
                    )
            })
            .sheet(isPresented: $showingWidget){ terraRT.startBluetoothScan(type: .BLE, callback: {_ in
                showingWidget.toggle()
            })}
            Toggle(isOn: $bleSwitch, label: {
                Text("Real Time").fontWeight(.bold)
                    .font(.system(size: 14))
                    .foregroundColor(.inverse)
                    .padding([.top, .bottom], Globals.shared.smallpadding)
                    .padding([.trailing])
            }).onChange(of: bleSwitch){bleSwitch in
                if (bleSwitch){
                    terraRT.startRealtime(type: .BLE, dataType: Set([.STEPS, .HEART_RATE]))
                }
                else {
                    terraRT.stopRealtime(type: .BLE)
                }
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
