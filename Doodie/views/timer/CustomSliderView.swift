import SwiftUI

struct CustomSliderView: View {
    @Binding var value: Double
    var range: ClosedRange<Double>
    var step: Double = 5
    
    var body: some View {
        GeometryReader { geo in
            // 전체 바
            ZStack(alignment: .leading) {
                // 배경 바 (회색)
                Capsule()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 20)
                
                // 진행 바 (검정)
                Capsule()
                    .fill(.black)
                    .frame(width: progressWidth(geo.size.width), height: 20)
                
                // Thumb (드래그 버튼)
                Circle()
                    .fill(Color.white)
                    .overlay(
                        Circle().stroke(Color.black, lineWidth: 2)
                    )
                    .frame(width: 26, height: 26)
                    .offset(x: thumbOffset(geo.size.width) - 13) // thumb 중앙 정렬
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                let newValue = valueFrom(offset: gesture.location.x, width: geo.size.width)
                                let steppedValue = (newValue / step).rounded() * step
                                value = min(max(range.lowerBound, steppedValue), range.upperBound)
                            }
                    )
            }
        }
        .frame(height: 30)
    }
    
    // Helper functions
    private func progressWidth(_ totalWidth: CGFloat) -> CGFloat {
        let ratio = (value - range.lowerBound) / (range.upperBound - range.lowerBound)
        return ratio * totalWidth
    }
    
    private func thumbOffset(_ totalWidth: CGFloat) -> CGFloat {
        let ratio = (value - range.lowerBound) / (range.upperBound - range.lowerBound)
        return ratio * totalWidth
    }
    
    private func valueFrom(offset: CGFloat, width: CGFloat) -> Double {
        let ratio = max(0, min(1, offset / width))
        return range.lowerBound + (range.upperBound - range.lowerBound) * ratio
    }
}
