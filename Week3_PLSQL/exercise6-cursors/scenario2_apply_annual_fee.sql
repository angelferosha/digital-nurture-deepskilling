-- Scenario 2: Deduct an annual maintenance fee from every account, using
-- an explicit cursor with WHERE CURRENT OF.

DECLARE
    c_annual_fee CONSTANT NUMBER := 25;

    CURSOR ApplyAnnualFee IS
        SELECT AccountID, Balance
        FROM Accounts
        FOR UPDATE OF Balance;
BEGIN
    FOR acct IN ApplyAnnualFee LOOP
        UPDATE Accounts
        SET Balance = Balance - c_annual_fee,
            LastModified = SYSDATE
        WHERE CURRENT OF ApplyAnnualFee;
    END LOOP;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Annual fee of ' || c_annual_fee || ' applied to all accounts.');
END;
/
