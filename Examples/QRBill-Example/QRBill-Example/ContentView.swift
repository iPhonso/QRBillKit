//
//  ContentView.swift
//  QRBill-Example
//
//  Created by Vikram Kriplaney on 28.05.2025.
//

import AudioToolbox
import QRBillKit
import SwiftUI

struct ContentView: View {
    @State private var qrBill: QRBill?
    @State private var isPresentingScanner = false

    var body: some View {
        List {
            Section {
                Button("Scan a QR-Bill") {
                    qrBill = nil
                    DispatchQueue.main.async { isPresentingScanner = true }
                }
                Button("Generate a QR-Bill") {
                    buyLicense()
                }
            }

            if let qrBill {
                if let amount = qrBill.amount {
                    LabeledContent("Amount", value: amount, format: .currency(code: qrBill.currency))
                }
                Section("Creditor") {
                    LabeledContent("Account", value: qrBill.account.formatted())
                    addressSection(address: qrBill.creditor)
                }
                if let ultimateDebtor = qrBill.ultimateDebtor {
                    Section("Debtor") {
                        addressSection(address: ultimateDebtor)
                    }
                }
                Section("Reference") {
                    qrBill.reference.map { LabeledContent(qrBill.referenceType.rawValue, value: $0) }
                    qrBill.unstructuredMessage.map { LabeledContent("Message", value: $0) }
                    qrBill.billingInformation.map { LabeledContent("Billing Information", value: $0) }
                }
                Section("Generated QR-Bill") {
                    QRCodeView(for: qrBill.qrCode)
                }
            }
        }
        .sheet(isPresented: $isPresentingScanner) {
            QRBillScanner(qrBill: $qrBill)
                .ignoresSafeArea()
                .presentationDetents([.medium, .large])
        }
        .onChange(of: qrBill) { _, _ in
            isPresentingScanner = false
        }
        .sensoryFeedback(.success, trigger: qrBill)
        .playSound(trigger: qrBill)
    }

    @ViewBuilder func addressSection(address: QRBill.Address) -> some View {
        LabeledContent("Name", value: address.name)
        if address.type == .combined {
            LabeledContent("Line 1", value: address.street)
            LabeledContent("Line 2", value: address.buildingNumber)
        } else {
            LabeledContent("Street", value: address.street)
            LabeledContent("Number", value: address.buildingNumber)
            LabeledContent("City", value: address.city)
            LabeledContent("Postal Code", value: address.postalCode)
        }
        LabeledContent("Country", value: address.country)
    }

    func buyLicense() {
        let address = QRBill.Address(
            type: .structured, name: "iPhonso GmbH", street: "Stettbachstrasse", buildingNumber: "46",
            postalCode: "8051", city: "Zürich", country: "CH"
        )
        qrBill = QRBill(account: "CH6500700110003215379", creditor: address, amount: 100)
        qrBill?.unstructuredMessage = "1-year license for QRBillKit"
    }
}

#Preview {
    ContentView()
}

extension View {
    // https://github.com/TUNER88/iOSSystemSoundsLibrary
    func playSound(id: SystemSoundID = 1108, trigger: (some Equatable)?) -> some View {
        onChange(of: trigger) { _, newValue in
            if newValue != nil {
                AudioServicesPlaySystemSound(id)
            }
        }
    }
}
