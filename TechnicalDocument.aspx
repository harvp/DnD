<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TechnicalDocument.aspx.cs" Inherits="DnD.TechnicalDocument" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style> body {background-color: khaki;} </style>
</head>
<body>
    <form id="form1" runat="server">
        <h3 style="color:saddlebrown;font-family:courier;text-align:center;">Dungeons and Dragons Character Creator</h3>
        <h2 style="color:saddlebrown;font-family:courier;text-align:center;">Technical Document</h2>
        <p style="color:saddlebrown;font-family:courier;text-align:center;">
            Our app is a series of web pages built using the ASP.Net framework and utilizes a Microsoft Azure SQL 
            Database. The database has 27 different tables that are roughly divided into two categories - data 
            from the rules of Dungeons and Dragons regarding character creation, and tables storing characters 
            that the user has created and which values from the rules tables apply to the character. Our web 
            pages use code behind pages in C# that manage event handlers, interfacing with the SQL database, 
            and event driven business logic. Our login system utilizes cookies to track which user is logged 
            in and access the characters that user has created. The main display of the web pages are made with HTML.
 <br />
            Our project had several areas that required substantial effort. Our individual contributions per area were:  <br />
            Database design and creation: Faith 30 % Sean % Harvey 70%  <br />
            Data insertion: Faith 50 % Sean % Harvey 50%  <br />
            Login system and user tracking via cookies: Faith 0% Sean 0% Harvey 100%  <br />
            Character Creation page: Faith 10% Sean 80% Harvey 10%  <br />
            Character display page: Faith 50% Sean 0% Harvey 50%  <br />
            Online help page: Faith 100 % Sean 0% Harvey 0%  <br />
            Main page: Faith 100 % Sean 0% Harvey 0%  <br />
            About page: Faith 100% Sean 0% Harvey 0%  <br />
            Technical document: Faith 100% Sean 0% Harvey 0%  <br />
            Preparing PowerPoint presentation: Faith 70 % Sean 30% Harvey 0%  <br />
            Preparing Report: Faith 50 % Sean 0% Harvey 50% <br />
            Video: Sean 100% <br />


        </p>
    </form>
</body>
</html>
