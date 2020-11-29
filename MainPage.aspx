<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MainPage.aspx.cs" Inherits="DnD.MainPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        body {background-color: khaki;}
        a:link{
            color:saddlebrown;
        }
        a:visited{
            color:saddlebrown;
        }
        .button
        {
            background-color:darkkhaki;
            border:2px solid black;
            border-radius: 4px;
            text-align:center;
            height:35px;
            width:150px;
            font-size:15px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
  

    <h2 style="color:saddlebrown;font-family:courier;text-align:center;">Dungeons and Dragons Character Creator</h2>
        <h4 style="color:saddlebrown;font-family:courier;text-align:center;"> Welcome! Please choose to login in to a previously created account or register for a new account.</h4>
    <p style="text-align:center;">
        <button class="button", onclick=""> Click here to Login!</button>
        <h4 style="color:saddlebrown;font-family:courier;text-align:center;"><a href=""> Click here to register for an account.</a></h4>
    </p>

<!--
<p>Choose a Class</p>
    <asp:DropDownList id="ClassChoice" name="ClassChoice" runat="server">
    <asp:ListItem selected="True" Value="none">Nothing</asp:ListItem>
    <asp:ListItem value ="Barbarian">Barbarian</asp:ListItem>
    <asp:ListItem value ="Bard">Bard</asp:ListItem>
    <asp:ListItem value ="Rogue">Rogue</asp:ListItem>
    <asp:ListItem value ="Ranger">Ranger</asp:ListItem>
    </asp:DropDownList> 
<p><asp:PlaceHolder ID="ControlContainer" runat="server" /></p>
        <br />
</form>
<h3>Result:</h3>
    <asp:PlaceHolder ID="Output" runat="server" />
    
-->
 </form>

</body>
</html>
