


import UIKit
import ImageIO
import Kingfisher

struct ImageHeaderData{
    static var PNG: [UInt8] = [0x89]
    static var JPEG: [UInt8] = [0xFF]
    static var GIF: [UInt8] = [0x47]
    static var TIFF_01: [UInt8] = [0x49]
    static var TIFF_02: [UInt8] = [0x4D]
}


extension UIImage {
    
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    
    func jpeg(_ quality: JPEGQuality) -> Data? {
        return UIImageJPEGRepresentation(self, quality.rawValue)
    }
    
    func imageFormatString(_ url : String) -> String{
        let url = URL(string: url)
        var buffer = [UInt8](repeating: 0, count: 1)
        let data = NSData(contentsOf: url!)
        data?.getBytes(&buffer, range: NSRange(location: 0,length: 1))
        if buffer == ImageHeaderData.PNG
        {
            return "png"
        } else if buffer == ImageHeaderData.JPEG
        {
            return "jpeg"
        } else if buffer == ImageHeaderData.GIF
        {
            return "gif"
        } else if buffer == ImageHeaderData.TIFF_01 || buffer == ImageHeaderData.TIFF_02{
            return "iff"
        } else{
            return "jpg"
        }
    }
    
    var widthPixel : Int {
        get {
            return Int(self.scale * self.size.width)
        }
    }
    
    var hieghtPixel : Int {
        get {
            return Int(self.scale * self.size.height)
        }
    }
    
    var fileSize :Double  {
        get {
            var imgData =  UIImagePNGRepresentation(self)
            let imageSize: Int = imgData!.count
            return Double(imageSize) / 1024.0
        }
    }

    func resizeImage(newWidth: CGFloat) -> UIImage {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage ?? self
    }
    
    func resizeImage( targetSize: CGSize) -> UIImage {
        let size = self.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio,height: size.height * heightRatio)
        } else {
            newSize = CGSize(width:size.width * widthRatio,height:  size.height * widthRatio)
        }
        
        let rect = CGRect(x:0,y: 0,width: newSize.width,height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    func with(color: UIColor) -> UIImage {
        guard let cgImage = self.cgImage else {
            return self
        }
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(.normal)
        let imageRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        context.clip(to: imageRect, mask: cgImage)
        color.setFill()
        context.fill(imageRect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext();
        return newImage
    }
    
    func changeImageColorTint(_ color : UIColor) {
        self.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        
    }
    
    func encodeImage () -> String {
        let strBase64 = UIImagePNGRepresentation(self)!.base64EncodedString()
        return strBase64
        
    }
    
    func decodeImage (_ mediaFile : String) -> UIImage? {
        if let decodedData = Data(base64Encoded: mediaFile, options: .ignoreUnknownCharacters) {
            let image = UIImage(data: decodedData)
            return image
        }
        
        return nil
    }
    
    func gitToData (_ url : String) -> Data {
        let data = try! Data(contentsOf: URL(string: url)!)
        return data
        
    }
    
    func imageToDate() -> Data?{
        
        let data = UIImagePNGRepresentation(self)
        return data ?? nil
    }
    
    func dateToImage(_ data : Data) -> UIImage? {
        
        let imagePt = UIImage(data: data)
        return imagePt
    }
    
    func compress(maxSize: CGFloat) -> Data? {
        guard let imageSize = UIImageJPEGRepresentation(self, 1)?.count else { return nil }
        
        if CGFloat(imageSize) <= (maxSize * 1024) {
            return UIImageJPEGRepresentation(self, 1)
        }
        
        let compressionRate: CGFloat = (maxSize * 1024) / CGFloat(imageSize)
        
        return UIImageJPEGRepresentation(self, compressionRate)
    }
    
    public func image(withTintColor color: UIColor) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(CGBlendMode.normal)
        let rect: CGRect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context.clip(to: rect, mask: self.cgImage!)
        color.setFill()
        context.fill(rect)
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}

extension UIImageView {
    
    var widthPixel : Int {
        get {
            return Int(self.image!.scale * self.image!.size.width)
        }
    }
    
    var hieghtPixel : Int {
        get {
            return Int(self.image!.scale * self.image!.size.height)
        }
    }
    
    @IBInspectable var imageTint: UIColor {
        get {
            return tintColor
        }
        set {
            self.image = self.image!.withRenderingMode(.alwaysTemplate)
            self.tintColor = newValue
        }
    }
    
    func disable() {
        self.alpha = 0.5
    }
    
    func enable() {
        self.alpha = 1
    }
    
    func ShowLoadingOnImage (){
        self.kf.indicatorType = .activity
    }
    
    func changeImageColorTint(_ color : UIColor) {
        self.image = self.image!.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
    }
    
    
    func imageFromURL( _ url : String , placeHolder : UIImage?) {
        self.kf.setImage(with: URL(string: url), placeholder: placeHolder , options: [.cacheOriginalImage], progressBlock: { (recivedSize,size) in
        }, completionHandler: nil)
    }
    
    func imageFromURL( _ url : String , placeHolder : UIImage? , clouser : @escaping  ((_ error : NSError?) -> ())) {
        self.kf.setImage(with: URL(string: url), placeholder: placeHolder , options: [.cacheOriginalImage], progressBlock: { (recivedSize,size) in
        }, completionHandler: {
            (image, error, cashType, url) in
            clouser(error)
        })
    }
}
