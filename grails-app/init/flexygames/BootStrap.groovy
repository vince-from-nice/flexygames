package flexygames

import java.text.SimpleDateFormat

import org.apache.shiro.crypto.hash.Sha512Hash

import flexygames.GameAction
import flexygames.GameSkill
import flexygames.GameType
import flexygames.Participation
import flexygames.User
import flexygames.Playground
import flexygames.Session
import flexygames.SessionGroup
import flexygames.SessionRound
import flexygames.Role
import flexygames.Team

//import flexygames.Player;

class BootStrap {

    def init = { servletContext ->
        println "***** FlexyGames: ApplicationBootStrap.init() started..."
        Locale.setDefault(new Locale("en"))
        // GORM writes collections (roles, permissions, memberships) only when a transaction commits.
        Role.withTransaction {
            if (!Role.findByName("Administrator")) {
                createObjects()
            } else {
                println "Database seems to be already populated => no objects creation !"
            }
        }
        println "***** FlexyGames: ApplicationBootStrap.init() returned..."
    }
    
    def destroy = {
        println "***** FlexyGames: ApplicationBootStrap.destroy() started..."
        println "***** FlexyGames: ApplicationBootStrap.destroy() returned..."                   
    }
    
    // Sample sessions sit around today, so the home page and the session list show past and coming sessions.
    private static Date at21h(int daysFromToday) {
        Calendar c = Calendar.instance
        c.add(Calendar.DAY_OF_MONTH, daysFromToday)
        c.set(Calendar.HOUR_OF_DAY, 21)
        c.set(Calendar.MINUTE, 0)
        c.set(Calendar.SECOND, 0)
        c.set(Calendar.MILLISECOND, 0)
        c.time
    }

