import MobileCoreServices

public class SwiftyolLibrary {
    public enum colorSpace {
        case rgb
        case gray
    }
    public init () {}
}

extension SwiftyolLibrary {
    public func convertImageToGrayscale(image: UIImage) -> UIImage? {
        let imageWidth = Int(image.size.width)
        let imageHeight = Int(image.size.height)
        let imageColorSpace = CGColorSpaceCreateDeviceGray()
        let imageRect: CGRect = CGRect(x:0, y:0, width:imageWidth, height: imageHeight)
        let imageBitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)
        let context = CGContext(data: nil, width: imageWidth, height: imageHeight, bitsPerComponent: 8, bytesPerRow: 0, space: imageColorSpace, bitmapInfo: imageBitmapInfo.rawValue)
        if let cgImg = image.cgImage {
            context?.draw(cgImg, in: imageRect)
            if let makeImg = context?.makeImage() {
                let imageRef = makeImg
                let newImage = UIImage(cgImage: imageRef)
                return newImage
            }
        }
        return UIImage()
    }
    
    public func convertImagesToGrayscale(images: [UIImage]) -> [UIImage]? {
        var grayscaleImages: [UIImage] = []
        let grayscaleGroup = DispatchGroup()
        for image in images {
            grayscaleGroup.enter()
            let imageWidth = Int(image.size.width)
            let imageHeight = Int(image.size.height)
            let imageColorSpace = CGColorSpaceCreateDeviceGray()
            let imageRect: CGRect = CGRect(x:0, y:0, width:imageWidth, height: imageHeight)
            let imageBitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)
            let context = CGContext(data: nil, width: imageWidth, height: imageHeight, bitsPerComponent: 8, bytesPerRow: 0, space: imageColorSpace, bitmapInfo: imageBitmapInfo.rawValue)
            if let cgImg = image.cgImage {
                context?.draw(cgImg, in: imageRect)
                if let makeImg = context?.makeImage() {
                    let imageRef = makeImg
                    let newImage = UIImage(cgImage: imageRef)
                    grayscaleImages.append(newImage)
                    grayscaleGroup.leave()
                }
            }
        }
        return grayscaleImages
    }
    
    // let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    //let fileURL = directory.appendingPathComponent("filename")
    
    public func generateGifFromImages(images: [UIImage], fileURL: URL, colorSpace: colorSpace, delayTime: Double) {
        let gifGroup = DispatchGroup()
        var tempImages: [UIImage] = []
        for image in images {
            gifGroup.enter()
            let imageWidth = 500
            let imageHeight = 500
            var imageColorSpace: CGColorSpace
            if colorSpace == .rgb {
                imageColorSpace = CGColorSpaceCreateDeviceRGB()
            } else {
                imageColorSpace = CGColorSpaceCreateDeviceGray()
            }
            let imageRect: CGRect = CGRect(x:0, y:0, width:imageWidth, height: imageHeight)
            let imageBitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue)
            let context = CGContext(data: nil, width: imageWidth, height: imageHeight, bitsPerComponent: 8, bytesPerRow: 0, space: imageColorSpace, bitmapInfo: imageBitmapInfo.rawValue)
            if let cgImg = image.cgImage {
                context?.draw(cgImg, in: imageRect)
                if let makeImg = context?.makeImage() {
                    let imageRef = makeImg
                    let newImage = UIImage(cgImage: imageRef)
                    tempImages.append(newImage)
                    gifGroup.leave()
                }
            }
        }
        
        gifGroup.notify(queue: .main) {
            let fileProperties: CFDictionary = [kCGImagePropertyGIFDictionary as String: [kCGImagePropertyGIFLoopCount as String: 0]]  as CFDictionary
            let frameProperties: CFDictionary = [kCGImagePropertyGIFDictionary as String: [(kCGImagePropertyGIFDelayTime as String): 1.0]] as CFDictionary
            
            if let url = fileURL as CFURL? {
                if let destination = CGImageDestinationCreateWithURL(url, kUTTypeGIF, images.count, nil) {
                    CGImageDestinationSetProperties(destination, fileProperties)
                    for image in tempImages {
                        if let cgImage = image.cgImage {
                            CGImageDestinationAddImage(destination, cgImage, frameProperties)
                        }
                    }
                    if !CGImageDestinationFinalize(destination) {
                        print("Failed to finalize the image destination")
                    }
                }
            }
        }
    }
}
