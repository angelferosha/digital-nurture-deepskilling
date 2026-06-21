-- Scenario 1: Print a statement for each customer covering all of their
-- transactions in the current month, using an explicit cursor.

DECLARE
    CURSOR GenerateMonthlyStatements IS
        SELECT c.Name, a.AccountID, t.TransactionID, t.TransactionDate,
               t.Amount, t.TransactionType
        FROM Transactions t
        JOIN Accounts a ON t.AccountID = a.AccountID
        JOIN Customers c ON a.CustomerID = c.CustomerID
        WHERE TRUNC(t.TransactionDate, 'MM') = TRUNC(SYSDATE, 'MM')
        ORDER BY c.Name, t.TransactionDate;

    v_current_customer Customers.Name%TYPE := NULL;
BEGIN
    FOR stmt_rec IN GenerateMonthlyStatements LOOP
        IF v_current_customer IS NULL OR v_current_customer != stmt_rec.Name THEN
            DBMS_OUTPUT.PUT_LINE('--- Statement for ' || stmt_rec.Name || ' ---');
            v_current_customer := stmt_rec.Name;
        END IF;

        DBMS_OUTPUT.PUT_LINE('  Account ' || stmt_rec.AccountID || ' | ' ||
            TO_CHAR(stmt_rec.TransactionDate, 'YYYY-MM-DD') || ' | ' ||
            stmt_rec.TransactionType || ' | ' || stmt_rec.Amount);
    END LOOP;
END;
/