    def private createObjects() {
        println "Creating objects..."
        
        def adminRole = new Role(name: "Administrator")
        adminRole.addToPermissions("*:*")
        adminRole.save()
        
        def playerRole = new Role(name: "Player")
        playerRole.addToPermissions("sessions:*")
        playerRole.addToPermissions("myself:*")
		playerRole.addToPermissions("manager:*")
		playerRole.addToPermissions("fileUploader:*")
        playerRole.save()
        
        Team t1
        t1 = new Team(name:"ASAS UrbanFoot Team", city: "Paris", email: "asas@onlacherien.org", webUrl:"http://www.onlacherien.org")
        t1.save()
        
        Team t2
        t2 = new Team(name:"ASAS UrbanFoot Guests", city: "Paris", email: "asas@onlacherien.org", webUrl:"http://www.onlacherien.org")
        t2.save()
        
        Team t3
        t3 = new Team(name:"ASAS Volleyball Team", city: "Paris", email: "asas@onlacherien.org", webUrl:"http://www.onlacherien.org")
        t3.save()
        
        Team t4
        t4 = new Team(name:"ASAS Volleyball Guests", city: "Paris", email: "asas@onlacherien.org", webUrl:"http://www.onlacherien.org")
        t4.save()
        
        User u
        
        User turman = new User(username:"turman", passwordHash: new Sha512Hash("gluar").toHex(), registrationDate: new Date(), email:"vincent.frison@gmail.com")
        turman.addToRoles(playerRole)
        turman.addToRoles(adminRole)
        turman.addToMemberships(new Membership(user: turman, team: t1, manager: true, regularForTraining: true, regularForCompetition: false))
        turman.initCounters()
        turman.save()
        
        User user1 = new User(username:"user1", passwordHash: new Sha512Hash("gluar").toHex(), registrationDate: new Date(), email:"user1@example.com")
        user1.addToRoles(playerRole)
        user1.addToMemberships(new Membership(user: user1, team: t1, manager: false, regularForTraining: true, regularForCompetition: false))
        user1.initCounters()
        user1.save()
        
        User user2 = new User(username:"user2", passwordHash: new Sha512Hash("gluar").toHex(), registrationDate: new Date(), email:"user2@example.com")
        user2.addToRoles(playerRole)
        user2.addToMemberships(new Membership(user: user2, team: t1, manager: false, regularForTraining: true, regularForCompetition: false))
        user2.initCounters()
        user2.save()
        
        User user3 = new User(username:"user3", passwordHash: new Sha512Hash("gluar").toHex(), registrationDate: new Date(), email:"user3@example.com")
        user3.addToRoles(playerRole)
        user3.addToMemberships(new Membership(user: user3, team: t1, manager: false, regularForTraining: true, regularForCompetition: false))
        user3.initCounters()
        user3.save()
        
        User user4 = new User(username:"user4", passwordHash: new Sha512Hash("gluar").toHex(), registrationDate: new Date(), email:"user4@example.com")
        user4.addToRoles(playerRole)
        user4.addToMemberships(new Membership(user: user4, team: t1, manager: false, regularForTraining: true, regularForCompetition: false))
        user4.initCounters()
        user4.save()
        
        User user5 = new User(username:"user5", passwordHash: new Sha512Hash("gluar").toHex(), registrationDate: new Date(), email:"user5@example.com")
        user5.addToRoles(playerRole)
        user5.addToMemberships(new Membership(user: user5, team: t1, manager: false, regularForTraining: true, regularForCompetition: false))
        user5.initCounters()
        user5.save()
       
        GameType foot
        foot = new GameType(name:"Football")
        foot.addToSkills(new GameSkill(code: "Goalkeeper", type: foot))
        foot.addToSkills(new GameSkill(code: "Defender", type: foot))
        foot.addToSkills(new GameSkill(code: "Midfielder", type: foot))
        foot.addToSkills(new GameSkill(code: "Forward", type: foot))
        foot.save()
        
        GameType volley
        volley = new GameType(name: "Volleyball")
        volley.addToSkills(new GameSkill(code: "Libero", type: volley))
        volley.addToSkills(new GameSkill(code: "Setter", type: volley))
        volley.addToSkills(new GameSkill(code: "Blocker", type: volley))
        volley.addToSkills(new GameSkill(code: "Hitter", type: volley))
        volley.save()
        
        Playground bonneuil = new Playground(name:"UrbanFoot de Bonneuil").save()
        Playground meudon = new Playground(name:"DreamFoot de Meudon").save()
        Playground turgot = new Playground(name:"Lycée Turgot").save()
        Playground pv = new Playground(name:"Lycée Paul-Valérie").save()
        
        SessionGroup sgFoot = new SessionGroup(name:"Entraînements de foot à 5 d'ASAS (2011-2012)", defaultType: foot, defaultPlayground:bonneuil, defaultMinPlayerNbr: 8, defaultMaxPlayerNbr: 10, defaultPreferredPlayerNbr: 10, defaultDuration: 60, defaultLockingTime: 0)
        sgFoot.addToDefaultTeams(t1)
        sgFoot.save()
        
        SessionGroup sgVolley = new SessionGroup(name:"Entraînements de volleyball d'ASAS (2011-2012)", defaultType: volley, defaultPlayground:turgot, defaultMinPlayerNbr: 4, defaultMaxPlayerNbr: 24, defaultPreferredPlayerNbr: 16, defaultDuration: 60, defaultLockingTime: 0)
        sgVolley.addToDefaultTeams(t3)
        sgVolley.save()
        
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm")
        
        Session s1 = new Session(date: at21h(-14), type: foot, playground: bonneuil, group:sgFoot)
        s1.save()
        Session s2 = new Session(date: at21h(-7), type: foot, playground: meudon, group:sgFoot)
        s2.save()
        Session s3 = new Session(date: at21h(-1), type: foot, playground: bonneuil, group:sgFoot)
        s3.save()
        Session s4 = new Session(date: at21h(2), type: foot, playground: bonneuil, group:sgFoot)
        s4.save()
        Session s5 = new Session(date: at21h(5), type: foot, playground: bonneuil, group:sgFoot)
        s5.save()
       
        df = new SimpleDateFormat("yyyy-MM-dd HH:mm")
        
        def activityLogRequest = df.format(new Date()) + " : participation has been  " + Participation.Status.REQUESTED.code
        def activityLogApproved= df.format(new Date()) + " : participation has been " + Participation.Status.APPROVED.code
        def activityLogDeclined= df.format(new Date()) + " : participation has been  " + Participation.Status.DECLINED.code
        
        new Participation(lastUpdate: new Date(), player: turman, session:s4, statusCode: Participation.Status.APPROVED.code, activityLog: activityLogApproved).save()
        new Participation(lastUpdate: new Date(), player: user1, session:s4, statusCode: Participation.Status.APPROVED.code, activityLog: activityLogApproved).save()
        new Participation(lastUpdate: new Date(), player: user2, session:s4, statusCode: Participation.Status.DECLINED.code, activityLog: activityLogDeclined).save()
        new Participation(lastUpdate: new Date(), player: user3, session:s4, statusCode: Participation.Status.APPROVED.code, activityLog: activityLogApproved).save()
        new Participation(lastUpdate: new Date(), player: user4, session:s4, statusCode: Participation.Status.APPROVED.code, activityLog: activityLogApproved).save()
        new Participation(lastUpdate: new Date(), player: user5, session:s4, statusCode: Participation.Status.REQUESTED.code, activityLog: activityLogRequest).save()
        
        new Participation(lastUpdate: new Date(), player: turman, session:s5, statusCode: Participation.Status.REQUESTED.code, activityLog: activityLogRequest)
        new Participation(lastUpdate: new Date(), player: user1, session:s5, statusCode: Participation.Status.APPROVED.code, activityLog: activityLogApproved).save()
        new Participation(lastUpdate: new Date(), player: user2, session:s5, statusCode: Participation.Status.REQUESTED.code, activityLog: activityLogRequest).save()
        new Participation(lastUpdate: new Date(), player: user3, session:s5, statusCode: Participation.Status.REQUESTED.code, activityLog: activityLogRequest).save()
        new Participation(lastUpdate: new Date(), player: user4, session:s5, statusCode: Participation.Status.REQUESTED.code, activityLog: activityLogRequest).save()
        new Participation(lastUpdate: new Date(), player: user5, session:s5, statusCode: Participation.Status.REQUESTED.code, activityLog: activityLogRequest).save()
        
//        SessionRound sr11 = new SessionRound(session:s1/*, index: 1*/, playersForTeamA: [turman, user1, user5], playersForTeamB: [user2, user4, user3])
//        sr11.save()
//        SessionRound sr12 = new SessionRound(session:s1/*, index: 2*/, playersForTeamA: [turman, user1, user3], playersForTeamB: [user2, user4, user5])
//        sr12.save()
//        SessionRound sr13 = new SessionRound(session:s1/*, index: 3*/, playersForTeamA: [turman, user2, user3], playersForTeamB: [user1, user4, user5])
//        sr13.save()
//        
//        new GameAction(sessionRound: sr11, mainContributor: turman, secondaryContributor: user1).save()
//        new GameAction(sessionRound: sr11, mainContributor: turman, secondaryContributor: null).save()
//        new GameAction(sessionRound: sr11, mainContributor: turman, secondaryContributor: user1).save()
//        new GameAction(sessionRound: sr11, mainContributor: user1, secondaryContributor: turman).save()
//        new GameAction(sessionRound: sr11, mainContributor: user1, secondaryContributor: turman).save()
//        new GameAction(sessionRound: sr11, mainContributor: user2, secondaryContributor: user2).save()
//        new GameAction(sessionRound: sr11, mainContributor: user2, secondaryContributor: user2).save()
//        new GameAction(sessionRound: sr11, mainContributor: user2, secondaryContributor: user2).save()
        
    }
    
}
