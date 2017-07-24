//
//  ViewController.swift
//  CatchTime
//
//  Created by LIKEXIN on 7/19/17.
//  Copyright © 2017 LIKEXIN. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var SetTimeButton: UIButton!
    var pickerView:UIPickerView!
    var timeStr:String!
    var isStart:Bool!
    var timer:Timer!
    var num:Double = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        isStart = false
        timeStr = "0"
        timeLabel.text = "0.0"
    }
    //hiding TimeLabel
    @IBAction func TouchSwitch(_ sender: UISwitch) {
        timeLabel.isHidden = sender.isOn;
    }
    
    //Reset
    @IBAction func TouchRest(_ sender: UIButton) {
        // SetTimeButton.setTitle("Set Time", for: .normal)
        // timeStr = "0"
        timeLabel.text = "0.0"
        isStart = false
        timer.invalidate()
    }
    
    //SetTime
    @IBAction func TouchSetTime(_ sender: Any) {
        if(isStart){
            showAlertView(title: "Please Pause the timer first !")
            return
        }
        
        
        pickerView = UIPickerView(frame:CGRect(x:0, y:0, width:self.view.frame.size.width, height:self.view.frame.size.height-30))
        //将dataSource设置成自己
        pickerView.dataSource = self
        //将delegate设置成自己
        pickerView.delegate = self
        //设置选择框的默认值
        pickerView.selectRow(0,inComponent:0,animated:true)
        pickerView.backgroundColor = UIColor.white
        self.view.addSubview(pickerView)
        
        //建立一个按钮，触摸按钮时获得选择框被选择的索引
        let button = UIButton(frame:CGRect(x:0, y:self.view.frame.size.height-30, width:self.view.frame.size.width, height:30))
        
        button.backgroundColor = UIColor.blue
        button.setTitle("Selected",for:.normal)
        button.addTarget(self, action:#selector(self.getPickerViewValue),
                         for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    //设置选择框的列数为1列,继承于UIPickerViewDataSource协议
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //设置选择框的行数为60行，继承于UIPickerViewDataSource协议
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return 60
    }
    
    //设置选择框各选项的内容，继承于UIPickerViewDelegate协议
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return String(row+1)
    }
    
    //触摸按钮时，获得被选中的索引
    func getPickerViewValue(_ sender: UIButton){
        pickerView.removeFromSuperview()
        sender.removeFromSuperview()
        timeStr = String(pickerView.selectedRow(inComponent: 0)+1);
        SetTimeButton.setTitle(timeStr!, for: .normal)
        
    }
    
    func showAlertView(title:String){
        // create
        let alertController = UIAlertController(title: "Alert", message: title, preferredStyle:.alert)
        // add
        let okAction = UIAlertAction(title: "Thank you!", style: .default)
        alertController.addAction(okAction)
        // pop up
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    //StartorPause
    @IBAction func TouchStartorPause(_ sender: Any) {
        if timeStr.contains("0") {
            showAlertView(title: "Please Select a time")
        }else{
            if isStart {
                //正在计时
                let label = timeLabel.text
                if (label?.contains(timeStr+".0"))! {
                    showAlertView(title: "You Win")
                }else{
                    showAlertView(title: "You Lost")
                }
                timer.invalidate()
                isStart = false
                
                
            }else{
                timeLabel.text = "0.0"
                num = 0.0
                //开始计时
                isStart = true
                /*
                 参数：
                 TimeInterval：触发时间，单位秒
                 target：定时起触发对象
                 selector：定时器响应方法
                 userInfo：用户信息
                 repeats：是否重复执行，YES 每个指定的时间重复执行，NO 只执行一次
                 */
                timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateTimer(timer:)), userInfo: nil, repeats: true)
            }
        }
    }
    
    
    func updateTimer(timer:Timer) {
        num  = num + 0.1
        timeLabel.text = String(format: "%0.1f", num)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

