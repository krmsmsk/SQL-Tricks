<h2 align="center">TOP</h2>

###

<div align="center">
  <img height="800" src="https://github.com/krmsmsk/Resimler/blob/main/SQL/5%20-%20Verileri%20Ke%C5%9Ffetme.png?raw=true"  />
</div>

###

<p align="center">The first thing we need to do before starting the analysis is to explore the data in the tables we have. In this way, we know what we will encounter and we can shape our analysis accordingly.<br><br>For this I always use TOP 10 to see all columns and first 10 rows in the table.</p>

###

<h2 align="center">DISTINCT</h2>

###

<div align="center">
  <img height="800" src="https://github.com/krmsmsk/Resimler/blob/main/SQL/6%20-%20Distinct%20ile%20gruplama.png?raw=true"  />
</div>

###

<h2 align="center">GROUP BY</h2>

###

<div align="center">
  <img height="800" src="https://github.com/krmsmsk/Resimler/blob/main/SQL/6.1%20-%20GroupBy%20ile%20gruplama.png?raw=true"  />
</div>

###

<p align="center">If there is a column that I want to specifically look at. I can group them with DISTINCT and GROUP BY. We can look at them as I show in the images above.</p>

###

<h2 align="center">COUNT()</h2>

###

<div align="center">
  <img height="800" src="https://github.com/krmsmsk/Resimler/blob/main/SQL/7%20-%20Sat%C4%B1r%20Sayd%C4%B1rma%20&%20Uniqe%20Sat%C4%B1rlar.png?raw=true"  />
</div>

###

<p align="center">If we want to see how many rows the table consists of, we can use the COUNT(*) function. If the table is not created properly, there may be duplicate data inside. For such cases, if you want to see how many unique rows there are in total, we can use DISTINCT COUNT(*). So, as you can see, we count the rows with the COUNT() function. * selects all columns, instead we can select a specific column and count the number of times a specific value occurs with the WHERE criterion. For example, if we want to check how many times Data Scientist is mentioned in the table, we can use the following query;<br><br>SELECT COUNT(JOB_TITLE) AS TITLE FROM Data_Scientist_Salaries WHERE JOB_TITLE = 'Data Scientist'</p>

###
