<h3 align="center"> SQL Fonksiyonları Nedir?</h3>

###

<p align="left">SQL fonksiyonları, SQL sorgularınıza belirli işlemleri veya hesaplamaları uygulamak için kullanılan özel işlevlerdir. Sorguladığınızda verileri dönüştürmek, gruplamak, filtrelemek veya hesaplamak gibi görevlerde oldukça kullanışlıdır. Sürekli olarak hesaplamanız gereken değerleri bir kez hesaplayıp, daha sonra defalarca kez kullanmanıza olanak tanır.<br><br>SQL fonksiyonları iki ana kategoriye ayrılabilir: yerleşik (built-in) fonksiyonlar ve kullanıcı tanımlı fonksiyonlar. Yerleşik fonksiyonlar, verileri işlemek ve dönüştürmek için standart olarak sunulan fonksiyonlardır. Örneğin, SUM, AVG, MAX, MIN, COUNT, DATEPART, CONCAT, ve UPPER gibi sık kullanılan SQL fonksiyonlarıdır. Kullanıcı tanımlı fonksiyonlar ise, kullanıcılar tarafından özelleştirilebilen ve veritabanı yönetimi için belirli işlevleri yerine getiren fonksiyonlardır.<br><br>SQL fonksiyonları, veritabanlarının verilerini daha anlamlı ve işlenebilir hale getirmek için kullanılır. Örneğin, bir veri tabanında kişilerin doğum tarihlerini saklıyorsanız, SQL fonksiyonları ile bu verileri yaşa dönüştürebilirsiniz. Ayrıca, SQL fonksiyonları ile verileri sıralayabilir, gruplayabilir ve filtreleyebilirsiniz.<br><br>Özellikle iki tür fonksiyona dikkat etmemiz gerekir:<br><br>1- Table-Valued Functions (Tablo Değerli Fonksiyonlar), veritabanında bir tablo gibi davranan ve sonuç kümesi olarak tablo verileri döndüren fonksiyonlardır. Örneğin, bir tablo değerli fonksiyon kullanarak belirli bir kritere göre bir veritabanı tablosundan belirli sütunları veya satırları alabilir ve bunları sonuç olarak bir tablo olarak döndürebilirsiniz.<br><br>2- Scalar-Valued Functions, veritabanındaki verileri dönüştürmek ve hesaplamak için kullanılır. Örneğin, kişilerin doğum tarihlerini içeren bir veritabanı tablonuz varsa, Scalar-Valued Functions kullanarak bu tarihleri yaşa dönüştürebilirsiniz. Bu fonksiyon, her bir kişinin doğum tarihini alır, şu anki tarihi (veya başka bir tarihi) çıkarır ve kişinin yaşını hesaplar. Bu yaş bilgisini kullanarak daha sonra yaşa bağlı sorgular veya raporlar oluşturabilirsiniz.</p>

###

<p align="center">-----------------------------------------------------------------------------------------------------</p>

###

<h3 align="center"> What Are SQL Functions?</h3>

###

<p align="left">SQL functions are special functions used to apply specific operations or calculations to your SQL queries. SQL functions are very useful for tasks such as transforming, grouping, filtering, or calculating the data you query.<br><br>SQL functions can be divided into two main categories: built-in functions and user-defined functions. Built-in functions are functions that are provided as standard for processing and transforming data. For example, commonly used SQL functions include SUM, AVG, MAX, MIN, COUNT, DATEPART, CONCAT, and UPPER. User-defined functions, on the other hand, are functions that can be customized by users and perform specific tasks for database management.<br><br>SQL functions are used to make the data in databases more meaningful and manageable. For example, if you store people's birthdates in a database, you can use SQL functions to calculate their ages. Additionally, SQL functions can be used to sort, group, and filter data.<br><br>SQL functions play a crucial role in simplifying data manipulation and processing within a database, making it an essential tool for anyone working with relational databases. Whether you are retrieving, transforming, or aggregating data, SQL functions provide the necessary functionality to work with your data effectively.<br><br>We need to pay particular attention to two types of functions:<br><br>1- Table-Valued Functions are functions that act like a table in the database and return table data as a result set. For example, using a table-valued function you can retrieve specific columns or rows from a database table based on certain criteria and return them as a table as a result.<br><br>2- Scalar-Valued Functions in SQL are used to transform and calculate data in the database. For example, if you have a database table containing people's birth dates, you can convert these dates to ages using Scalar-Valued Functions. This function takes each person's birth date, subtracts the current date (or another date), and calculates the person's age. Using this age information, you can then create age-based queries or reports.</p>

###

<p align="center">-----------------------------------------------------------------------------------------------------</p>

###

<p align="center">Aşağıdaki Scaler-Valued Function 'a örnek olarak iş günlerini hesapladığım bir fonksiyon örneğine göz atabilirsiniz.</p>

###

<p align="center">You can take a look at the Scalar-Valued Function below, an example of a function where I calculate business days.</p>

###

<div align="center">
  <img height="400" src="https://github.com/krmsmsk/Resimler/blob/main/SQL/Tatil%20G%C3%BCnleri.png?raw=true"  />
</div>

###

<p align="center">Yukarıda TATIL_GUNLERI adlı tablonun içeriğini görebilirsiniz. Her yılın özel günlerini içeriyor. Aşağıda ise resmi iş günlerini hesaplattığım fonksiyonu inceleyebilirsiniz.</p>

###

<p align="center">You can see the properties of the table named TATIL_GUNLERI above. It includes special days of each year. Below you can examine the function that allows me to calculate official business days.</p>

###

<div align="center">
  <img height="700" src="https://github.com/krmsmsk/Resimler/blob/main/SQL/%C4%B0%C5%9F%20G%C3%BCnleri%20Hesap.png?raw=true"  />
</div>

###
