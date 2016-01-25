dataSource {
    pooled = true
    driverClassName = "org.hsqldb.jdbcDriver"
    username = "sa"
    password = ""
}
hibernate {
    //cache.use_second_level_cache = true
    //cache.use_query_cache = true
    cache.provider_class='org.hibernate.cache.EhCacheProvider'
}

// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "update" // one of 'create', 'create-drop','update'
            //url = "jdbc:hsqldb:mem:devDB"
            driverClassName = "org.postgresql.Driver"
            url = "jdbc:postgresql://localhost/flexygames"
            username = "postgres"
            password = ""
			loggingSql = true // see log4j block in Config.groovy
            format_sql = true
            use_sql_comments = true
        }
    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:hsqldb:mem:testDb"
        }
    }
    production {
        dataSource {
            dbCreate = "update"
            driverClassName = "org.postgresql.Driver"
            url = "jdbc:postgresql://localhost/asas_flexygames"
            username = "postgres"
            password = ""
        }
    }
}
