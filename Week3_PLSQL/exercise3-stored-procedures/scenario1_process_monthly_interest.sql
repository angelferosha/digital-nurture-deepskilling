-- Scenario 1: Apply 1% monthly interest to all savings account balances.

CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest AS
    c_interest_rate CONSTANT NUMBER := 0.01;
BEGIN
    UPDATE Accounts
    SET Balance = Balance + (Balance * c_interest_rate),
        LastModified = SYSDATE
    WHERE AccountType = 'Savings';

    COMMIT;
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || ' savings account(s) updated with monthly interest.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: Monthly interest processing failed - ' || SQLERRM);
END ProcessMonthlyInterest;
/

-- Sample call:
-- BEGIN
--     ProcessMonthlyInterest;
-- END;
-- /
