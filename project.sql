select * from BankStatements

---Standardize the date format

select Date, CONVERT(date,date) 
from BankStatements

alter table BankStatements
add DateConverted date;

Update BankStatements
Set DateConverted = CONVERT(date,date) 

alter table BankStatements
drop Column Date;

--- Amount sent to Dad
select DateConverted, COUNT(FinalNarration) as TotalTransactions, SUM(Debit) as TotalAmountSent
from BankStatements
where FinalNarration like '%durgesh ahuja%' or FinalNarration like 'UPI-MOB-336411948298-Paymentfrom PhonePe' --- since i have two different bank accounts the final narration varies
group by DateConverted

---Highest number of UPI transactions to and from a single person (Name can be analysed by seeing excel data)
SELECT
    DateConverted,
    COUNT(FinalNarration) AS Transactions,
    COUNT(credit) AS CreditCount,
    COUNT(Debit) AS DebitCount,
    ISNULL(SUM(CAST(credit AS INT)), 0) AS SumOfCredit,
    ISNULL(SUM(CAST(debit AS INT)), 0) AS SumOfDebit
FROM
    BankStatements
WHERE
    FinalNarration LIKE '%sohil%'
GROUP BY
    DateConverted;

---Total UPI payments (credit and Debit)
SELECT
    DateConverted,
    COUNT(FinalNarration) AS Transactions,
    COUNT(credit) AS CreditCount,
    COUNT(Debit) AS DebitCount,
    ISNULL(SUM(CAST(credit AS DECIMAL(10, 2))), 0) AS SumOfCredit,
    ISNULL(SUM(CAST(debit AS DECIMAL(10, 2))), 0) AS SumOfDebit
FROM
    BankStatements
WHERE
    FinalNarration LIKE '%UPI%'
GROUP BY
    DateConverted;

---Total non UPI payments
SELECT
    DateConverted,
    COUNT(FinalNarration) AS Transactions,
    COUNT(credit) AS CreditCount,
    COUNT(Debit) AS DebitCount,
    ISNULL(SUM(CAST(credit AS DECIMAL(10, 2))), 0) AS SumOfCredit,
    ISNULL(SUM(CAST(debit AS DECIMAL(10, 2))), 0) AS SumOfDebit
FROM
    BankStatements
WHERE
    FinalNarration not like '%UPI%'
GROUP BY
    DateConverted;

---Most and least number of bank balances for the first 5 months
select COUNT(credit) as TotalCredits, COUNT(Debit) as TotalDebits, SUM(cast(Credit as decimal(10, 2))) as BalanceForJan
from BankStatements
where DateConverted like '%01%'
select COUNT(credit) as TotalCredits, COUNT(Debit) as TotalDebits, SUM(cast(Credit as decimal(10, 2))) as BalanceForFeb
from BankStatements
where DateConverted like '%02%'
select COUNT(credit) as TotalCredits, COUNT(Debit) as TotalDebits, SUM(cast(Credit as decimal(10, 2))) as BalanceForMarch
from BankStatements
where DateConverted like '%03%'
select COUNT(credit) as TotalCredits, COUNT(Debit) as TotalDebits, SUM(cast(Credit as decimal(10, 2))) as BalanceForApril
from BankStatements
where DateConverted like '%04%'
select COUNT(credit) as TotalCredits, COUNT(Debit) as TotalDebits, SUM(cast(Credit as decimal(10, 2))) as BalanceForMay
from BankStatements
where DateConverted like '%05%'

--Salary from work
select DateConverted, COUNT(FinalNarration) as TotalTransactions, SUM(cast(Credit as int)) as Salary
from BankStatements
where FinalNarration like '%Amazondevelcenti%'
group by DateConverted
