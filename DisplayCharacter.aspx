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
   <div class="navbar navbar-inverse navbar-fixed-top" style="color:saddlebrown;font-family:courier;">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" runat="server" href="~/">Dungeons and Dragons Character Creator</a>
                </div>
                
                <div class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li><a runat="server" href="~/">Home</a></li>
                        <li><a runat="server" href="~/About">About</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <asp:Label ID="Label1" runat="server" Text="login"></asp:Label>
            <asp:TextBox ID="TextBoxUsername" placeholder="username" runat="server"></asp:TextBox>
            <asp:TextBox ID="TextBoxPassword" placeholder="password" TextMode="Password" runat="server"></asp:TextBox>
            <asp:PlaceHolder ID="Signin"
                runat="server"/>
            <button><a runat="server" href="~/Register">Register</a></button>
            <td><asp:Label ID="Label4" runat="server"></asp:Label></td>
            <td><asp:Label ID="Label3" runat="server"></asp:Label></td>
            <hr />
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
        <h3 style="color:saddlebrown;font-family:courier;">Race: </h3>
        <p style="color:saddlebrown;font-family:courier;" id="p27" runat="server"></p>
        <h3 style="color:saddlebrown;font-family:courier;">Class: </h3>
        <p style="color:saddlebrown;font-family:courier;" id="p28" runat="server"></p>
        <h3 style="color:saddlebrown;font-family:courier;">Hit Points: </h3>
        <p style="color:saddlebrown;font-family:courier;" id="p1" runat="server"></p>
        <h3 style="color:saddlebrown;font-family:courier;">Alignment: </h3>
        <p style="color:saddlebrown;font-family:courier;" id="align" runat="server"></p>
        <h3 style="color:saddlebrown;font-family:courier;">Experience Points: </h3>
        <p style="color:saddlebrown;font-family:courier;" id="exp" runat="server"></p>
        <h2 style="color:saddlebrown;font-family:courier;">Attributes: </h2>
        <h3 style="color:saddlebrown;font-family:courier;">Strength: </h3>
        <p style="color:saddlebrown;font-family:courier;" id="p2" runat="server"></p>
        <h3 style="color:saddlebrown;font-family:courier;">Dexterity: </h3>
        <p style="color:saddlebrown;font-family:courier;" id="p3" runat="server"></p>
        <h3 style="color:saddlebrown;font-family:courier;">Constitution: </h3>
        <p style="color:saddlebrown;font-family:courier;" id="p4" runat="server"></p>
        <h3 style="color:saddlebrown;font-family:courier;">Intelligence: </h3>
        <p style="color:saddlebrown;font-family:courier;" id="p5" runat="server"></p>
        <h3 style="color:saddlebrown;font-family:courier;">Wisdom: </h3>
        <p style="color:saddlebrown;font-family:courier;" id="p6" runat="server"></p>
        <h3 style="color:saddlebrown;font-family:courier;">Charisma: </h3>
        <p style="color:saddlebrown;font-family:courier;" id="p7" runat="server"></p>
        
        <h3 style="color:saddlebrown;font-family:courier;">Acrobatics: </h3>
        <p style="color:saddlebrown;font-family:courier;" id="p9" runat="server"></p>
        <h3 style="color:saddlebrown;font-family:courier;">Animal Handling: </h3>
        <p style="color:saddlebrown;font-family:courier;" id="p10" runat="server"></p>
        <h3 style="color:saddlebrown;font-family:courier;">Arcana: </h3>
        <p style="color:saddlebrown;font-family:courier;" id="p11" runat="server"></p>
        <h3 style="color:saddlebrown;font-family:courier;">Athletics: </h3>
        <p style="color:saddlebrown;font-family:courier;" id="p12" runat="server"></p>
        <h3 style="color:saddlebrown;font-family:courier;">Deception: </h3>
        <p style="color:saddlebrown;font-family:courier;" id="p13" runat="server"></p>
        <h3 style="color:saddlebrown;font-family:courier;">History: </h3>
        <p style="color:saddlebrown;font-family:courier;" id="p14" runat="server"></p>
        <h3 style="color:saddlebrown;font-family:courier;">Insight: </h3>
        <p style="color:saddlebrown;font-family:courier;" id="p15" runat="server"></p>
        <h3 style="color:saddlebrown;font-family:courier;">Intimidation: </h3>
        <p style="color:saddlebrown;font-family:courier;" id="p16" runat="server"></p>
        <h3 style="color:saddlebrown;font-family:courier;">Investigation: </h3>
        <p style="color:saddlebrown;font-family:courier;" id="p17" runat="server"></p>
        <h3 style="color:saddlebrown;font-family:courier;">Medicine: </h3>
        <p style="color:saddlebrown;font-family:courier;" id="p18" runat="server"></p>
        <h3 style="color:saddlebrown;font-family:courier;">Nature: </h3>
        <p style="color:saddlebrown;font-family:courier;" id="p19" runat="server"></p>
        <h3 style="color:saddlebrown;font-family:courier;">Perception: </h3>
        <p style="color:saddlebrown;font-family:courier;" id="p20" runat="server"></p>
        <h3 style="color:saddlebrown;font-family:courier;">Performance: </h3>
        <p style="color:saddlebrown;font-family:courier;" id="p21" runat="server"></p>
        <h3 style="color:saddlebrown;font-family:courier;">Persuasion: </h3>
        <p style="color:saddlebrown;font-family:courier;" id="p22" runat="server"></p>
        <h3 style="color:saddlebrown;font-family:courier;">Religion: </h3>
        <p style="color:saddlebrown;font-family:courier;" id="p23" runat="server"></p>
        <h3 style="color:saddlebrown;font-family:courier;">Sleight of Hand: </h3>
        <p style="color:saddlebrown;font-family:courier;" id="p24" runat="server"></p>
        <h3 style="color:saddlebrown;font-family:courier;">Stealth: </h3>
        <p style="color:saddlebrown;font-family:courier;" id="p25" runat="server"></p>
        <h3 style="color:saddlebrown;font-family:courier;">Survival: </h3>
        <p style="color:saddlebrown;font-family:courier;" id="p26" runat="server"></p>
        
        
        <h3 style="color:saddlebrown;font-family:courier;">Class Abilities: </h3>
        <p style="color:saddlebrown;font-family:courier;" id="p8" runat="server">Test</p>

        <h3 style="color:saddlebrown;font-family:courier;">Racial Abilities: </h3>
        <p style="color:saddlebrown;font-family:courier;" id="p29" runat="server">Test</p>

        <h3 style="color:saddlebrown;font-family:courier;">Feats: </h3>
        <p style="color:saddlebrown;font-family:courier;" id="feats" runat="server">Test</p>


  
 </form>

</body>
</html> 