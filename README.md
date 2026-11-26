# FlexyGames

FlexyGames is community website for gentlemen allowing easy management of sportive sessions.

Concretly it is a web site developped with the Groovy language and with the Grails framework.

## Build and run

- **Stack:** Grails `7.2.4`, Groovy 4, Spring Boot 3, Hibernate 5.6 and Apache Shiro 3.
- **Java:** Java 17 or later; the Gradle wrapper downloads Gradle `8.14.5`, so no local Grails or Gradle install is needed.
- **Sample data:** `./gradlew bootRun -Dgrails.env=test` starts the site on `http://localhost:8080` with an in-memory H2
  database that `BootStrap.groovy` fills with sample teams, users and sessions.
- **Development database:** `./gradlew bootRun` expects a PostgreSQL database `flexygames` on `localhost:5432`.
- **Production package:** `./gradlew bootWar` builds `build/libs/flexygames.war`.  
  It runs with `java -jar`, or in an external Tomcat `10.1` or later, because the app uses the Jakarta EE 10 servlet API.

## Tests

- **Unit tests:** `./gradlew test`.
- **Integration tests:** `./gradlew integrationTest` starts the whole site on H2.  
  `LoginSpec` and `PagesSpec` check the login, the access control and the main pages.
- **Generated stubs:** most `*ControllerSpec` and `*ServiceSpec` classes are generated stubs that end with
  `assert false, "TODO ..."`, so they fail until someone writes their test data.
