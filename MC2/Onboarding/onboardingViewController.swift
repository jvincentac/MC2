//
//  onboardingViewController.swift
//  MC2
//
//  Created by Vincent Alexander Christian on 10/05/20.
//  Copyright © 2020 Vincent Alexander Christian. All rights reserved.
//

import UIKit

class onboardingViewController: UIViewController {

    @IBOutlet weak var descView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePage()
        configureQuestion()
        addAvatarData()
        
        User.deleteAll(viewContext: getViewContext())
        UserCoreDataViewController.user.removeAll()
        print("remove success")
    }
    
    func configurePage() {
        descView.layer.cornerRadius = 15
    }
    
    func addAvatarData() {
        let avatarImg : [String] = [
            "avatar_1.png",
            "avatar_2.png",
            "avatar_3.png",
            "avatar_4.png",
            "avatar_5.png",
            "avatar_6.png"
        ]
        
        let standardAvatarImg : [String] = [
            "avatar_1.png",
            "avatar_2.png",
            "avatar_3.png",
        ]
        
        UserDefaults.standard.set(standardAvatarImg, forKey: "standardAvatarImg")
        UserDefaults.standard.set(avatarImg, forKey: "avatarImg")
    }
    
    func configureQuestion() {
        //masukkan question ke userdefault, cuma pertama kali app dibuka,
        //jawaban ada di [1]
        //question 1 - 4 = untuk interview
        //question 5 - 8 = untuk workplace
        //question 9 - 12 = untuk presentation
        let multipleChoiceConversation = [
            "1" : ["As you know there is an open position in my department, and I need to fill this position as soon as possible.","Please, tell me a little bit about the position.","It is an entry-level position. The new employee will have to work closely with the Accounting department. He will also have to deal with the bank on a daily basis. "],
            "2" : ["OK. Now, let me ask you a few quick questions. You do not mind working long hours, do you?","No, I do not.","Can you handle pressure? "],
            "3" : ["Do you still have any questions for me?","No, I think I have a pretty good understanding of the job. I believe that I can handle it with ease, and I hope to have the opportunity to work for you.","Nice meeting you. Thank you for coming "],
            "4" : ["What kind of experience are you looking for?","Doing office work is good. However, since this is an entry-level position, I do not require a lot of experience. I am willing to train the new person.","That is great!"],
            "5" : ["Hi, ready for your first day at work?","Yes, I've been waiting for this.","Good, let me take you to your cubicle"],
            "6" : ["I haven't seen Annie in a while, I wonder where she is..","Oh, I thought you already knew, she just resigned a week ago","Really?? I wonder why she did that.."],
            "7" : ["Hey, Tom, is there any problem? Your performance hasn't been good as usual","Oh, sorry, I just haven't got enough time to sleep lately","Well, maybe you should take a day-off"],
            "8" : ["Sir, I think we need to postponed our project release date due to COVID-19","Well, I guess we've got no choice after all...","Unfortunately, we might want to reschedule on that."],
            "9" : ["Do you have a scheduled presentation meeting today?","Yes, today I am going to talk about the new project management.","Oh, that's really nice. Who are the audience?"],
            "10" : ["I was thinking of ways to engage with the audience for our presentation later.","How about we ask Mr. Archibald's opinion?","That's a great idea. After all, he's a well-known workshop leader."],
            "11" : ["I'm just a bit concern whether I could conduct the presentation.","What's on your mind?","I'm afraid that the presentation would be too heavy."],
            "12" : ["How was your presentation today?","It was a bit nerve-racking. The clients seems uninterested.","Really? What happened?"],
        ]
        
        let multipleChoice = [
            "1" : ["What is another word that defines the word in Bold?","area","whole","office","cubicle","department"],
            "2" : ["What is another word that defines the word in Bold?","stress","relaxation","ease","facility","pressure"],
            "3" : ["What is another word that defines the word in Bold?","convenience","closure","truth","misfortune","opportunity"],
            "4" : ["What is another word that defines the word in Bold?","background","ignorance","neglect","heedlessness","experience"],
            "5" : ["The word in Bold? has the closest meaning to...","desk","hole","vault","box","cubicle"],
            "6" : ["What is another word that defines the word in Bold?","Relinquish","Apply","Endorse","Prevail","resigned"],
            "7" : ["What is another word that defines the word in Bold?","Achievements","Neglect","Skill","Progress","performance"],
            "8" : ["What is another word that defines the word in Bold?","Adjourn","Forfeit","Settle down","Expedite","postponed"],
            "9" : ["What is another word that defines the word in Bold?","spectators","adherent","confederate","sustainer","audience"],
            "10" : ["What is another word that defines the word in Bold??","viewpoint","copious","discernment","plenteous","opinion"],
            "11" : ["What is another word that defines the word 'in Bold??","loaded","coarse","arduos","vicious","heavy"],
            "12" : ["What is another word that defines the word in Bold??","daunting","soothing","tranquillising","embarrassing","nerve-racking"],
        ]
        
        let FITB = [
            "1" : ["The mission is to help college grads pay off their student ______ speaks to me.","I’ve been in that situation, and I’d love the ______ to work with a coorporate that’s making a difference.","Finding a coorporate with a positive work ______ and values that align with my own has remained a priority throughout my job search,","and this ______ ranks at the top of the list."],
            "2" : ["As an experienced service-oriented ______ with more than a decade of working in boutique salons, I thrive on creating a welcoming environment for all clients.","My ______ training and strong interpersonal skills have helped me","become adept at developing long-term, ______ relationships that help","to build a ______ client base. Some of my clients have been with me since the beginning."],
            "3" : ["I’m looking for an opportunity that gives me the ______ to build closer, long-term relationships with clients.","In my current role, the sales ______ is so short that I don’t spend as much time ","building a ______ with my customers as I’d like.","Relationship-building is one of the reasons I chose a ______ in sales, and I look forward to working with a company where that’s a top priority.”"],
            "4" : ["In five years, I’d like to be an expert in ______ field,","able to train and mentor students and ______ designers alike. I would also like to gain specialized","experience in user experience to be a well-rounded ______ working with design ","and marketing teams on ______ projects that make a difference both in the company and the global community.”"],
            "5" : ["Our company's ______ has been decreasing in the last two months","According to the our customer's ______,","there has been ______ in doing the transaction.","So, today's meeting is about finding the ______ to overcome this problem. "],
            "6" : ["Due to COVID-19, from now on, all workers should do the body temperature check before ______ the office.","All workers are ______ to do social distancing during","this pandemic as a ______ against the spread of this novel corona virus.","If you're not feeling well, please ______ the HRD so you can take a day off. Thank you for your attention."],
            "7" : ["So glad to meet you, I’m Sirius Black, and I heard you last week at our ______ room.","I really liked your views on how our ______ culture can be","strengthened to become more ______.","Can you tell more about your ______?"],
            "8" : ["Hey, how's it going? I heard you are proposing a new ______ program for the entry-levels.","I really like that idea. I understand that training may make a ______,","especially if the participants are given the ______ to practice presentation skills","and gain experience of ______ with each other on real-life issues."],
            "9" : ["Today I would like to share a bit about my ______ as a product designer.","One of the most memorable moment that I will always remember is when I ______ my first user testing.","Our hi-fi prototype link didn't work and I was a bit ______ about it.","I got panicked when the user started asking questions that I suddenly ______."],
            "10" : ["I've never conducted a seminar at a such large ______ before, so this is my first time. Before we jump into the topic,","I would like to start with an ______.","We will play a small game where you can ask me anything that you want to know about me. This ______ will help you understand our next activity","Our next activity is going to talk about ______"],
            "11" : ["Based on our investigation, we found out that we can't continue our work due to our ______.","We've ______ several problems regarding our work management too","We've informed the board leaders and they've been ______ of this.","That's why we are gathered here to talk more about the company shifting to ______ permanently."],
            "12" : ["In this meeting, I would like to ______ an idea to promote a healthier working rhythm in our workplace.","The ______ is to optimize our break time, which will help improve our wellbeing at work.","We are also going to ______ a better personal development program for each of the workers here.","It may sound a bit complicated but I hope we are all in the same ______."],
        ]
        
        let FITBAnswer = [
            "1" : ["loan debt","opportunity","environment","company"],
            "2" : ["professional","specialized","trusted","loyal"],
            "3" : ["ability","cycle","rapport","career"],
            "4" : ["industry","entry-level","contributor","large-scale"],
            "5" : ["profit","feedback","inconvenience","solution"],
            "6" : ["entering","expected","precaution","notify"],
            "7" : ["conference","corporate","inclusive","vision"],
            "8" : ["training","difference","opportunity","consulting"],
            "9" : ["experience","conducted","perplexed","passed out"],
            "10" : ["venue","ice-breaker","activity","inquiry"],
            "11" : ["investigation","report","aware","remote work"],
            "12" : ["propose","goal","improving","knowledge"],
        ]
        
        let trueFalse = [
            "1" : ["Interview is a formal consultation usually to evaluate qualifications (as of a prospective student or employee)","true","Interview"],
            "2" : ["Entry-level jobs are jobs that not require minimal professional work experience and open the door to larger, work-related opportunities.","false","Entry-level"],
            "3" : ["In company, human resources describes the people who make up the workforce of an organization, industry, business sector, or economy.","true","human resources"],
            "4" : ["Employee should know that an organizational goal can be something as simple as finding a way to shorten the amount of time it takes for a product to leave a warehouse or as elaborate as introducing a new product to the marketplace that makes all previous versions of this type of product obsolete","true","organizational goal"],
            "5" : ["The point of Benchmarking is to identify internal opportunities for improvement, by evaluating a certain situation with a standard to compare.","true","benchmarking"],
            "6" : ["Stakeholders are those who acquire, manipulate, interpret, and apply information in order to perform multidisciplinary, complex and unpredictable work.","false","corporate culture"],
            "7" : ["A strong corporate culture  is one which is deeply embedded into the ways a business or organisation does things. With a strong culture, employees and management understand what is required of them and they will try to act in accordance with the core values.","true","Stakeholders"],
            "8" : ["Wage is a fixed amount of money that is paid in each pay period.","true","Wage"],
            "9" : ["Conclusion contains the gist of the research findings and are usually stated at the end of the presentation.","true","Conclusion"],
            "10" : ["In paraphrasing a sentence, you can't say 'in other words' or 'to put it more simply' because your argument should not be repeated using simpler language.","false","paraphrasing"],
            "11" : ["After answering a question from the audience, you can inquire them by saying, \"Does this answer your question?\" to check whether they've understood and is satisfied with your answer.","true","inquire"],
            "12" : ["If you are not the only speaker to the pitching, you can hand over to someone else by saying, \"Now I will pass you over to my colleague\" then you can mention their name.","true","hand over"],
        ]
        
        UserDefaults.standard.set(trueFalse, forKey: "trueFalse")
        UserDefaults.standard.set(FITB, forKey: "FITB")
        UserDefaults.standard.set(FITBAnswer, forKey: "FITBAnswer")
        UserDefaults.standard.set(multipleChoice, forKey: "multipleChoice")
        UserDefaults.standard.set(multipleChoiceConversation, forKey: "multipleChoiceConversation")
    }
    
    @IBAction func next(_ sender: Any) {
        
    }
    
    @IBAction func skip(_ sender: UIButton) {
        //code dismiss onboarding
        let sb = UIStoryboard(name: "UserRegis", bundle: nil).instantiateViewController(withIdentifier: "UserRegis") as! UserRegisViewController
        sb.modalPresentationStyle = .fullScreen
        present(sb, animated: true, completion: nil)
    }
}
