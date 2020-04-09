//
//  ViewController.swift
//  RanDog
//
//  Created by Isaac Karam on 4/9/20.
//  Copyright © 2020 Isaac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var breeds : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pickerView.delegate = self
        pickerView.dataSource = self
        
        DogAPI.requestBreedsList(completionHandler: handleBreedsListResponse(breeds:error:))
    }
    
    func handleBreedsListResponse(breeds : [String], error : Error?){
        self.breeds = breeds
        DispatchQueue.main.async {
            self.pickerView.reloadAllComponents()
        }
        
    }
    
    func handleRandomImageResponse(imageData : DogImage?, error : Error?){
        guard let imageURL = URL(string: imageData?.message ?? "")else{
            return
        }
        DogAPI.requestImageFile(url: imageURL, completionHandler: handleImageFileResponse(imageData:error:))
        
    }
    
    func handleImageFileResponse(imageData : UIImage?, error : Error?){
        DispatchQueue.main.async {
            self.imageView.image = imageData
        }
        
    }

}

extension ViewController : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
                DogAPI.requestRandomImage(breed: breeds[row],completionHandler: handleRandomImageResponse(imageData:error:))
    }
    
    
}
