<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CharacterCreate.aspx.cs" Inherits="DnD.CharacterCreate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        
        #Select1 {
            width: 225px;
        }
        #Text1 {
            width: 215px;
        }
        #Select2 {
            width: 225px;
        }
        #Select3 {
            width: 225px;
        }
        #Select4 {
            width: 225px;
        }
        #Select5 {
            width: 225px;
        }
        #Select6 {
            width: 225px;
        }
        #Select7 {
            width: 225px;
        }
        #Select8 {
            width: 225px;
        }
        #nameField {
            width: 274px;
        }
        #raceSelect {
            width: 282px;
        }
        #classSelect {
            width: 293px;
        }
        #alignmentSelect {
            width: 297px;
        }
        #levelSelect {
            width: 302px;
        }
        #subclass {
            width: 296px;
        }
        #feats {
            width: 304px;
        }
        #armor {
            width: 302px;
        }
        #weapons {
            width: 300px;
        }
        table, th, td {
            border: 1px solid black;
            border-collapse: collapse;
        }
        th, td {
            padding: 15px;
        }
        .img{
            height : 54px;
            width : 50px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Name</div>
    <p>
        <input id="nameField" type="text" /> &nbsp; &nbsp; &nbsp; <asp:Button ID="enterName" runat="server" Text="Enter name" OnClick="nameConfirm" />
        </p>

        <asp:Image id="image1" runat="server"
           CssClass="img" 
           ImageAlign="left"
           ImageUrl=""/>
    
    

    <table style="width:100%">
        <tr>
            <th>
                Choose Race
                <select id="raceSelect" name="raceSelect" runat="server">
                    <option value="6">Elf: Eladrin</option>
                    <option value="7">Elf: High Elf</option>
                    <option value="8">Elf: Wood Elf</option>
                    <option value="9">Dragonborn</option>
                    <option value="10">Dwarf: Hill Dwarf</option>
                    <option value="11">Dwarf: Mountain Dwarf</option>
                    <option value="12">Gnome: Forest Gnome</option>
                    <option value="13">Gnome: Deep Gnome</option>
                    <option value="14">Gnome: Rock Gnome</option>
                    <option value="15">Half-Elf</option>
                    <option value="16">Halfling: Lightfoot</option>
                    <option value="17">Halfling: Stout</option>
                    <option value="19">Half-Orc</option>
                    <option value="20">Human</option>
                    <option value="21">Tiefling</option>
                </select></th>
            <th>
                Choose Class
                <asp:DropDownList id="classSelect" name="classSelect" runat="server" 
                AutoPostBack="true" OnSelectedIndexChanged="updateClassImg" >
                    <asp:ListItem value="1002">Barbarian</asp:ListItem>
                    <asp:ListItem value="1003">Bard</asp:ListItem>
                    <asp:ListItem value="1004">Cleric</asp:ListItem>
                    <asp:ListItem value="1005">Druid</asp:ListItem> 
                    <asp:ListItem value="1006">Fighter</asp:ListItem>
                    <asp:ListItem value="1007">Monk</asp:ListItem>
                    <asp:ListItem value="1008">Paladin</asp:ListItem>
                    <asp:ListItem value="1009">Ranger</asp:ListItem>
                    <asp:ListItem value="1010">Rogue</asp:ListItem>
                    <asp:ListItem value="1011">Sorcerer</asp:ListItem>
                    <asp:ListItem value="1012">Warlock</asp:ListItem>
                    <asp:ListItem value="1013">Wizard</asp:ListItem>
                </asp:DropDownList></th>
        </tr>
        <tr>
            <th>
                Choose Alignment
                <select id="alignmentSelect" name="alignmentSelect" runat="server">
                    <option value ="LG">Lawful Good</option>
                    <option value ="NG">Neutral Good</option>
                    <option value ="CG">Chaotic Good</option>
                    <option value ="LN">Lawful Neutral</option>
                    <option value ="NN">True Neutral</option>
                    <option value ="CN">Chaotic Neutral</option>
                    <option value ="LE">Lawful Evil</option>
                    <option value ="NE">Neutral Evil</option>
                    <option value ="CE">Chaotic Evil</option>
                </select></th>
            <th>
                Choose Level
                <select id="levelSelect" name="levelSelect" runat="server">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                    <option value="6">6</option>
                    <option value="7">7</option>
                    <option value="8">8</option>
                    <option value="9">9</option>
                    <option value="10">10</option>
                    <option value="11">11</option>
                    <option value="12">12</option>
                    <option value="13">13</option>
                    <option value="14">14</option>
                    <option value="15">15</option>
                    <option value="16">16</option>
                    <option value="17">17</option>
                    <option value="18">18</option>
                    <option value="19">19</option>
                    <option value="20">20</option>
                </select></th>
        </tr>
    </table>

</form>
    <table style="width:50%">
        <tr>
            <tr>
                <th>Abilities</th>
                <th>Brute Score</th>
                <th>Racial Bonus</th>
                <th>Final Score</th>
            </tr>
            <tr>
                <th>Strength</th>
                <th><input type="text" id="Str" name="Str"></th>
                <th><input button></th>
            </tr>
            <tr>
                <th>Dextarity</th>
                <th><input type="text" id="Dex" name="Dex"></th>
            </tr>
            <tr>
                <th>Constitution</th>
                <th><input type="text" id="Con" name="Con"></th>
            </tr>
            <tr>
                <th>Itelligence</th>
                <th><input type="text" id="Int" name="Int"></th>
            </tr>
            <tr>
                <th>Wisdom</th>
                <th><input type="text" id="Wis" name="Wis"></th>
            </tr>
            <tr>
                <th>Charisma</th>
                <th><input type="text" id="Cha" name="Cha"></th>
            </tr>

        </tr>
    </table>
        
    <p>
        Enter Abilities</p>
    <p>
        &nbsp;</p>
    <p>
        Choose subclass
    </p>
    <p>
        <select id="subclass" name="D5" runat="server">
            <option></option>
        </select></p>
    <p>
        Choose skills</p>
    <p>
        &nbsp;</p>
    <p>
        Choose feats</p>
    <p>
        <select id="feats" name="D6" runat="server">
            <option></option>
        </select></p>
    <p>
        Choose armor</p>
    <p>
        <select id="armor" name="D7" runat="server">
            <option></option>
        </select></p>
    <p>
        Choose weapons</p>
    <select id="weapons" name="D8" runat="server">
        <option></option>
    </select>
</body>
</html>
