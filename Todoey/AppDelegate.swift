import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //Launch at very first when the app launches.
        
//        print(Realm.Configuration.defaultConfiguration.fileURL)
      
        
        do{
            _ = try Realm()

        }catch{
            print("Error initialising new realm, \(error)")
        }
        
        return true
    }

    //func applicationWillResignActive(_ application: UIApplication) {

        //this will called when something is happened to the phone when the app is open or in the foreground.(such as incoming call or sms.). Data wont lost.
    //}

    //func applicationDidEnterBackground(_ application: UIApplication) {
        //when the app dissappears off the screen (say, when the home button pressed) or open up a different app
    //}

    //func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    //}

    //func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //}

//    func applicationWillTerminate(_ application: UIApplication) {
//        //Called when the app is basically terminated
//
//    }
}
