import SwiftUI

struct ContentView: View {
    @State private var numberOfCopiesSoldString: String = ""
    @State private var pricePerCopyString: String = ""
    @State private var selectedMarketCommissionPercentage: Int = 30
    @State private var selectedStateCommissionPercentage: Int = 30
    
    private let marketCommissionPercentages = [10, 15, 20, 25, 30]
    private let stateCommissionPercentages = [10, 15, 20, 25, 30]
    private let usdToTryRate: Decimal = 32.00
    
    var calculateProfit: Decimal {
        guard let numberOfCopiesSold = Int(numberOfCopiesSoldString),
              let pricePerCopy = Decimal(string: pricePerCopyString) else {
            return 0
        }
        
        let totalRevenueUSD = Decimal(numberOfCopiesSold) * pricePerCopy
        let marketCommission = totalRevenueUSD * Decimal(selectedMarketCommissionPercentage) / 100
        let stateCommission = totalRevenueUSD * Decimal(selectedStateCommissionPercentage) / 100
        let netRevenueUSD = totalRevenueUSD - (marketCommission + stateCommission)
        let netRevenueTRY = netRevenueUSD * usdToTryRate
        
        return netRevenueTRY
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Number of Copies Sold")) {
                    TextField("Enter Count", text: $numberOfCopiesSoldString)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Price per Copy (USD)")) {
                    TextField("Price", text: $pricePerCopyString)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Market Commission Percentage")) {
                    Picker("Select Commission Percentage", selection: $selectedMarketCommissionPercentage) {
                        ForEach(marketCommissionPercentages, id: \.self) {
                            Text("\($0)%")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section(header: Text("State Commission Percentage")) {
                    Picker("Select Commission Percentage", selection: $selectedStateCommissionPercentage) {
                        ForEach(stateCommissionPercentages, id: \.self) {
                            Text("\($0)%")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section {
                    VStack(alignment: .leading) {
                        Text(calculateProfit, format: .currency(code: "TRY")).font(.title)
                        Text("Profit").font(.subheadline)
                    }
                }
            }
            .navigationTitle("App Profit Calculator")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
