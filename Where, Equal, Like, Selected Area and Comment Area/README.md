<h2 align="center">Where, Equal, Like, Selected Area and Comment Area</h2>

###

<div align="center">
  <img height="1000" src="https://github.com/krmsmsk/Resimler/blob/main/SQL/8%20-%20Where,%20Equal,%20Like,%20Selected%20Area%20and%20Comment%20Area.png?raw=true"  />
</div>

###

<h3 align="left">- Comment Area,</h3>

###

<p align="left">If you use "--" or "/* comment */" you will see your writings turned green. This mean is these writings are comment rows. So when you execute your query these area will not process. In this way, you can add some explanations to your codes. Actually, you MUST add :)</p>

###

<h3 align="left">- WHERE,</h3>

###

<p align="left">When we need to filter our data, we use where.</p>

###

<h3 align="left">- LIKE and Equal,</h3>

###

<p align="left">When we looking for some specific things, we can use "=" or LIKE. Actually "=" is more performance then LIKE, so I am suggest to use "=" operator. The point you should pay attention to here is, These operators perform one-to-one matching, so you should not make any typos.<br><br>LIKE can be used in a few different ways;<br>+ Select all customers that starts with the letter "a" : CustomerName LIKE 'a%'<br>+ Select all customers that containing the letter a : CustomerName LIKE '%a%'<br>+ Select all customers that finish with the letter "a" : CustomerName LIKE '%a'<br>+ Return all customers from a city that starts with 'L' followed by one wildcard character, then 'nd' and then two wildcard characters : city LIKE 'L_nd__'<br>It can be any character or number, but each _ represents one, and only one, character.</p>

###

<h3 align="left">- Selected Area,</h3>

###

<p align="left">If you select a field in the query you wrote, as in the screenshot, and run the query, only the query in the field you selected will execute. If you execute it without selecting any query on a screen with more than one query, as in the screenshot above, all queries will be execute one by one, as in the picture below.</p>

###

<div align="center">
  <img height="1000" src="https://github.com/krmsmsk/Resimler/blob/main/SQL/8.1%20-%20Two%20query.png?raw=true"  />
</div>

###
