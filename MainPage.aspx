<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MainPage.aspx.cs" Inherits="DnD.MainPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        
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



</body>
</html>
