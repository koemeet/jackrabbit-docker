## Jackrabbit Docker image
It runs inside Tomcat as a webapp on port `8080`. 


### Configuration
You can provide your own `repository.xml` configuration, you can do this by creating a volume at the
path `/opt/jackrabbit/repository.template.xml`. In here you can access environment variables by using `${ENV.VAR_NAME}`.
This file will be parsed and the output will be placed at `/opt/jackrabbit/repository.xml` automatically.

To configure a MySQL persistence manager using environment variables, you can do something like:

```xml
<PersistenceManager class="org.apache.jackrabbit.core.persistence.pool.MySqlPersistenceManager">
    <param name="driver" value="com.mysql.jdbc.Driver"/>
    <param name="url" value="jdbc:mysql://${ENV.DATABASE_HOST}:${ENV.DATABASE_PORT}/${ENV.DATABASE_NAME}"/>
    <param name="user" value="${ENV.DATABASE_USER}"/>
    <param name="password" value="${ENV.DATABASE_PASS}"/>
    <param name="schema" value="mysql"/>
    <param name="schemaObjectPrefix" value="pm_ws_${wsp.name}_"/>
</PersistenceManager>
```

This way you can configure anything you like using environment variables! Have fun!
