//
//  ViewController.swift
//  kakaoLoginTest
//
//  Created by Jeong Hyeon Uk on 17/12/2018.
//  Copyright © 2018 HUONE Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return.lightContent
    }
    
    @IBAction func loginKakao(_ sender: UIButton) {
        let session = KOSession.shared()
        // If login session create succeed
        if let s = session {
            // Close old session
            if s.isOpen() {
                s.close()
            }
            s.open(completionHandler: { (error) -> Void in
                // If sign in error didn't occured
                if error == nil {
                    print("No Error Occured")
                    // If sign in succeed
                    if s.isOpen() {
                        KOSessionTask.signupTask(withProperties: nil, completionHandler: { success, error in
                            // If sign up succeed
                            if success {
                                print("Sign Up Succeed")
                            }
                            // If sign up failed
                            else {
                                // If user is signed up
                                if (error as NSError?)?.code == Int(KOServerErrorAlreadySignedUpUser.rawValue) {
                                    print("Already Signed Up User")
                                }
                                // If sign up error did occured
                                else {
                                    print("Sign Up Error : \(error!)")
                                }
                            }
                        })
                        print("Sign In Succeed")
                        KOSessionTask.userMeTask(withPropertyKeys: ["properties.nickname", "properties.profile_image", "properties.thumbnail_image"]) { error, me in
                            // If get information failed
                            if error != nil {
                                print("Get Info Error : \(error!)")
                            }
                            // If get information succeed
                            else {
                                if let kID = me?.id {
                                    print("사용자 아이디: \(kID)")
                                }
                                if let kNickname = me?.nickname {
                                    print("사용자 닉네임: \(kNickname)")
                                }
                                if let kProfileImage = me?.profileImageURL {
                                    print("사용자 프로필 이미지: \(kProfileImage)")
                                }
                                if let kThumbnailImage = me?.thumbnailImageURL {
                                    print("사용자 썸네일 이미지: \(kThumbnailImage)")
                                }
                            }
                        }
                    }
                    // If sign in failed
                    else {
                        print("Sign In Failed")
                    }
                }
                // If sign in error did occured
                else {
                    print("Sign In Error : \(error!)")
                }
            })
        }
        // If sign in session create failed
        else {
            print("Something Wrong")
        }
    }
}

