# PL/SQL Banking Exercises

Solutions to 7 hands-on PL/SQL exercises (Control Structures, Error Handling, Stored
Procedures, Functions, Triggers, Cursors, Packages) built around a simple banking schema.

## Setup

Run these once, in order, in your Oracle environment (SQL*Plus, SQL Developer, etc.):

```sql
@schema.sql
@sample_data.sql
```

`schema.sql` includes two small additions beyond the original spec, needed by later
exercises:
- `Customers.IsVIP` — used by Exercise 1, Scenario 2
- `AuditLog` table — used by Exercise 5, Scenario 2

Each exercise script is self-contained after that — just run it with `@filename.sql`
(or paste into your SQL tool) in any order, since procedures/functions/triggers don't
depend on each other except where noted.

`SET SERVEROUTPUT ON` first if you want to see `DBMS_OUTPUT.PUT_LINE` messages.

---

## Exercise 1: Control Structures

**Folder:** `exercise1-control-structures`

Anonymous PL/SQL blocks using `FOR` loop cursors and `IF` conditionals:
- **Scenario 1** — loops through `Customers`, computes age from `DOB` with
  `MONTHS_BETWEEN`, and applies a 1% discount to `Loans.InterestRate` for anyone
  over 60.
- **Scenario 2** — loops through `Customers` and sets `IsVIP` to `'Y'`/`'N'` based on
  whether `Balance` exceeds $10,000.
- **Scenario 3** — fetches loans with `EndDate` in the next 30 days and prints a
  reminder for each.

---

## Exercise 2: Error Handling

**Folder:** `exercise2-error-handling`

Stored procedures with explicit and built-in exception handling, rollback on failure:
- **Scenario 1** — `SafeTransferFunds` locks the source row with `FOR UPDATE`, raises
  a custom exception on insufficient funds, and catches `NO_DATA_FOUND` /
  `OTHERS` for missing accounts or unexpected errors.
- **Scenario 2** — `UpdateSalary` catches `NO_DATA_FOUND` when the employee ID
  doesn't exist.
- **Scenario 3** — `AddNewCustomer` catches `DUP_VAL_ON_INDEX` (the primary key
  violation) to prevent inserting a duplicate customer.

---

## Exercise 3: Stored Procedures

**Folder:** `exercise3-stored-procedures`

- **Scenario 1** — `ProcessMonthlyInterest` applies 1% interest to every `Savings`
  account in a single set-based `UPDATE`.
- **Scenario 2** — `UpdateEmployeeBonus(department, bonus_pct)` raises every
  employee's salary in a department by a given percentage.
- **Scenario 3** — `TransferFunds` checks the source balance before moving money
  between two accounts.

---

## Exercise 4: Functions

**Folder:** `exercise4-functions`

- **Scenario 1** — `CalculateAge(dob)` returns age in years via `MONTHS_BETWEEN`.
- **Scenario 2** — `CalculateMonthlyInstallment(loan_amount, interest_rate, years)`
  implements the standard amortization formula
  `M = P·r·(1+r)ⁿ / ((1+r)ⁿ − 1)`.
- **Scenario 3** — `HasSufficientBalance(account_id, amount)` returns a `BOOLEAN`.
  Since PL/SQL `BOOLEAN` can't be `SELECT`ed directly in SQL, it's called from a
  PL/SQL block (shown in the file).

---

## Exercise 5: Triggers

**Folder:** `exercise5-triggers`

- **Scenario 1** — `UpdateCustomerLastModified`: `BEFORE UPDATE` row-level trigger
  that stamps `:NEW.LastModified := SYSDATE`.
- **Scenario 2** — `LogTransaction`: `AFTER INSERT` row-level trigger that writes an
  entry to `AuditLog` for every new transaction.
- **Scenario 3** — `CheckTransactionRules`: `BEFORE INSERT` row-level trigger that
  rejects withdrawals exceeding the account balance and non-positive deposit/withdrawal
  amounts via `RAISE_APPLICATION_ERROR`.

---

## Exercise 6: Cursors

**Folder:** `exercise6-cursors`

Explicit cursors, as the exercise specifically asks for:
- **Scenario 1** — `GenerateMonthlyStatements` joins `Transactions` → `Accounts` →
  `Customers`, filters to the current month, and prints a grouped statement per
  customer.
- **Scenario 2** — `ApplyAnnualFee` uses `FOR UPDATE` + `WHERE CURRENT OF` to deduct a
  flat annual fee from every account.
- **Scenario 3** — `UpdateLoanInterestRates` uses `FOR UPDATE` + `WHERE CURRENT OF` to
  re-rate every loan under an example policy (documented in the file: large loans get
  a rate cut, smaller loans get a rate increase — adjust the policy logic to match
  your actual requirements).

---

## Exercise 7: Packages

**Folder:** `exercise7-packages`

Each file contains both the package spec and body:
- **Scenario 1** — `CustomerManagement`: `AddCustomer`, `UpdateCustomerDetails`,
  `GetCustomerBalance`.
- **Scenario 2** — `EmployeeManagement`: `HireEmployee`, `UpdateEmployeeDetails`,
  `CalculateAnnualSalary` (assumes `Employees.Salary` is stored monthly).
- **Scenario 3** — `AccountOperations`: `OpenAccount`, `CloseAccount` (refuses to
  close a non-zero-balance account), `GetTotalBalance` (sums all of a customer's
  accounts).

---

## Repo structure

```
.
├── schema.sql
├── sample_data.sql
├── exercise1-control-structures/
├── exercise2-error-handling/
├── exercise3-stored-procedures/
├── exercise4-functions/
├── exercise5-triggers/
├── exercise6-cursors/
└── exercise7-packages/
```
