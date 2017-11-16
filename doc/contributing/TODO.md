TODO
=================================================

### Improvements
- Form Generation
  - The biggest problem with this database (as great as it is) is that it is made to fit the imperfections of the organization it was built to satisfy. Ideally, we could make the database more normalized and better tailored to the ACID test. Thus, from these "ideal" entities we could auto-generate the forms for the CPCA.
    - Example: Sometimes the CPCA will have the wrong field types for certain questions on forms. One example is on attendance, they have a text field (in their handout form) for things like race and sex, when those fields are clearly `ENUM` types. What we mean by that is that, the user (person filling out the form) should not have to write the field in text, they should circle based on "set" choices. This way we can fully control the data types that come in and out of the database, overall making it an easier system to manage.
  - Thus, on of the focusses for future updates should be **dynamic form generation**.
  - This also allows us to store `DOB` instead of age. You should NEVER store age, always `DOB`.
