-- Scenario 3: Return TRUE if an account has at least the specified amount.
-- Note: PL/SQL BOOLEAN can't be SELECTed in plain SQL, so this function is
-- called from a PL/SQL block (see sample call below).

CREATE OR REPLACE FUNCTION HasSufficientBalance (
    p_account_id IN Accounts.AccountID%TYPE,
    p_amount     IN NUMBER
) RETURN BOOLEAN
AS
    v_balance Accounts.Balance%TYPE;
BEGIN
    SELECT Balance INTO v_balance
    FROM Accounts
    WHERE AccountID = p_account_id;

    RETURN v_balance >= p_amount;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN FALSE;
END HasSufficientBalance;
/

-- Sample call:
-- BEGIN
--     IF HasSufficientBalance(1, 500) THEN
--         DBMS_OUTPUT.PUT_LINE('Sufficient balance.');
--     ELSE
--         DBMS_OUTPUT.PUT_LINE('Insufficient balance.');
--     END IF;
-- END;
-- /
