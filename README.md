# QRBillKit for iOS

[QRBillKit](https://github.com/iPhonso/QRBillKit) is a Swift package for working with **[Swiss QR-bill](https://www.six-group.com/en/products-services/banking-services/billing-and-payments/qr-bill.html)** (QR-facture) payment slips.
It enables apps to generate, parse, and validate QR-bills according to Swiss payment standards.

Features:
- Supports **all** versions of QR-bills up to version 2.3 (valid from 21 November 2025)
- Super-fast QR-bill scanner, including support for 
	- QR-bills from Camera, including flash control
	- QR-bills from Files
	- QR-bills from Photos
	- QR-bills from the clipboard
- Generate Swiss QR-bills
- Display scannable QR-bill QR codes
- Parse and validate QR-bill data
- Access all QR-bill properties in well-structured Swift `structs`
- Validate and format IBAN numbers
- Built for iOS 17+

## Installation

### Swift Package Manager

Add QRBillKit to your project using Xcode:
1. Select your project in the Project navigator.
2. Choose "Package Dependencies".
3. Click the "+" button and enter the URL of this repository:

https://github.com/iPhonso/QRBillKit.git

4. Choose the version and add the package.

Alternatively, add this line to your `Package.swift` dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/your-org/QRBillKit.git", from: "1.0.0")
]
```

## Usage

### Parsing a QR-bill String

```swift
let qrBillString = "..." // Your QR-bill data here
let bill = try QRBill(qrBillString)
print(bill.account)
print(bill.creditor.name)
```

### Validating an IBAN

```swift
let iban: IBAN = "CH93 0076 2011 6238 5295 7"
print("Valid IBAN?", iban.isValid)
```
### Formatting an IBAN

```swift
let iban: IBAN = "CH9300 762011623852957"
print(iban.formatted()) // CH93 0076 2011 6238 5295 7
```

```swift
// SwiftUI
Text(iban, format: .iban)
```
### Generating and Displaying a Scannable QR-Bill in SwiftUI

```swift
let bill = QRBill(
    account: "CH93 0076 2011 6238 5295 7",
    amount: 199.95,
    currency: "CHF",
    creditor: "Example AG",
    reference: "210000000003139471430009017"
)
Image(qrCode: bill.qrCode) 
```

See the documentation, code samples and tests in the repository for more advanced usage and integration examples.
