-- Scenario 2: Group employee-related procedures and functions into a package.
-- Assumption: Employees.Salary is stored as a monthly figure, so
-- CalculateAnnualSalary multiplies by 12.

CREATE OR REPLACE PACKAGE EmployeeManagement AS
    PROCEDURE HireEmployee (
        p_employee_id IN Employees.EmployeeID%TYPE,
        p_name        IN Employees.Name%TYPE,
        p_position    IN Employees.Position%TYPE,
        p_salary      IN Employees.Salary%TYPE,
        p_department  IN Employees.Department%TYPE
    );

    PROCEDURE UpdateEmployeeDetails (
        p_employee_id IN Employees.EmployeeID%TYPE,
        p_position    IN Employees.Position%TYPE DEFAULT NULL,
        p_department  IN Employees.Department%TYPE DEFAULT NULL
    );

    FUNCTION CalculateAnnualSalary (
        p_employee_id IN Employees.EmployeeID%TYPE
    ) RETURN NUMBER;
END EmployeeManagement;
/

CREATE OR REPLACE PACKAGE BODY EmployeeManagement AS

    PROCEDURE HireEmployee (
        p_employee_id IN Employees.EmployeeID%TYPE,
        p_name        IN Employees.Name%TYPE,
        p_position    IN Employees.Position%TYPE,
        p_salary      IN Employees.Salary%TYPE,
        p_department  IN Employees.Department%TYPE
    ) IS
    BEGIN
        INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
        VALUES (p_employee_id, p_name, p_position, p_salary, p_department, SYSDATE);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Employee ' || p_employee_id || ' hired.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Error: Employee ID ' || p_employee_id || ' already exists.');
    END HireEmployee;

    PROCEDURE UpdateEmployeeDetails (
        p_employee_id IN Employees.EmployeeID%TYPE,
        p_position    IN Employees.Position%TYPE DEFAULT NULL,
        p_department  IN Employees.Department%TYPE DEFAULT NULL
    ) IS
    BEGIN
        UPDATE Employees
        SET Position = NVL(p_position, Position),
            Department = NVL(p_department, Department)
        WHERE EmployeeID = p_employee_id;

        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Error: Employee ID ' || p_employee_id || ' not found.');
        ELSE
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Employee ' || p_employee_id || ' updated.');
        END IF;
    END UpdateEmployeeDetails;

    FUNCTION CalculateAnnualSalary (
        p_employee_id IN Employees.EmployeeID%TYPE
    ) RETURN NUMBER IS
        v_monthly_salary Employees.Salary%TYPE;
    BEGIN
        SELECT Salary INTO v_monthly_salary
        FROM Employees
        WHERE EmployeeID = p_employee_id;
        RETURN v_monthly_salary * 12;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
    END CalculateAnnualSalary;

END EmployeeManagement;
/

-- Sample calls:
-- BEGIN
--     EmployeeManagement.HireEmployee(3, 'Sam Lee', 'Analyst', 5000, 'Finance');
--     EmployeeManagement.UpdateEmployeeDetails(3, p_department => 'Operations');
-- END;
-- /
-- SELECT EmployeeManagement.CalculateAnnualSalary(3) FROM DUAL;
