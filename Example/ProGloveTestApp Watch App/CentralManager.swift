//
//  CentralManager.swift
//  ProGloveTestApp Watch App
//
//  Created by Vlastimir Radojevic on 5/18/23.
//

import SwiftUI
import ConnectSDKWatch

class CentralManager: NSObject, PGCentralManagerDelegate, ObservableObject {
    
    @Published var connected = false
    @Published var scannedBarcodes = [String]()
    @Published var qrConnectionImage: Image?
    
    var connectedScanner: PGPeripheral?
    
    func centralManager(_ centralManager: PGCentralManager, didStartSearchingForIndicator indicator: String?) {
        print("Did start searching for \(indicator ?? "")")
    }

    func centralManager(_ centralManager: PGCentralManager, connectingToScanner scanner: PGPeripheral) {
        print("Connecting to scanner")
    }

    func centralManager(_ centralManager: PGCentralManager, scannerDidConnect scanner: PGPeripheral) {
        print("Did connect to scanner")
        connected = true
        qrConnectionImage = nil
        connectedScanner = scanner
    }

    func centralManager(_ centralManager: PGCentralManager, scannerDidBecomeReady scanner: PGPeripheral) {
        print("Scanner did become ready")
        scanner.delegate = self
    }

    func centralManager(_ centralManager: PGCentralManager, didFailToConnectToScanner scanner: PGPeripheral, error: Error?) {
        print("Did fail to connect to scanner")
    }

    func centralManager(_ centralManager: PGCentralManager, didDisconnectFromScanner scanner: PGPeripheral, error: Error?) {
        print("Did disconnect from scanner")
        connected = false
        connectedScanner = nil
        scannedBarcodes = []
    }

    func centralManager(_ centralManager: PGCentralManager, didFailToInitiateConnection error: Error?) {
        print("Did fail to initiate connection")
    }

    func centralManager(_ centralManager: PGCentralManager, didLostConnectionAndReconnectingToScanner scanner: PGPeripheral) {
        print("Did lost connection and reconnecting to scanner")
    }

    func managerDidUpdateState(_ manager: PGManager) {
        print("Manager did update state: \(manager.state)")
    }

    var pgCentralManager: PGCentralManager?

    override init() {
        super.init()
        PGLogging.delegate = self
        self.pgCentralManager = PGCentralManager(delegate: self, enableRestoration: true)
        PGLogging.delegate = self
    }
    
    func connectToScanner() {
        qrConnectionImage = Image("227DF")
        pgCentralManager?.connectToScanner(withIndicator: "227DF")
    }
    
    func disconnectScanner() {
        if let scanner = connectedScanner {
            pgCentralManager?.cancelScannerConnection(scanner)
        }
    }
}

extension CentralManager: PGLoggingDelegate {
    func pgLog(_ asynchronous: Bool, flag: ConnectSDKWatch.PGLogFlag, context: Int, file: String, function: String, line: UInt, tag: Any?, message: String) {
        print("[ConnectSDK] \(message)")
    }
}

extension CentralManager: PGPeripheralDelegate {
    func peripheral(_ peripheral: PGPeripheral, didScanBarcodeWith result: PGScannedBarcodeResult) {
        print("Barcode scan result received with value: \(result.barcodeContent) and symbology: \(result.barcodeSymbology ?? "")")
        scannedBarcodes.append(result.barcodeContent)
    }
    
    func peripheralDidUpdateState(_ peripheral: PGPeripheral) {
        print("Peripheral state updated: \(peripheral.state)")
    }
}
