//
//  QuestionAndAnswerData.swift
//  FblaSignUpPage
//
//  Created by Sid on 1/1/20.
//  Copyright © 2020 sid. All rights reserved.
//

import Foundation

struct QA{
    static let questionAnswerList: [QASet] = [
        QASet(question: "What does MVFBLA offer?", answer: "MVFBLA offers students of all grades (9th through 12th) the opportunity to take their skills beyond the classroom - through exciting competitions and leadership workshops, students can gain real-world experience that will help them in their future careers."),
        QASet(question: "What is the difference between FBLA and DECA?", answer: "In general, FBLA is a business club that has aspects ranging from general business, entrepreneurship, to even technology. DECA is also a business club on campus that focuses on business and marketing. In the past years, FBLA has been a smaller club in comparison to DECA, but we believe this gives us more time to focus on you individually. In addition to the competitions side, MVFBLA has a unique projects team, unlike other clubs, that has in the past has worked in the Community Service, American Enterprise, and Partnership with Business areas. Projects provide an excellent opportunity to get involved in MVFBLA and gain leadership skills. Past projects have included teaching ESL classes, teaching business to Kennedy Middle School students, partnering with NASA, and hosting the city wide Healthy-Life Campaign. /However, we do realize that both clubs are great for any student interested in business as they both teach the fundamentals and provide a hands on experience. Some students join both FBLA and DECA and we encourage you to find your right fit as both with provide you with a quality experience."),
        QASet(question: "I'm not interested in business. Can I still join?", answer: "Sure! MVFBLA offers you many opportunities outside of pure business - our competitions span from business to programming and software development, and we offer workshops and opportunities to learn skills that will serve you no matter what career you decide to pursue."),
        QASet(question: "Are all competitions tests?", answer: "Of course not! We get enough of them at Monta Vista already. While we do offer tests (written competitions), we have oral competitions such as Business Presentation or Parliamentary Procedure, and also technology competitions such as Desktop Application Programming."),
        QASet(question: "What kind of activities do you do in FBLA besides competing?", answer: "Besides competitions, we have exciting projects and workshops, in addition to fun conferences. Besides just being a club where you can gain experience and learn new skills, FBLA is an opportunity to meet new people and network with people from all grades at Monta Vista, establishing life-long friendships. More than just a club, FBLA is a lifestyle. An FBLAmazing lifestyle!"),
        QASet(question: "Is FBLA experienced and what is the clubs history?", answer: "MVFBLA has existed for almost 50 years, making us one of the oldest clubs on campus, and of the most highly-ranked-- we're currently ranked 4th nation-wide! We send around 40% of our total membership base to the National Leadership Conference every year, and about 90% of our competitors who attend the National Conference place in the top ten. In addition to this, MVFBLA members have placed number one in the nation 20 times. We truly do have experience and are always looking to pass on the knowledge."),
        QASet(question: "How old is MVFBLA?", answer: "We are one of the oldest and most experienced clubs on campus. Come create your own legacy and add on to our over 50 years of excellence."),
        QASet(question: "How will FBLA help me learn business?", answer: "One of the main aspects of our club that we pride ourselves upon is the one-on-one attention we give to our members. Along with the many resources we have hand gathered to help aid our members' success, we also enjoy spending time to ensure everyone is getting the help they need. It is a guarantee that you will be working with some of the most successful competitors as well as the most experienced officers to make sure that each and every member in Monta Vista FBLA will be able to create their own legacy.")
        
    ]
}

class QASet{
    var question: String?
    var answer: String?
    
    init(question: String, answer: String) {
        self.question = question
        self.answer = answer
    }
    
    func getAnswer()    -> String{ return answer!    }
    func getQuestion()  -> String{ return question!  }
}
