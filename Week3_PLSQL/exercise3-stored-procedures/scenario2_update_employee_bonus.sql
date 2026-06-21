-- Scenario 2: Add a bonus percentage to the salary of every employee in a
-- given department.

CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
    p_department IN Employees.Department%TYPE,
    p_bonus_pct  IN NUMBER
) AS
BEGIN
    UPDATE Employees
    SET Salary = Salary + (Salary * p_bonus_pct / 100)
    WHERE Department = p_department;

    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No employees found in department ' || p_department || '.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' employee(s) in ' || p_department ||
            ' received a ' || p_bonus_pct || '% bonus.');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: Bonus update failed - ' || SQLERRM);
END UpdateEmployeeBonus;
/

-- Sample call:
-- BEGIN
--     UpdateEmployeeBonus('IT', 10);
-- END;
-- /
