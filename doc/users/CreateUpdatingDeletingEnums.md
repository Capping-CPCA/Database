Adding/Updating/Deleting Enum Values
=====================================
There may come a time when the users of this system want to add, update, or delete certain enum values. While this is an inconvenient occurrence and may affect historical data, we need to provide a flexible way to manipulate these data types.

**NOTE**: Deleting enum values could mess with historical data. Be sure that the change to an enum is absolutely necessary.

### Adding Enum Values
Run the following query
```SQL
ALTER TYPE <YOUR_ENUM> ADD VALUE <NEW_VALUE>
```
This will add another value to an existing ENUM. Thus, if we have the following ENUM type `ice_cream_type` with the following values `['Chocolate', 'Vanilla']`. Performing the above query like this `ALTER TYPE ice_cream_type ADD VALUE 'strawberry'`, we would end up with the ENUM value set `['Chocolate', 'Vanilla', 'Strawberry']`.

### Updating Enum Values
Run the following query
```SQL
UPDATE pg_enum
SET enumlabel = <NEW_VALUE>
WHERE enumtypid = '<ENUM_NAME>'::regtype AND
      enumlabel = <OLD_VALUE>;
```
This will update an existing enum value for a specific ENUM type. That is, if we have our usual ENUM type `ice_cream_type`, with the following values `['Chocolate', 'Vanilla']` and we want to update, let's say, `'Chocolate'` to `'Choco'`. Then running the above query like this `UPDATE pg_enum
SET enumlabel = 'Choco' WHERE enumtypid = 'ice_cream_type'::regtype AND enumlabel = 'Chocolate';` will leave us with the following `ice_cream_type` values: `['Choco', 'Vanilla']` (in that order).

### Deleting Enum Values
Run the following query
```SQL
DELETE FROM pg_enum
WHERE enumtypid = '<ENUM_NAME>'::regtype AND
      enumlabel = <VALUE_WE_WANT_TO_DELETE>;
```
This will delete an existing enum value for a specific ENUM type. That is, if we have our usual ENUM type `ice_cream_type`, with the following values `['Chocolate', 'Vanilla', 'Strawberry']` and we want to delete, let's say, `'Chocolate'`. Then running the above query like this `DELETE FROM pg_enum
WHERE enumtypid = 'ice_cream_type'::regtype AND enumlabel = 'Chocolate';` will leave us with the following `ice_cream_type` values: `['Vanilla', 'Strawberry']` (in that order).
