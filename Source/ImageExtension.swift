import SwiftUI
extension Image {
    func centerSquareCropped() -> some View {
        GeometryReader { geo in
            let length = geo.size.width > geo.size.height ? geo.size.height : geo.size.width
            self
                .resizable()
                .scaledToFill()
                .frame(width: length, height: length, alignment: .center)
                .clipped()
        }
    }
    
    func smallRectangleCropped() -> some View {
 
        GeometryReader { geo in
            let height = geo.size.height > 500 ? CGFloat(500) : geo.size.height
            self
                .resizable()
                .scaledToFill()
                
                .frame(width: geo.size.width, height: height,  alignment: .center)
                
                .aspectRatio(contentMode: .fill)
                
                .clipped()
        }
    }
    
    func mediumRectangleCropped() -> some View {
 
        GeometryReader { geo in
            let height = geo.size.height > 80 ? CGFloat(80) : geo.size.height
            self
                .resizable()
                .scaledToFill()
                
                .frame(width: geo.size.width, height: height,  alignment: .center)
                
                .aspectRatio(contentMode: .fill)
                
                .clipped()
        }
    }
    
    func bigRectangleCropped() -> some View {
 
        GeometryReader { geo in
            let height = geo.size.height > 600 ? CGFloat(600) : geo.size.height
            self
                .resizable()
                .scaledToFill()
                .frame(height: height)
                .aspectRatio(geo.size, contentMode: .fill)
                .clipped()
        }
    }
    
   
 }
