<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CharacterCreate.aspx.cs" Inherits="DnD.CharacterCreate" %>

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
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Name</div>
    <p>
        <input id="nameField" type="text" /> &nbsp; &nbsp; &nbsp; <asp:Button ID="enterName" runat="server" Text="Enter name" OnClick="nameConfirm" />
        </p>
    </form>
<p>
        Choose Race</p>
    <p>
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


            
        </select></p>
    <p>
        Choose Class</p>
    <p>
        <select id="classSelect" name="classSelect" runat="server">
            <option value="1002">Barbarian</option>
            <option value="1003">Bard</option>
            <option value="1004">Cleric</option>
            <option value="1005">Druid</option>
            <option value="1006">Fighter</option>
            <option value="1007">Monk</option>
            <option value="1008">Paladin</option>
            <option value="1009">Ranger</option>
            <option value="1010">Rogue</option>
            <option value="1011">Sorcerer</option>
            <option value="1012">Warlock</option>
            <option value="1013">Wizard</option>
        </select></p>
    <p>
        Choose Alignment</p>
    <p>
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
            

        </select></p>
    <p>
        Choose Level</p>
    <p>
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
        </select></p>
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
