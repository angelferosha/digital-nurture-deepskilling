-- Scenario 3: Fetch all loans and update their interest rates per a new
-- policy, using an explicit cursor with WHERE CURRENT OF.
--
-- New policy (assumed for this exercise): loans over $10,000 get a 0.5
-- percentage-point rate reduction (larger loans are lower-risk/higher
-- value customers); loans of $10,000 or under get a 0.25 percentage-point
-- increase.

DECLARE
    CURSOR UpdateLoanInterestRates IS
        SELECT LoanID, LoanAmount, InterestRate
        FROM Loans
        FOR UPDATE OF InterestRate;

    v_new_rate Loans.InterestRate%TYPE;
BEGIN
    FOR loan IN UpdateLoanInterestRates LOOP
        IF loan.LoanAmount > 10000 THEN
            v_new_rate := loan.InterestRate - 0.5;
        ELSE
            v_new_rate := loan.InterestRate + 0.25;
        END IF;

        UPDATE Loans
        SET InterestRate = v_new_rate
        WHERE CURRENT OF UpdateLoanInterestRates;
    END LOOP;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Loan interest rates updated per new policy.');
END;
/
