<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DisplayCharacter.aspx.cs" Inherits="DnD.DisplayCharacter" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        body {background-color: khaki;}
    </style>
</head>
<body>
    <form id="form1" runat="server">
  
    <h2 style="color:saddlebrown;font-family:courier;text-align:center;">Dungeons and Dragons Character Creator</h2>
    <h3 style="color:saddlebrown;font-family:courier;text-align:center;"> Please select a character to display</h3>

    <p style="text-align:center;"> 
    <select id="Select1" multiple="false" runat="server"/>
    <asp:Button ID="submitButton" runat="server" Text="Submit" OnClick="submitDisplay" />
      </p>
        <h3 style="color:saddlebrown;font-family:courier;">Name: </h3>
        <p style="color:saddlebrown;font-family:courier;" id="characterName" runat="server"></p>
        <h3 style="color:saddlebrown;font-family:courier;">Player: </h3>
        <p style="color:saddlebrown;font-family:courier;" id="playerName" runat="server"></p>

  
 </form>

</body>
</html> 