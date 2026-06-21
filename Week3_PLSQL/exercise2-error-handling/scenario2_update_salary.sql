-- Scenario 2: Increase an employee's salary by a percentage; log an error
-- if the employee ID does not exist.

CREATE OR REPLACE PROCEDURE UpdateSalary (
    p_employee_id IN Employees.EmployeeID%TYPE,
    p_percentage  IN NUMBER
) AS
    v_current_salary Employees.Salary%TYPE;
BEGIN
    SELECT Salary INTO v_current_salary
    FROM Employees
    WHERE EmployeeID = p_employee_id;

    UPDATE Employees
    SET Salary = Salary + (Salary * p_percentage / 100)
    WHERE EmployeeID = p_employee_id;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Salary updated successfully for employee ' || p_employee_id || '.');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Employee ID ' || p_employee_id || ' does not exist.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: Salary update failed - ' || SQLERRM);
END UpdateSalary;
/

-- Sample call:
-- BEGIN
--     UpdateSalary(1, 5);
-- END;
-- /
