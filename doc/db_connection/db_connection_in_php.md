###Connecting to DB

[database_icon]: https://github.com/Capping-CPCA/Attendance-App/blob/Scott_PHP/PHP_App/Documentation/db_connection_pictures/database_icon.png
[plus_sign]: https://github.com/Capping-CPCA/Attendance-App/blob/Scott_PHP/PHP_App/Documentation/db_connection_pictures/plus_sign.png
[postgres_select_cropped]: https://github.com/Capping-CPCA/Attendance-App/blob/Scott_PHP/PHP_App/Documentation/db_connection_pictures/postgres_select_cropped.png
[schemas]: https://github.com/Capping-CPCA/Attendance-App/blob/Scott_PHP/PHP_App/Documentation/db_connection_pictures/scemas.png
[settings]: https://github.com/Capping-CPCA/Attendance-App/blob/Scott_PHP/PHP_App/Documentation/db_connection_pictures/settings.png

**Connection Configuration**

This is a basic postgres connection. You will need to have postgres installed on your 
computer for this to work.

If you have PHPstorm, you may need to add the data source by 
- clicking database
on the right side of your computer screen

![database icon][database_icon]
- clicking the '+' sign

![plus sign][plus_sign]
- hovering over the data source and selecting postgres sql

![select postgres][postgres_select_cropped]

After this, you can enter in the details as follows:
- Host: 10.11.12.21
- Port: 5432
- Database: postgres
- User: postgres
- Password: (refer to other documentation for actual password)

![sample information][settings]

Now, click test connection.

If your connection is good, then do the following:
- click the 'schemas tab' and select all of the appropriate schemas.

![schema selection][schemas]

- You may also get a warning message asking you to import database drivers.
In this event, just import your database drivers.

#####Test connection file
```php
#public static $raw_password = "[db password here]";
require('password.php');

$hostaddress = "hostaddr=10.11.12.21 ";
$port = "port=5432 ";
$name = "dbname=postgres ";
$user = "user=postgres ";
//password stored in password file not tracked by git
$password = "password=" . password::$raw_password;

$conn_string = $hostaddress . $port . $name . $user . $password;

echo $conn_string;


$db_conn = pg_connect($conn_string)
    or die('Wrong connection string or db cannot be reached');

echo('Connected successfully');

pg_close($db_conn);

```

#####Password file (don't track this on git!)

set it up in the directory: `/core/util`
```php
<?php

//class to hold the raw password of the db untracked on git
class password
{
    public static $raw_password = "[change this to actual password]";
}
```

To make sure it does not get tracked on git, go to your project root in git
and add or edit the file `.gitignore`. Then add this to a new line: `*password.php`.


**Errors**

If you're getting the error message 'Fatal error: Call to undefined function pg_connect()', 
then the postgres drivers may not be configured correctly on your computer.

Refer to this article to help you out: 
https://stackoverflow.com/questions/7438059/fatal-error-call-to-undefined-function-pg-connect/7460079#7460079

Make sure to adapt it so that you are configuring it with the latest version of php and
not PHP5.