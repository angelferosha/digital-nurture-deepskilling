-- Scenario 3: Print a reminder for every loan due within the next 30 days.

DECLARE
    CURSOR c_due_loans IS
        SELECT l.LoanID, l.EndDate, c.Name
        FROM Loans l
        JOIN Customers c ON l.CustomerID = c.CustomerID
        WHERE l.EndDate BETWEEN SYSDATE AND SYSDATE + 30;
BEGIN
    FOR loan IN c_due_loans LOOP
        DBMS_OUTPUT.PUT_LINE('Reminder: Dear ' || loan.Name ||
            ', your loan (ID: ' || loan.LoanID ||
            ') is due on ' || TO_CHAR(loan.EndDate, 'YYYY-MM-DD') || '.');
    END LOOP;
END;
/
