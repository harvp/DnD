<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MainPage.aspx.cs" Inherits="DnD.MainPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        body {background-color: khaki;}
        a.one:link, a:visited{
            background-color:darkkhaki;
            color:saddlebrown;
            border:2px solid black;
            border-radius: 4px;
            text-align:center;
            height:35px;
            width:150px;
            font-size:15px;
            text-decoration:none;
        }
        a.two:link, b:visited {
            color:saddlebrown;
        }
        .bottom{
            position:fixed;
            bottom: 0;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
  

    <h2 style="color:saddlebrown;font-family:courier;text-align:center;">Dungeons and Dragons Character Creator</h2>
        <h4 style="color:saddlebrown;font-family:courier;text-align:center;"> Welcome! Please choose to login in to a previously created account or register for a new account.</h4>
    <p style="text-align:center;"> </p>
        <h4 style="color:saddlebrown;font-family:courier;text-align:center;"><a class="one" href="Register.aspx";>Click here to Login!</a></h4>
        <h4 style="color:saddlebrown;font-family:courier;text-align:center;"><a class="two" href="Register.aspx";> Click here to register for an account.</a></h4>

 </form>

</body>
</html>
