###Connecting to DB with Jetbrains / PHPStorm

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
