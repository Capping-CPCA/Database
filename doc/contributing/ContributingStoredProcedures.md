Contributing Stored Procedures
=====================================

#### Commenting
- Header
```java
/**
 * <NAME_OF_FUNCTION>
 *   <DESCRIPTION_OF_FUNCTION>
 *
 * @params <FUNCTION_PARAMETERS>
 * @returns <FUNCTION_RETURN_TYPE>
 * @author <FUNCTION_AUTHOR(S)>
 * [@tested || @untested]
 */
```

When contributing functions in Postgres...
- Keep in mind that all commenting should be meaningful.
  - In other words, explain the `WHY` not the `WHAT`
  - Work the developer through the logic of your procedure so that they will understand
