SELECT
    start_date AS 'Start Date:Date:80',
    end_date AS 'End Date:Date:80',
    SUM(IF(salary_component = 'Income Tax', amount, 0)) AS 'Income Tax:Currency:120',
    SUM(IF(salary_component = 'Basic', amount, 0)) AS 'Basic Salary:Currency:120',
    SUM(IF(salary_component = 'Car Allowance', amount, 0)) AS 'Car Allowance:Currency:120',
    SUM(IF(salary_component = 'Medical Aid EE', amount, 0)) AS 'Medical Aid - Employee:Currency:120',
    SUM(IF(salary_component = 'Medical Aid ER', amount, 0)) AS 'Medical Aid - Employer:Currency:120'
FROM 
    `tabSalary Slip`
JOIN
    `tabSalary Detail`
ON
    `tabSalary Slip`.name=`tabSalary Detail`.parent
WHERE
    `tabSalary Slip`.docstatus=1 AND
    employee=%(employee)s AND 
    (start_date BETWEEN %(from_date)s AND %(to_date)s)
GROUP BY
    `tabSalary Slip`.name;
