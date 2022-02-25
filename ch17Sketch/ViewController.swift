//
//  ViewController.swift
//  ch17Sketch
//
//  Created by 김규리 on 2022/01/27.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imgView: UIImageView!
    
    var lastPoint: CGPoint! // 바로 전에 터치하거나 이동한 위치
    var lineSize:CGFloat = 2.0 // 선의 두께
    var lineColor = UIColor.black.cgColor // 선의 색상
    
    @IBOutlet var txtLineSize: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnBlack(_ sender: UIButton) {
        if txtLineSize.text?.isEmpty == false {
            lineSize = CGFloat((txtLineSize.text! as NSString).floatValue)
        }
        lineColor = UIColor.black.cgColor
    }
    
    @IBAction func btnRed(_ sender: UIButton) {
        if txtLineSize.text?.isEmpty == false {
            lineSize = CGFloat((txtLineSize.text! as NSString).floatValue)
        }
        lineColor = UIColor.red.cgColor
    }
    
    @IBAction func btnGreen(_ sender: UIButton) {
        if txtLineSize.text?.isEmpty == false {
            lineSize = CGFloat((txtLineSize.text! as NSString).floatValue)
        }
        lineColor = UIColor.green.cgColor
    }
    
    @IBAction func btnBlue(_ sender: UIButton) {
        if txtLineSize.text?.isEmpty == false {
            lineSize = CGFloat((txtLineSize.text! as NSString).floatValue)
        }
        lineColor = UIColor.blue.cgColor
    }
    
    
    // 그렸던 스케치 지우는 함수
    @IBAction func clearImageView(_ sender: UIButton) {
        imgView.image = nil
    }
    
    // 화면을 터치하면 스케치를 시작
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch // 현재 발생한 터치 이벤트를 가져옴
        
        lastPoint = touch.location(in: imgView) // 터치된 위치를 lastPoint에 저장
    }
    
    // 터치한 손가락을 움직이면 스케치도 따라서 움직이도록
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIGraphicsBeginImageContext(imgView.frame.size) // 콘텍스트를 이미지 뷰의 크기와 같게
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor) // 선 색상
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round) // 라인의 끝 모양을 라운드로 설정
        UIGraphicsGetCurrentContext()?.setLineWidth(lineSize) // 선 두께
        
        let touch = touches.first! as UITouch // 현재 발생한 터치 이벤트를 가져옴
        let currPoint = touch.location(in: imgView) // 터치된 위치를 currPoint로 가져옴
        
        imgView.image?.draw(in: CGRect(x: 0, y: 0, width: imgView.frame.size.width, height: imgView.frame.size.height)) // 현재 이미지뷰에 있는 이미지를 이미지 뷰의 크기로 그림
        
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y)) // 이전에 이동된 위치인 lastPoint로 시작 위치를 이동시킴
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: currPoint.x, y: currPoint.y)) // lastPoint에서 CurrPoint까지 선을 추가
        UIGraphicsGetCurrentContext()?.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        lastPoint = currPoint // 현재 터치된 위치를 lastPoint 변수에 할당
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIGraphicsBeginImageContext(imgView.frame.size) // 콘텍스트를 이미지 뷰의 크기와 같게
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor) // 선 색상
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round) // 라인의 끝 모양을 라운드로 설정
        UIGraphicsGetCurrentContext()?.setLineWidth(lineSize) // 선 두께
        
        imgView.image?.draw(in: CGRect(x: 0, y: 0, width: imgView.frame.size.width, height: imgView.frame.size.height)) // 현재 이미지뷰에 있는 이미지를 이미지 뷰의 크기로 그림
        
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y)) // 이전에 이동된 위치인 lastPoint로 시작 위치를 이동시킴
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: lastPoint.x, y: lastPoint.y)) //
        UIGraphicsGetCurrentContext()?.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    // 기기를 흔들었을 때 그렸던 스케치가 지워지도록 모션 추가
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake { // skake라는 모션 이벤트가 발생할 경우
            imgView.image = nil
        }
    }
}

