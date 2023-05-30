//
//  ContentView.swift
//  ProGloveTestApp Watch App
//
//  Created by Vlastimir Radojevic on 5/18/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var manager = CentralManager()
    
    var body: some View {
        VStack {
            if let image = manager.qrConnectionImage {
                image
                    .resizable()
                    .padding()
            } else {
                VStack {
                    Text("\(manager.connected ? "Scan something" : "Connect to scanner")")
                    ScrollView {
                        ForEach(manager.scannedBarcodes.reversed(), id: \.self) { barcode in
                            Text(barcode)
                        }
                    }
                    Spacer()
                    Button {
                        manager.connected ? manager.disconnectScanner() : manager.connectToScanner()
                    } label: {
                        Text("\(manager.connected ? "Disconnect" : "Connect")")
                    }
                }
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
