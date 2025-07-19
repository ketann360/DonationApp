//
//  AmountSelectionView.swift
//  DonationApp
//
//  Created by ketan patel on 5/31/25.
//
import SwiftUI

struct AmountSelectionView: View {
    // MARK: - Properties
    let donationAmounts = [1, 5, 11, 21, 51] // Total 5 amounts
    var onSelectAmount: (Int) -> Void // Callback for when an amount is selected

    var body: some View {
        // GeometryReader provides the size of the screen, essential for percentage-based layouts.
        GeometryReader { geometry in
            ZStack {
                Color.black.ignoresSafeArea() // <- This ensures full black background behind everything
                
                // Outer VStack to arrange banner and main content vertically.
                VStack(spacing: 0) { // No spacing between banner and the content below it.
                    // MARK: - Banner Header Area (15% of screen height)
                    // Wrapped Image in a ZStack to explicitly control its full-width behavior and safe area ignoring.
                    ZStack {
                        Color.black
                            .ignoresSafeArea(.all, edges: .bottom) // Extends white background to bottom safe area.
                        
                        // The image itself, filling its ZStack container
                        Text("I.S.S.O.  SHREE  SWAMINARAYAN  HINDU  TEMPLE  HOUSTON  TEXAS  (USA)")
                            .font(.system(size: 30, weight: .bold)) // Increased font size for "Confirm Donation"
                            .font(.largeTitle)
                            .foregroundColor(.brown)
                    }
                    .frame(maxWidth: .infinity) // Ensure the ZStack (banner container) expands to full width.
                    .frame(height: geometry.size.height * 0.15) // Set the ZStack's height to 15% of screen height.
                    .ignoresSafeArea(.all, edges: .top) // Make the ZStack itself ignore the top safe area.
                    
                    Rectangle()
                        .fill(Color.brown)
                        .frame(height: 2)
                        .padding(.horizontal, 20)
                    Rectangle()
                        .fill(Color.brown)
                        .frame(height: 2)
                        .padding(.horizontal, 20)
                    // MARK: - Main Content Area (Remaining 85% of screen height)
                    // ZStack to provide a unified white background for the entire 85% area.
                    ZStack {
                        Color.black // The background color for this section.
                            .ignoresSafeArea(.all, edges: .bottom) // Extends white background to bottom safe area.
                        
                        // HStack to create the side-by-side layout (30% left, 70% right).
                        HStack(spacing: 0) { // No spacing between the left and right columns.
                            // MARK: - Left Side (30% width) for "swamibapa" image
                            VStack {
                                Spacer() // Pushes the image vertically to the center within this column.
                                Image("swamibapa") // Your existing "swamibapa" image.
                                    .resizable()
                                    .aspectRatio(contentMode: .fit) // Fits the image within its frame.
                                    .frame(width: geometry.size.width * 0.55) // Image width, relative to total screen width.
                                Spacer()
                            }
                            .frame(width: geometry.size.width * 0.40) // Sets width to 30% of total screen width.
                            // Removed explicit background here; the parent ZStack provides the white background.
                            .padding() // Adds padding around the "swamibapa" image within its 30% column.
                            
                            // MARK: - Right Side (70% width) for Donation Amount Selection
                            VStack(spacing: 40) { // Spacing between the elements in this vertical stack.
                                Spacer() // Pushes content towards the center/top of this section.
                                
                                Text("Select Donation Amount")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.brown) // Changed for visibility on white background.
                                    .shadow(radius: 5)
                                    .multilineTextAlignment(.center)
                                    .padding() // Padding around the text.
                                
                                // Custom button layout for 3 on first row, 2 on second, centered.
                                VStack(spacing: 20) { // Spacing between rows
                                    HStack(spacing: 20) { // Spacing between buttons in a row
                                        // First 3 buttons
                                        ForEach(donationAmounts[0..<3], id: \.self) { amount in
                                            AmountButton(amount: amount, onSelectAmount: onSelectAmount)
                                        }
                                    }
                                    .frame(maxWidth: .infinity) // Make HStack take full width
                                    .padding(.horizontal) // Add horizontal padding for row centering if needed, though Spacer() handles it
                                    
                                    HStack(spacing: 20) { // Spacing between buttons in a row
                                        // Last 2 buttons
                                        ForEach(donationAmounts[3..<5], id: \.self) { amount in
                                            AmountButton(amount: amount, onSelectAmount: onSelectAmount)
                                        }
                                    }
                                    .frame(maxWidth: .infinity) // Make HStack take full width
                                    .padding(.horizontal)
                                }
                                .frame(maxWidth: 600) // Constrains the overall button area's maximum width
                                // The `VStack` containing the two `HStack`s will be centered by the parent `VStack`'s `Spacer`s.
                                
                                Spacer() // Pushes content towards the center/bottom of this section.
                                
                                Text("""
                            * This is a cashless donation kiosk. We do not provide receipts or send annual donation statements.If you would like a receipt, please make your donation directly at the office.Thank you for your generosity! 🎉
                            """)
                                .font(.system(size: 20, weight: .medium, design: .default)) // Larger, clearer font
                                .foregroundColor(.brown)
                                .multilineTextAlignment(.center) // Easier to scan in center
                                .padding(.horizontal, 18) // More side padding for better readability
                                .padding(.vertical, 10)   // Extra vertical spacing
                                //                                .background(Color.white.opacity(0.1)) // Optional: subtle contrast background
                                .cornerRadius(10)
                                //                            Text("* This is a cashless donation kiosk. We do not provide receipts or send annual donation statements. \nIf you would like a receipt, please make your donation directly at the office. \nThank you for your generosity! 🎉 ")
                                //                                .font(.footnote)
                                //                                .foregroundColor(.brown) // Changed for visibility on white background.
                                .padding() // Padding around the disclaimer text.
                            }
                            .frame(width: geometry.size.width * 0.59) // Sets width to 70% of total screen width.
                            .padding(.vertical) // Adds vertical padding to the content in this column.
                        }
                        .padding(.horizontal) // Applies horizontal padding to the entire 30/70 split content.
                    }
                    //                .frame(maxHeight: .infinity) // Ensures this ZStack takes up all remaining vertical space.
                }
                .ignoresSafeArea(.all)
                
            }
        }
    }
}

// MARK: - Reusable Button Component for consistency
struct AmountButton: View {
    let amount: Int
    var onSelectAmount: (Int) -> Void

    var body: some View {
        Button(action: {
            onSelectAmount(amount)
        }) {
            Text("$\(amount)")
                .frame(width: 185, height: 135) // Square dimensions
                .foregroundColor(.brown) // Text color brown
                .font(.largeTitle)
                .fontWeight(.bold)
                .cornerRadius(8) // Slightly rounded corners for the shape
                .overlay( // Adds a border on top of the background
                    RoundedRectangle(cornerRadius: 8) // Matching corner radius for the border
                        .stroke(Color.brown, lineWidth: 3) // Brown border with specific line width
                )
        }
    }
}

