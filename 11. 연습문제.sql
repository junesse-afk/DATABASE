use hr;

SELECT department_id, MIN(salary) AS min_salary
FROM employees
GROUP BY department_id
HAVING AVG(salary) = (
    SELECT MAX(avg_salary)
    FROM (
        SELECT AVG(salary) AS avg_salary
        FROM employees
        GROUP BY department_id
  )AS avg_salaries);
  
  desc employees;
  
  select e.department_id, d.department_name, count(employee_id)
  from employees e right join departments d
  on e.department_id = d.department_id
  group by e.department_id, d.department_name
  having count(employee_id) > 3;